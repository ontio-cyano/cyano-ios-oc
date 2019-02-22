//
//  CCTitleCell.m
//  DaiGuanJia
//
//  Created by Faney on 16/11/7.
//  Copyright © 2016年 honeywell. All rights reserved.
//  标题

#import "CCTitleCell.h"

@implementation CCTitleCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Title
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(frameMove_X, 0.0f, frame.size.width - frameMove_X * 2, frame.size.height);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = AppleFont_UltraLight(18);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.textColor = PurityColor(40);
    [self.contentView addSubview:self.titleLabel];
}

@end
