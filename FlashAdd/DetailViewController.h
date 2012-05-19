//
//  DetailViewController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationMapView.h"
#import "DetailEditViewController.h"
@class Contact;

@interface DetailViewController : UIViewController
{
    __weak IBOutlet UITextField *firstNameField;
    __weak IBOutlet UITextField *lastNameField;
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *phoneField;
    __weak IBOutlet UITextField *dateLabel;
    
    __weak IBOutlet UIImageView *imageView;
    
}


@property (nonatomic, strong) Contact *friend;

- (IBAction)showLocationCreated:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

- (void)pushEditViewController:(id)sender;

@end
