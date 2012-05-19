//
//  Contact.m
//  FlashAdd
//
//  Created by Ray Wu on 5/10/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import "Contact.h"

@implementation Contact


@synthesize firstName, lastName, emailAddress, mobileNumber, dateCreated, locationCreated, imageKey, thumbnail, thumbnailData; 

- (id)initWithFirstName:(NSString *)fName LastName:(NSString *)lName Email:(NSString *)email mobileNumber:(NSString *)mobile Location:(CLLocation*)loc;
{
    //call the superclass designated inititilizer
    self = [super init];
    
    if (self){
        // give the instance vars initial values
        [self setFirstName:fName];
        [self setLastName:lName];
        [self setEmailAddress:email];
        [self setMobileNumber:mobile];
        [self setLocationCreated:loc];
        
        dateCreated = [[NSDate alloc] init];
    }
    
    
    //return the address of the newly initialized object
    return self;
}

- (NSString *)description

    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterNoStyle];
        
        NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ %@ %@", firstName, lastName, [dateFormatter stringFromDate:dateCreated ]];
        
        return descriptionString;
        
    }

- (id)init
{
    self = [self initWithFirstName:@"" LastName:@"" Email:@"" mobileNumber:@"" Location:nil];
    return self;
}




- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:firstName forKey:@"firstName"];
    [aCoder encodeObject:lastName forKey:@"lastName"];
    [aCoder encodeObject:emailAddress forKey:@"emailAddress"];
    [aCoder encodeObject:mobileNumber forKey:@"mobileNumber"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:locationCreated forKey:@"locationCreated"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    [aCoder encodeObject:thumbnailData forKey:@"thumnailData"];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self){
        [self setFirstName:[aDecoder decodeObjectForKey:@"firstName"]];
        [self setLastName:[aDecoder decodeObjectForKey:@"lastName"]];
        [self setEmailAddress:[aDecoder decodeObjectForKey:@"emailAddress"]];
        [self setMobileNumber:[aDecoder decodeObjectForKey:@"mobileNumber"]];
        [self setLocationCreated:[aDecoder decodeObjectForKey:@"locationCreated"]];
                
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
        thumbnailData = [aDecoder decodeObjectForKey:@"thumnailData"];
        
        
    }
    return self;
}
- (UIImage *)thumbnail
{
    //if there is no thumbnailData, then i have no thumbnail to return
    if (!thumbnailData){
        return nil;
    }
    
    if (!thumbnail){
        //creat the image from the data
        thumbnail = [UIImage imageWithData:thumbnailData];
    }
    return thumbnail;
}
- (void)setThumbnailDataFromImage:(UIImage *)image
{
    CGSize origImageSize = [image size];
    //the rectanble of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    //figure out a scaling ratio to make sure we maintain same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height/origImageSize.height);
    
    //create a transpaent bitmap context with a scaling factor equal to that of screen
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //create a path that is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    //make all subsequent draing clip to this rounded rectangle
    [path addClip];
    
    //center the image in the thumbnail rectangle
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height)/2.0;
    
    //draw the image on it
    
    [image drawInRect:projectRect];
    
    //get the image from the image context, keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:smallImage];
    
    //get the png represenation of the iamge and set it as our archivable data
    NSData *data = UIImagePNGRepresentation(smallImage);
    [self setThumbnailData:data];
    
    //cleanup image conext resources we're done
    UIGraphicsEndImageContext();

    
}

@end
