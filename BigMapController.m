//
//  BigMapController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/17/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "BigMapController.h"

@interface BigMapController ()

@end

@implementation BigMapController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        
        [tbi setTitle:@"Master Map"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    for (int i =0; i < [[[ContactStore sharedStore] allContacts] count]; i++){
        Contact *p = [[[ContactStore sharedStore] allContacts] objectAtIndex:i];
        BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:[[p locationCreated]coordinate] title:[NSString stringWithFormat:@"%@ %@", [p firstName], [p lastName]]];
        //add it to the map view
        [worldView addAnnotation:mp];
        
        
    }
        
}

- (void)viewDidUnload
{
    worldView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *  AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    
    //pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    //[rightbutton setCoor
    [rightbutton setTitle:annotation.title forState:UIControlStateNormal];
    
    [rightbutton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    pinView.rightCalloutAccessoryView = rightbutton;
    
    
    UIImageView *ContactThumbnail = [[UIImageView alloc]initWithImage:[ UIImage imageNamed:@"plus.png"]];
    
    pinView.leftCalloutAccessoryView = ContactThumbnail;
    
    return pinView;
    
    
    
}

@end
