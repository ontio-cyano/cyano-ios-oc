//
//  CCRoundTitleCell.m
//  Cyano
//
//  Created by Yuanhai on 18/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundTitleCell.h"

@implementation CCRoundTitleCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Title
    self.titleLabel = [self createLabel:self.backView];
    self.titleLabel.frame = CGRectMake(frameMove_X, 0.0f, frame.size.width - frameMove_X * 2, frame.size.height);
    self.titleLabel.font = AppleFont_UltraLight(16);
    self.titleLabel.userInteractionEnabled = NO;
}

@end
