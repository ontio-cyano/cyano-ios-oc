//
//  CVRoundPressView.m
//  DaiGuanJia
//
//  Created by Faney on 16/11/2.
//  Copyright © 2016年 honeywell. All rights reserved.
//  圆形点击视图

#import "CVRoundPressView.h"

@implementation CVRoundPressView

- (id)initWithFrame:(CGRect)frame radius:(float)radius
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = WhiteColor;
        self.layer.cornerRadius = radius;
        self.clipsToBounds = YES;
        
        // 点击效果处理
        self.alphaView.layer.masksToBounds = YES;
        self.alphaView.layer.cornerRadius = self.layer.cornerRadius;
        [self.alphaView.layer setMasksToBounds:YES];
        self.alphaView.clipsToBounds = YES;
    }
    return self;
}

// 阴影
- (void)showShadow:(UIColor *)color
{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowRadius = 8;
}

@end
