//
//  CCTitleTextFieldCell.m
//  iQBTeacher
//
//  Created by Yuanhai on 10/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTitleTextFieldCell.h"

@implementation CCTitleTextFieldCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Title
    self.titleLabel = [self createLabel:self.contentView];
    self.titleLabel.frame = CGRectMake(frameMove_X, frameMove_X, self.contentView.width - frameMove_X * 2, getUIValue(25.0f));
    self.titleLabel.font = AppleFont_UltraLight(16);
    self.titleLabel.textColor = PurityColor(40);
    
    // Text Back
    self.textBackView = [self createView:self.contentView];
    self.textBackView.frame = CGRectMake(frameMove_X, self.titleLabel.bottom, self.contentView.width - frameMove_X * 2, self.contentView.height - self.titleLabel.bottom);
    self.textBackView.backgroundColor = WhiteColor;
    self.textBackView.layer.borderColor = tableLineColor.CGColor;
    self.textBackView.layer.borderWidth = 1.0f;
    
    // TextField
    self.textField = [self createTextField:self.textBackView];
    self.textField.frame = CGRectMake(frameMove_X, 0.0f, self.textBackView.width - frameMove_X * 2, self.textBackView.height);
    self.textField.font = AppleFont_UltraLight(16);
    self.textField.textColor = PurityColor(40);
}

@end
