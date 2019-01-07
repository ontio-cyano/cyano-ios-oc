//
//  CCRoundTextViewCell.m
//  Cyano
//
//  Created by Yuanhai on 5/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundTextViewCell.h"

@implementation CCRoundTextViewCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // TextView
    float heightSpacing = 7.0f;
    self.textView = [[SXTextView alloc] initWithFrame:CGRectMake(frameMove_X, heightSpacing, self.backView.width - frameMove_X * 2, self.backView.height - heightSpacing * 2)];
    self.textView.font = AppleFont_UltraLight(14);
    self.textView.placeholder = @"请输入内容...";
    [self.backView addSubview:self.textView];
}

@end
