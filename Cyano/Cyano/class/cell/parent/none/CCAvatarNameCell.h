//
//  CCAvatarNameCell.h
//  Cyano
//
//  Created by Yuanhai on 27/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTableViewCell.h"

@interface CCAvatarNameCell : CCTableViewCell

@property (strong, nonatomic) LFDownloadImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end
