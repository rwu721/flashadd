//
//  Contact.h
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@interface Contact : NSObject <NSCoding>

@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* mobileNumber;
@property (nonatomic, copy) NSString* emailAddress;
@property (nonatomic, strong) NSDate* dateCreated;
@property (nonatomic, strong) CLLocation* locationCreated;
@property (nonatomic, copy)NSString *imageKey;

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSData *thumbnailData;

- (void)setThumbnailDataFromImage:(UIImage *)image;

- (id)initWithFirstName:(NSString *)fName LastName:(NSString *)lName Email:(NSString *)email mobileNumber:(NSString *)mobile Location:(CLLocation *)loc;
@end
