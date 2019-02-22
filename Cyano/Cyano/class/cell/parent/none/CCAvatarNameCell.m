//
//  CCAvatarNameCell.m
//  Cyano
//
//  Created by Yuanhai on 27/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCAvatarNameCell.h"

#define avatarHeight getUIValue(62.0f)
#define nameHeight getUIValue(30.0f)

@implementation CCAvatarNameCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // 头像
    self.avatarImageView = [self createDownloadImageView:self.contentView];
    self.avatarImageView.frame = CGRectMake(self.center.x - avatarHeight / 2, (self.height - avatarHeight - nameHeight) / 2, avatarHeight, avatarHeight);
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = avatarHeight / 2;
    
    // Title
    self.nameLabel = [self createLabel:self.contentView];
    self.nameLabel.frame = CGRectMake(frameMove_X, self.avatarImageView.bottom, self.contentView.width - frameMove_X * 2, nameHeight);
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
}

@end
