//
//  ContactCell.h
//  FlashAdd
//
//  Created by Ray Wu on 5/11/12.
//  Copyright (c) 2012 Weill Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;


@end
