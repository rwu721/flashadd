//
//  LocationMapView.m
//  FlashAdd
//
//  Created by Ray Wu on 5/13/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "LocationMapView.h"

@implementation LocationMapView
@synthesize coordinate, locationAdded, amigo;



- (IBAction)closeMap:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithLocation:(CLLocation *)loc
{
    self = [super init];
    if (self){
       /*CLLocationCoordinate2D coord = [loc coordinate];
        //[worldView setCenterCoordinate:coord];
        
        //create an instance of BNRMapPoint with the current data
      
        
        BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:@"Location Created"];
        //add it to the map view
        
    
       
        [worldView addAnnotation:mp];
        
        //zoom the region to this location
        
       // CLLocationCoordinate2D coord;
        //coord.latitude = 34;
        //coord.longitude = 118;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 200, 200);
        [worldView setRegion:region animated:YES];
    }*/}
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
        
 
    
    
    CLLocationCoordinate2D zoomLocation = [[amigo locationCreated] coordinate];


    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:zoomLocation title:[NSString stringWithFormat:@"%@ %@", [amigo firstName], [amigo lastName]]];
    //add it to the map view
    
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dayFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *dayString = [[NSString alloc] initWithFormat:@"%@", [dayFormatter stringFromDate:[amigo dateCreated]]];
    [mp setSubtitle:dayString];
    
    //[worldView addAnnotation:mp];
    
MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 200, 200);
// 3
[worldView setRegion:viewRegion animated:YES]; 
    //[NameLabel setText:[NSString stringWithFormat:@"Location %@ %@ added to contacts", [amigo firstName], [amigo lastName]]];
    
    
}

- (void)viewDidUnload {
    NameLabel = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad{
    worldView.delegate = self;
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
   
    
    UIImageView *ContactThumbnail = [[UIImageView alloc]initWithImage:[amigo thumbnail]];
    
    pinView.leftCalloutAccessoryView = ContactThumbnail;
    
    return pinView;
    
   
    
}
@end

