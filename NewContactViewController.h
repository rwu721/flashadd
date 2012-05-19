//
//  NewContactViewController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/11/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Contact.h"
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"

@interface NewContactViewController : UIViewController <UITextFieldDelegate>

{
    
     __weak IBOutlet UITextField *lastField;
    __weak IBOutlet UITextField *firstField;
    __weak IBOutlet UITextField *phoneField;
    
    __weak IBOutlet UITextField *emailField;
    CLLocationManager* locationManager;
    CLLocation *currentLocation;

    __weak IBOutlet UILabel *clockLabel;
    
    __weak IBOutlet UILabel *locationStatus;
    
}
@property(readonly, nonatomic) CLLocation *location;
//@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)Contact *nContact;
- (IBAction)backgroundTapped:(id)sender;

- (IBAction)addNewContact:(id)sender;

- (void)findLocation;

- (void)digitalClock:(NSTimer *)timer;;
@end
