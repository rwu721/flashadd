//
//  ContactImageStore.m
//  FlashAdd
//
//  Created by Ray Wu on 5/18/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "ContactImageStore.h"

@implementation ContactImageStore


+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

+ (ContactImageStore *)sharedStore
{
    static ContactImageStore *sharedStore = nil;
    
    if(!sharedStore){
        sharedStore = [[super allocWithZone:NULL]init];
    }
    return sharedStore;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    return self;
}

- (void)clearCache:(NSNotificationCenter *)note
{
    NSLog(@"flushing %d images out of the cache",[dictionary count]);
    [dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    
    //creat full path for image
    NSString *imagePath = [self imagePathForKey:s];
    //turn image into JPEG data
    NSData *d = UIImageJPEGRepresentation(i, .5);
    
    //write it to full pah
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
        //if possible get from dictionary
    UIImage *result = [dictionary objectForKey:s];
    if (!result){
        //create UIImage object from file
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        //if we found an image on the file system, place it into the cache
        
        if (result)
            [dictionary setObject:result forKey:s];
        
        else 
            NSLog(@"Error: unable to find %@", [self imagePathForKey:s]);
        
    }
        return result;
   
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s)
        return;
    [dictionary removeObjectForKey:s];
    
    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager]removeItemAtPath:path error:NULL];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
