//
//  CCAccountTitleTextFieldCell.m
//  Cyano
//
//  Created by Yuanhai on 22/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCAccountTitleTextFieldCell.h"

@implementation CCAccountTitleTextFieldCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Frame
    float widthSpacing = frameMove_X * 3;
    float titleHeight = 25.0f;
    float titleHeightSpacing = 10.0f;
    float textFieldHeight = 40.0f;
    
    // Title
    self.titleLabel = [self createLabel:self.contentView];
    self.titleLabel.frame = CGRectMake(widthSpacing, 0.0f, self.width - widthSpacing * 2, titleHeight);
    
    // TextField
    self.textField = [self createTextField:self.contentView];
    self.textField.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + titleHeightSpacing, self.titleLabel.width, textFieldHeight);
    self.textField.layer.cornerRadius = scrollCornerRadius;
    self.textField.backgroundColor = WhiteColor;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.layer.borderColor = tableLineColor.CGColor;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

@end
