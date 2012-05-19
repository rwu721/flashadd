//
//  ContactsViewController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "ContactStore.h"
#import "DetailViewController.h"
#import "ContactCell.h"
#import "SortViewController.h"

@implementation ContactsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"All Contacts"];
        
        UITabBarItem *tbi = [self tabBarItem];
        
        [tbi setTitle:@"New Contact"];

    }
    
    //create a new bar button item that will send addNewItem to ItemsViewController 
    
   // UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    
    //set this bar button item as the right item in the navgationItem
    
   // [[self navigationItem] setRightBarButtonItem:bbi];
    
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc]initWithTitle:@"Sort" style:UIBarButtonItemStyleDone target:self action:@selector(sortContacts:)];
    
    [[self navigationItem] setRightBarButtonItem:sortButton];
    
    contactList = [[ContactStore sharedStore]allContacts];
    
    return self;
    
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    UITabBarItem *tbi = [self tabBarItem];
    
    [tbi setTitle:@"All Contacts"];
    
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ContactStore sharedStore] allContacts] count]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact *p = [[[ContactStore sharedStore] allContacts] objectAtIndex:[indexPath row]];
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    //configure cell
   
    //create name
    NSString *name = [NSString stringWithFormat:@"%@ %@", [p firstName], [p lastName]];
    
    //create date
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    [timeFormatter setDateStyle:NSDateFormatterNoStyle];
    
    NSString *timeString = [[NSString alloc] initWithFormat:@"%@", [timeFormatter stringFromDate:[p dateCreated]]];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dayFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *dayString = [[NSString alloc] initWithFormat:@"%@", [dayFormatter stringFromDate:[p dateCreated]]];

    
    //give cells contact info 
    
    [[cell nameLabel] setText:name];
    [[cell phoneLabel] setText:[p mobileNumber]];
    [[cell dayLabel] setText:dayString];
    [[cell timeLabel] setText:timeString];
    [[cell thumbnailView] setImage:[p thumbnail]];
    [[cell locLabel] setText:[[p locationCreated] description]];
    
    


    
    //check for a reuseable cell first
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
   // if (!cell){
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    //}
    
    //set the text on the cell wiht the description of the item that is at the nth index of items 
    //where n = row this cell will appear in on the tableview
    
   // Contact *p = [[[ContactStore sharedStore] allContacts] objectAtIndex:[indexPath row]];
    
  //  [[cell textLabel] setText:[p description]];
    
    return cell;
}



- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    //push it to the top of the navgation controller's stack 
    
    NSArray *friends = [[ContactStore sharedStore] allContacts];
    
    Contact *selectedContact = [friends objectAtIndex:[indexPath row]];
    
    //give detail view controller a pointer to the item object in row
    
    [detailViewController setFriend:selectedContact]; 
    
    NSLog(@"selected contact:%@", selectedContact);
    NSLog(@"friend:%@", [detailViewController friend]);
    
    [[self navigationController]pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if the table view is asking to commit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ContactStore *ps = [ContactStore sharedStore];
        NSArray *contacts = [ps allContacts];
        Contact *p = [contacts objectAtIndex:[indexPath row]];
        [ps removeItem:p];
        
        //we also remov thtat row from the tabel view with animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self){
        UITabBarItem *tbi = [self tabBarItem];
        
        [tbi setTitle:@"New Contact"];
    }
    
    return self;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    //load the NIB file
    UINib *nib = [UINib nibWithNibName:@"ContactCell" bundle:nil];
    
    // register this nib which contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ContactCell"];
}

- (void)sortContacts:(id)sender
{
    SortViewController *sortController = [[SortViewController alloc]init];
    
    
    [sortController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:sortController animated:YES completion:nil];
}



@end
