//
//  AppInfoController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/17/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "AppInfoController.h"

@interface AppInfoController ()

@end

@implementation AppInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
            UITabBarItem *tbi = [self tabBarItem];
            
            [tbi setTitle:@"Feedback"];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self; // <- very important step if you want feedbacks on what the user did with your email sheet
    
    NSString *rayEmail = @"rwu721@gmail.com";
    NSString *timEmail = @"tdubya07@gmail.com";
    
    NSArray *emailRecipients = [NSArray arrayWithObjects:rayEmail,timEmail, nil ];
    [picker setToRecipients:emailRecipients];
    
    [picker setSubject:@"iTag App Feedback"];
    
    // Fill out the email body text
       
        [self presentModalViewController:picker animated:YES];
   
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed"                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
           // [alert release];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)giveFeedback:(id)sender {
    
    [self showEmailModalView];
}
@end
