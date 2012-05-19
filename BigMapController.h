//
//  BigMapController.h
//  FlashAdd
//
//  Created by Ray Wu on 5/17/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"
#import "BNRMapPoint.h"
#import "Contact.h"
#import "ContactStore.h"

@interface BigMapController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    
    
    
    __weak IBOutlet MKMapView *worldView;
    
    
}

@end
