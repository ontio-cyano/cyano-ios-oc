//
//  CCTextFieldCell.m
//  iQBTeacher
//
//  Created by Yuanhai on 9/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTextFieldCell.h"
#import "AccessoryTextField.h"

@implementation CCTextFieldCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // TextField
    self.textField = [[AccessoryTextField alloc] init];
    self.textField.frame = CGRectMake(frameMove_X, 0.0f, frame.size.width - frameMove_X * 2, self.height);
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.font = AppleFont_UltraLight(18);
    self.textField.textColor = DarkGreyColor;
    [self.contentView addSubview:self.textField];
}

@end
