//
//  CCTitleDetailUDCell.m
//  CloudStudy
//
//  Created by Faney on 2017/1/10.
//  Copyright © 2017年 honeywell. All rights reserved.
//  标题、详情（上下）

#import "CCTitleDetailUDCell.h"

@implementation CCTitleDetailUDCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Frame
    float titleHeight = 25.0f;
    float detailHeight = 20.0f;
    
    // Title
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(frameMove_X, (frame.size.height - titleHeight - detailHeight) / 2, frame.size.width - frameMove_X * 2, titleHeight);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = AppleFont_UltraLight(17);
    self.titleLabel.textColor = BlackColor;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    // Detail
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.frame = CGRectMake(frameMove_X, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, frame.size.width - frameMove_X * 2, detailHeight);
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.font = AppleFont_UltraLight(14);
    self.detailLabel.textColor = PurityColor(150);
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.detailLabel];
}

@end
