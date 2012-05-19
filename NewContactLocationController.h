//
//  NewContactLocationController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/12/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"



@interface NewContactLocationController : UIViewController <CLLocationManagerDelegate> //MKMapViewDelegate, UITextFieldDelegate>

{
    CLLocationManager *locationManager;
}


//@property (nonatomic, readonly)CLLocation *location; 

- (void)findLocation;

@end
