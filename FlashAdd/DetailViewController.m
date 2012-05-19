//
//  DetailViewController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "DetailViewController.h"
#import "Contact.h"
#import "ContactImageStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize friend;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
}

- (void)viewDidUnload {
    firstNameField = nil;
    lastNameField = nil;
    emailField = nil;
    phoneField = nil;
    dateLabel = nil;
    imageView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationItem]setTitle:@"Info"];
    
    //Edit button on navigation bar
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(pushEditViewController:)];
    
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [[self navigationItem]setRightBarButtonItem:editButtonItem animated:YES];

    
    [firstNameField setText:[friend firstName]];
    [lastNameField setText:[friend lastName]];
    [emailField setText:[friend emailAddress]];
    [phoneField setText:[friend mobileNumber]];
    
    firstNameField.enabled = NO;
    lastNameField.enabled = NO;
    emailField.enabled = NO;
    phoneField.enabled = NO;
   
    
   
    
    NSLog(@"%@", friend);
    
    //Create a NSDateFormatter that will turn a data into a simple date string
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    //Use filtered NSDate object to set dateLabel
    
    [dateLabel setText:[dateFormatter stringFromDate:[friend dateCreated]]];
    
     dateLabel.enabled = NO;
    
    //set picture
    NSString *imageKey = [friend imageKey];
    if (imageKey){
        //get image for imageKey from store
        UIImage *imageToDisplay = [[ContactImageStore sharedStore] imageForKey:imageKey];
        
        //use that image to put on the screen 
        [imageView setImage:imageToDisplay];
        
    }
    else{
        [imageView setImage:nil];
    }

    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //clear first responsder
    [[self view] endEditing:YES];
    
    //"save" changes o item
    [friend setFirstName:[firstNameField text]];
    [friend setLastName:[lastNameField text]];
    [friend setEmailAddress:[emailField text]];
    [friend setMobileNumber:[phoneField text]];
}

/*- (void)setFriend:(Contact *)i
{
  
    [[self navigationItem]setTitle:@"Info"];
    
}
 */
- (IBAction)showLocationCreated:(id)sender {
    
    if ([friend locationCreated]){
    
    NSLog(@"location created is %@", [friend locationCreated]);
    
    LocationMapView *mapView = [[LocationMapView alloc]initWithLocation:[friend locationCreated]];
    
    [mapView setLocationAdded:[friend locationCreated]];
    [mapView setAmigo:friend];
    
    [self presentViewController:mapView animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Location Saved" 
                                                        message:@"Please upgrade to premium version to access this feature"
                                                       delegate:nil 
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        [alert show];

    }
                                
}

- (IBAction)backgroundTapped:(id)sender {
      [[self view] endEditing:YES];
}



//- (IBAction)callPhone:(id)sender {
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://7343304210"]];
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)pushEditViewController:(id)sender {
    
    
    DetailEditViewController *editController = [[DetailEditViewController alloc]init];
    
    [editController setFriendEdit:friend];
   
    [editController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:editController animated:YES completion:nil];
    
}


@end
