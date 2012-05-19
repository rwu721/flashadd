//
//  SortViewController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/18/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "SortViewController.h"

@interface SortViewController ()

@end

@implementation SortViewController

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

- (IBAction)sortFirstName:(id)sender {
 /*   
    //NSSortDescriptor *sort
    NSSortDescriptor *sortByFirstName = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    
    //NSArray *sortDescriptor = [NSArray arrayWithObject:sortByFirstName];
    
    [[[ContactStore sharedStore]allContacts]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByFirstName]];
    
    // NSArray *contactsByFirstName = [[[ContactStore sharedStore] allContacts]sortedArrayUsingDescriptors:sortDescriptor];
    
    [self dismissModalViewControllerAnimated:YES];
*/
    
}

- (IBAction)sortLastName:(id)sender {
   
        
    
}

- (IBAction)sortFirstCreated:(id)sender {
}

- (IBAction)sortLastCreated:(id)sender {
}

- (IBAction)cancelSort:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
