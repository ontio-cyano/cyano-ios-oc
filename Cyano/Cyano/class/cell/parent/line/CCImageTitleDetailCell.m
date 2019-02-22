//
//  CCImageTitleDetailCell.m
//  CloudStudyTeacher
//
//  Created by Yuanhai on 19/11/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import "CCImageTitleDetailCell.h"

@implementation CCImageTitleDetailCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Image
    float imageViewSpacing = frameMove_X * 0.6;
    float imageHeight = frame.size.height - imageViewSpacing * 2;
    float imageWidth = imageHeight * 160 / 120;
    self.titleImageView = [[UIImageView alloc] init];
    self.titleImageView.frame = CGRectMake(imageViewSpacing, imageViewSpacing, imageWidth, imageHeight);
    [self.contentView addSubview:self.titleImageView];
    
    // Frame
    float titleHeight = 30.0f;
    float detailHeight = 40.0f;
    
    // Title
    float labelX = self.titleImageView.right + frameMove_X;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(labelX, self.titleImageView.top, frame.size.width - frameMove_X - labelX, titleHeight);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = AppleFont_UltraLight(17);
    self.titleLabel.textColor = BlackColor;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    // Detail
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, detailHeight);
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.font = AppleFont_UltraLight(14);
    self.detailLabel.textColor = PurityColor(150);
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
}

@end
