//
//  LocationMapView.h
//  FlashAdd
//
//  Created by Ray Wu on 5/13/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"
#import "BNRMapPoint.h"
#import "Contact.h"

@interface LocationMapView : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

{
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    __weak IBOutlet UILabel *NameLabel;
    
  }
@property(readonly, NS_NONATOMIC_IPHONEONLY) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) CLLocation *locationAdded;
@property (nonatomic, strong) Contact *amigo;

- (IBAction)closeMap:(id)sender;

- (id)initWithLocation:(CLLocation *)loc;

@end
