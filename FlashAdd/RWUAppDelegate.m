//
//  RWUAppDelegate.m
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "RWUAppDelegate.h"
#import "Contact.h"
#import "ContactsViewController.h"
#import "ContactStore.h"
#import "NewContactViewController.h"
#import "NewContactLocationController.h"
#import "CoreLocation/CoreLocation.h"
#import "BigMapController.h"
#import "AppInfoController.h"


//#import <Address/ABPerson.h>

@implementation RWUAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    //GPS init
    NewContactLocationController *locationController = [[NewContactLocationController alloc]initWithNibName:@"NewContactLocationController" bundle:nil];
    
    [locationController findLocation];
    
    NSLog(@"%@", locationController);
    
    
    NewContactViewController *newContactViewController = [[NewContactViewController alloc] init];
    
    ContactsViewController *contactViewController = [[ContactsViewController alloc] init];
    
    BigMapController *bigMapController = [[BigMapController alloc]init];
    
    AppInfoController *appInfoController = [[AppInfoController alloc]init];
    
     
    //creat an instance of UINavigationController 
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:contactViewController];
    
    if (navController){
        UITabBarItem *tbi = [navController tabBarItem];
        
        [tbi setTitle:@"All Contacts"];
        
        UIImage *i = [UIImage imageNamed:@"contacts.png"];
        
        [tbi setImage:i];

    }
    
  
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:newContactViewController, navController, bigMapController, appInfoController, nil];
    
    [tabBarController setViewControllers:viewControllers];
    
   
    
    [[self window] setRootViewController:tabBarController];
    
     //[findLocation startUpdatingLocation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[ContactStore sharedStore] saveChanges];
    if (success){
        NSLog(@"Saved all contacts");
    }
    else {
        NSLog(@"Could not save any Contacts");
    }
        
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
