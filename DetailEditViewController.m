//
//  DetailEditViewController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/16/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "DetailEditViewController.h"
#import "Contact.h"
#import "ContactImageStore.h"

@interface DetailEditViewController ()

@end

@implementation DetailEditViewController
@synthesize friendEdit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    firstNameField = nil;
    lastNameField = nil;
    emailField = nil;
    phoneField = nil;
    contactImage = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationItem]setTitle:@"Edit"];
    
    
    [firstNameField setText:[friendEdit firstName]];
    [lastNameField setText:[friendEdit lastName]];
    [emailField setText:[friendEdit emailAddress]];
    [phoneField setText:[friendEdit mobileNumber]];
    
    NSString *imageKey = [friendEdit imageKey];
    if (imageKey){
        //get image for imageKey from store
        UIImage *imageToDisplay = [[ContactImageStore sharedStore] imageForKey:imageKey];
        
        //use that image to put on the screen 
        [contactImage setImage:imageToDisplay];
        
    }
    else{
        [contactImage setImage:nil];
    }
    
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //clear first responsder
    [[self view] endEditing:YES];
    
    //"save" changes o item
    [friendEdit setFirstName:[firstNameField text]];
    [friendEdit setLastName:[lastNameField text]];
    [friendEdit setEmailAddress:[emailField text]];
    [friendEdit setMobileNumber:[phoneField text]];
    [friendEdit setImageKey:[friendEdit imageKey]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)backgroundTapped:(id)sender {
     [[self view] endEditing:YES];
}

- (IBAction)closeEditView:(id)sender {
      [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    //if device has camera take pic, otherwis pick from lib
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];
    
    //present modally
    [self presentViewController:imagePicker animated:YES completion:nil];    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [friendEdit imageKey];
    if (oldKey){
        //delete old image
        [[ContactImageStore sharedStore]deleteImageForKey:oldKey];
    }
    
    //get picked image from info dictornary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [friendEdit setThumbnailDataFromImage:image];
    
    //create a CFUUID object - it knows how to create unique identifier strings
    
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    //creat a string from unique id
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    //use that uique ID to set our item's imageKey
    NSString *key = (__bridge NSString *)newUniqueIDString;
    
    [friendEdit setImageKey:key];
    
    //store image in the ConactImageStore with this key
    [[ContactImageStore sharedStore]setImage:image forKey:[friendEdit imageKey]];
    
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    // Put that image onto the screen in our image view
   // [contactImage setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

@end
