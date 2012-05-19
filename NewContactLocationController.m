//
//  NewContactLocationController.m
//  FlashAdd
//
//  Created by Ray Wu on 5/12/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "NewContactLocationController.h"

@implementation NewContactLocationController
//@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    if (self){
        //create location manager obect
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        
        //we want it to be as accuraate as possible 
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //tell our manager to start looking for its location immediately
        [locationManager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Couldnot find location %@, error", error);
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    NSLog(@"finding location");
}
@end
