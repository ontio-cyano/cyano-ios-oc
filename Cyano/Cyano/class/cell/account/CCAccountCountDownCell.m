//
//  CCAccountCountDownCell.m
//  Cyano
//
//  Created by Yuanhai on 22/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCAccountCountDownCell.h"

@implementation CCAccountCountDownCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Frame
    float widthSpacing = frameMove_X * 3;
    float titleHeight = 25.0f;
    float titleHeightSpacing = 10.0f;
    float textFieldHeight = 40.0f;
    float countdownWidth = 140.0f;
    float countdownWidthSpacing = widthSpacing * 0.6;
    
    // Title
    self.titleLabel = [self createLabel:self.contentView];
    self.titleLabel.frame = CGRectMake(widthSpacing, 0.0f, self.width - widthSpacing * 2, titleHeight);
    
    // TextField
    self.textField = [self createTextField:self.contentView];
    self.textField.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + titleHeightSpacing, self.titleLabel.width - countdownWidth - countdownWidthSpacing, textFieldHeight);
    self.textField.layer.cornerRadius = scrollCornerRadius;
    self.textField.backgroundColor = WhiteColor;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.layer.borderColor = tableLineColor.CGColor;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    // Count Down Button
    self.countdownButton = [[CountdownButton alloc] initWithFrame:CGRectMake(self.textField.right + countdownWidthSpacing, self.textField.top, countdownWidth, self.textField.height)];
    self.countdownButton.backgroundColor = MainBlueColor;
    self.countdownButton.layer.cornerRadius = self.textField.height / 2;
    self.countdownButton.titleLabel.font = AppleFont_UltraLight(16);
    [self.countdownButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.countdownButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self addSubview:self.countdownButton];
}

@end
