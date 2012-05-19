//
//  NewContactViewController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/11/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "NewContactViewController.h"
#import "Contact.h"
#import "ContactStore.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "NewContactLocationController.h"


@implementation NewContactViewController
@synthesize nContact, location;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self){
        UITabBarItem *tbi = [self tabBarItem];
        
        [tbi setTitle:@"New Contact"];
        
        UIImage *i = [UIImage imageNamed:@"plus.png"];
        
        [tbi setImage:i];
        
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        
        //we want it to be as accuraate as possible 
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
       
    }
    
    return self;
}

- (void)viewDidUnload {
    lastField = nil;
    firstField = nil;
    phoneField = nil;
    emailField = nil;
    clockLabel = nil;
    locationStatus = nil;
    [super viewDidUnload];
}
- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addNewContact:(id)sender {
    
    int numDigits = 6;
    int numEmailLetters = 7;
    if ([[phoneField text] length] > numDigits || [[emailField text] length] > numEmailLetters){
        
    
    
    Contact *newContact = [[ContactStore sharedStore]createContact];
        if ([[firstField text] length] > 0)
            [newContact setFirstName:[firstField text]];
        else {
            [newContact setFirstName:@""];
        }

        if ([[lastField text] length] > 0)
            [newContact setLastName:[lastField text]];
        else {
            [newContact setLastName:@""];
        }
    [newContact setMobileNumber:[phoneField text]];
    [newContact setEmailAddress:[emailField text]];
    
    NSLog(@"%@ %@ %@ %@", [newContact firstName], [newContact lastName], [newContact mobileNumber], [newContact emailAddress]);
                           
 
    
    
  //*********************************
    //ADD to adress book 
    
    
    ABAddressBookRef ab = ABAddressBookCreate();
    
        //make new person for address book
    ABRecordRef newPerson = ABPersonCreate();
    
        //add name
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFStringRef)[firstField text], nil);
        if ([[lastField text] length] > 0){
            
        ABRecordSetValue(newPerson, kABPersonLastNameProperty, (__bridge CFStringRef)[lastField text], nil);
        }
        
      //  add phone number
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFStringRef)[phoneField text], kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone, nil);
    
    
        //add email
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFStringRef)[emailField text], kABWorkLabel, NULL);

    ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, nil);
    
        //Add new person to address book
    ABAddressBookAddRecord(ab, newPerson, nil);
    
        //save address book
    ABAddressBookSave(ab, nil);
    
    CFRelease(multiPhone);
    CFRelease(multiEmail);
        
        if (currentLocation){
            
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Saved" 
                                                        message:@"Time: Saved\n Location: Saved"
                                                       delegate:nil 
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        [alert show];
        //[alert release];
        
        
    [lastField setText:@""];
    [firstField setText:@""];
    [phoneField setText:@""];
    [emailField setText:@""];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Saved" 
                                                            message:@"Time: Saved\n Location: Not Saved"
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Done"
                                                  otherButtonTitles:nil];
            [alert show];
            //[alert release];
            
            
            [lastField setText:@""];
            [firstField setText:@""];
            [phoneField setText:@""];
            [emailField setText:@""];

        }
    
        
        //****************find location****************
        
     //   [self findLocation];
      // CLLocation *currentLocation = [[CLLocation alloc] init];
         NSLog(@"Current location is %@",currentLocation);
        
        [newContact setLocationCreated:currentLocation];
         
         

     }   
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Not Saved" 
                                                        message:@"Please Enter Correct Phone Number or Email Address"
                                                       delegate:nil 
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [[self view] endEditing:YES];
}



-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
 
    //
    NSLog(@"%@",newLocation);
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    currentLocation = newLocation;
   
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Couldnot find location %@, error", error);
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    NSLog(@"finding location2");
}

- (void)viewDidLoad
{
    [self findLocation];
    if (currentLocation)
        [locationStatus setText:@"Location: Found"];
    else {
        [locationStatus setText:@"Location: Not Found"];
    }
        
    // Timer
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(digitalClock:) userInfo:nil repeats:YES];
    
    
}

- (void)digitalClock:(NSTimer *)timer;
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
	[timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[timeFormatter setTimeStyle:NSDateFormatterMediumStyle];
	NSDate *stringTime = [NSDate date];
	NSString *formattedDateStringTime = [timeFormatter stringFromDate:stringTime];
	[clockLabel setText:formattedDateStringTime];
    if (currentLocation)
        [locationStatus setText:@"Location: Found"];
    else {
        [locationStatus setText:@"Location: Not Found"];
    }
    
	
}

- (void)dealloc 
{
    //tell the location maager to stop sending us messages
    [locationManager setDelegate:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneField){
    int length = [self getLength:textField.text];
    //NSLog(@"Length  =  %d ",length);
    
    if(length == 10)
    {
        if(range.length == 0)
            return NO;
    }
    
    if(length == 3)
    {
        NSString *num = [self formatNumber:textField.text];
        textField.text = [NSString stringWithFormat:@"(%@) ",num];
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
    }
    else if(length == 6)
    {
        NSString *num = [self formatNumber:textField.text];
        //NSLog(@"%@",[num  substringToIndex:3]);
        //NSLog(@"%@",[num substringFromIndex:3]);
        textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
    }
    
    return YES;
    }
    else return;
    
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
}


-(int)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
    
    
}
 
@end
