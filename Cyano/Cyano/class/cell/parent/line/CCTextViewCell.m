//
//  CCTextViewCell.m
//  CloudStudyTeacher
//
//  Created by Yuanhai on 7/1/18.
//  Copyright © 2018年 honeywell. All rights reserved.
//

#import "CCTextViewCell.h"

@implementation CCTextViewCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // TextView
    float heightSpacing = 7.0f;
    self.textView = [[SXTextView alloc] initWithFrame:CGRectMake(frameMove_X, heightSpacing, frame.size.width - frameMove_X * 2, frame.size.height - heightSpacing * 2)];
    self.textView.font = AppleFont_UltraLight(14);
    self.textView.placeholder = @"请输入内容...";
    [self.contentView addSubview:self.textView];
}

@end
