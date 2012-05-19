//
//  DetailEditViewController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/16/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
//#import "UIImagePickerController.h"

@interface DetailEditViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *firstNameField;


    __weak IBOutlet UITextField *lastNameField;


    __weak IBOutlet UITextField *emailField;


    __weak IBOutlet UITextField *phoneField;

    __weak IBOutlet UIImageView *contactImage;


}
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)closeEditView:(id)sender;

- (IBAction)takePicture:(id)sender;




@property (nonatomic, strong) Contact *friendEdit;
@end
