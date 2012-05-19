//
//  SortViewController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/18/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactStore.h"
#import "Contact.h"
#import "ContactsViewController.h"

@interface SortViewController : UIViewController




- (IBAction)sortFirstName:(id)sender;

- (IBAction)sortLastName:(id)sender;

- (IBAction)sortFirstCreated:(id)sender;
- (IBAction)sortLastCreated:(id)sender;

- (IBAction)cancelSort:(id)sender;



@end
