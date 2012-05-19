//
//  ContactsViewController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"

@interface ContactsViewController : UITableViewController
{
    NSArray *contactList;
}

- (void)sortContacts:(id)sender;
@end
