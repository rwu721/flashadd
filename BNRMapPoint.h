//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Ray Wu on 5/6/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/Corelocation.h>
#import <MapKit/MapKit.h>
#import "Contact.h"

@interface BNRMapPoint : NSObject
<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle;
    
}

// A new disgnated initializer ofr instances of BNRMapPoint
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

//this is a required property from MKAnnotation 
@property (nonatomic,readonly)CLLocationCoordinate2D coordinate;

//This is an optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@end
