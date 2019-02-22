//
//  CCRoundTitleTextFieldCell.m
//  Cyano
//
//  Created by Yuanhai on 10/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundTitleTextFieldCell.h"

@implementation CCRoundTitleTextFieldCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Title
    self.titleLabel = [self createLabel:self.backView];
    self.titleLabel.frame = CGRectMake(frameMove_X, 0.0f, self.backView.width / 2 - frameMove_X, self.backView.height);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    // TextField
    self.textField = [self createTextField:self.backView];
    self.textField.frame = CGRectMake(self.titleLabel.right, 0.0f, self.backView.width - self.titleLabel.right - frameMove_X, self.backView.height);
    self.textField.textAlignment = NSTextAlignmentRight;
}

- (void)layoutFrame
{
    // 自适应
    CGRect rect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(100000, self.titleLabel.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil] context:nil];
    self.titleLabel.width = rect.size.width;
    self.textField.frame = CGRectMake(self.titleLabel.right, 0.0f, self.backView.width - self.titleLabel.right - frameMove_X, self.backView.height);
}

@end
