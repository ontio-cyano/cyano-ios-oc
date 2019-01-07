//
//  CVMenuBackView.m
//  CUBE
//
//  Created by Faney on 15/8/31.
//  Copyright (c) 2015年 Faney. All rights reserved.
//  Menu导航条的背景黑框

#import "CVMenuBackView.h"

@implementation CVMenuBackView

- (id)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.triangleHeight = 7.0f;
        self.radius = 10.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Frame
    float triangleWidth = self.triangleHeight;
    CGRect boxRect = CGRectMake(0.0f, self.triangleHeight, rect.size.width, rect.size.height - self.triangleHeight);
    
    // 下方黑框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, 241 / 255.0f, 242 / 255.0f, 239 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + self.radius, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - self.radius, CGRectGetMinY(boxRect) + self.radius, self.radius, 3 * (float)M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - self.radius, CGRectGetMaxY(boxRect) - self.radius, self.radius, 0, (float)M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + self.radius, CGRectGetMaxY(boxRect) - self.radius, self.radius, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + self.radius, CGRectGetMinY(boxRect) + self.radius, self.radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    // 上方三角
    CGContextMoveToPoint(context, boxRect.size.width / 2 - triangleWidth / 2, self.triangleHeight);
    CGContextAddLineToPoint(context, boxRect.size.width / 2, 0.0f);
    CGContextAddLineToPoint(context, boxRect.size.width / 2 + triangleWidth / 2, self.triangleHeight);
    CGContextFillPath(context);
}

@end
