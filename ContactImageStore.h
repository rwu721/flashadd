//
//  ContactImageStore.h
//  FlashAdd
//
//  Created by Ray Wu on 5/18/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (ContactImageStore *)sharedStore;

-(void)setImage:(UIImage *)i forKey:(NSString *)s;

- (UIImage *)imageForKey:(NSString *)s;

- (void)deleteImageForKey:(NSString *)s;

- (NSString *)imagePathForKey:(NSString *)key;

- (void)clearCache:(NSNotificationCenter *)note;


@end
