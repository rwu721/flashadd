//
//  ContactStore.h
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contact;

@interface ContactStore : NSObject
{
    
    NSMutableArray *allContacts;
    
}

+ (ContactStore *)sharedStore;

- (void)removeItem:(Contact *)p;

-(NSArray *)allContacts;
-(Contact *)createContact;
- (NSString *)itemArchievePath;

- (BOOL)saveChanges;




@end
