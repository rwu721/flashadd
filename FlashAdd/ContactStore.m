//
//  ContactStore.m
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "ContactStore.h"
#import "Contact.h"
#import "ContactImageStore.h"

@implementation ContactStore

+ (ContactStore *)sharedStore
{
    static ContactStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchievePath];
        
        allContacts = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        //if array hadn't been saved previously, creat a new empty one
        
        if (!allContacts)
            allContacts = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)allContacts
{
    return allContacts;
}

-(Contact *)createContact
{
    Contact *p = [[Contact alloc] init];
    
    [allContacts addObject:p];
    
    return p;
}

- (void)removeItem:(Contact *)p
{
    NSString *key =[p imageKey];
    [[ContactImageStore sharedStore] deleteImageForKey:key];
    
    
    [allContacts removeObjectIdenticalTo:p];
    
}

-(NSString *)itemArchievePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"contacts.archieve"];
}

- (BOOL)saveChanges
{
    //returns success or failure
    NSString *path = [self itemArchievePath];
    return [NSKeyedArchiver archiveRootObject:allContacts toFile:path];
}
@end
