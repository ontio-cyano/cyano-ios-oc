//
//  CCRoundTitleSwitchCell.m
//  Cyano
//
//  Created by Yuanhai on 18/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundTitleSwitchCell.h"

@implementation CCRoundTitleSwitchCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    self.switchView = [[UISwitch alloc] init];
    self.switchView.frame = CGRectMake(self.backView.width - frameMove_X - self.switchView.width, (self.backView.height - self.switchView.height) / 2, self.switchView.width, self.switchView.height);
    self.switchView.onTintColor = MainRoseRedColor;
    [self.backView addSubview:self.switchView];
    
    // Title
    self.titleLabel = [self createLabel:self.backView];
    self.titleLabel.frame = CGRectMake(frameMove_X, 0.0f, self.switchView.left - frameMove_X * 2, frame.size.height);
    self.titleLabel.font = AppleFont_UltraLight(18);
    self.titleLabel.userInteractionEnabled = NO;
}

@end
