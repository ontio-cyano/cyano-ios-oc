//
//  CVScanMaskView.m
//  Cyano
//
//  Created by Yuanhai on 11/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVScanMaskView.h"

#define scanWhiteColor 255 / 255.0f, 255 / 255.0f, 255 / 255.0f, 0.8f
#define scanGreenColor 108 / 255.0f, 205 / 255.0f, 142 / 255.0f, 0.8f
#define lineWidth 20.0f

@implementation CVScanMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        // 空心Frame
        float maskRadius = self.width * 0.75;
        float mask_top = (self.height - maskRadius) * 0.3;
        self.holeRect = CGRectMake((self.width - maskRadius) / 2, mask_top, maskRadius, maskRadius);
    }
    return self;
}

- (void)drawRect:(CGRect)boxRect
{
    // 背景
    [RGBACOLOR(0, 0, 0, 0.6f) setFill];
    UIRectFill(boxRect);
    // 空心
    CGRect holeiInterSection = CGRectIntersection(self.holeRect, boxRect);
    [[UIColor clearColor] setFill];
    UIRectFill(holeiInterSection);
    
    // 白框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, scanWhiteColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextStrokeRect(context, self.holeRect);
    
    CGContextSetRGBStrokeColor(context, scanGreenColor);
    CGContextSetLineWidth(context, 3.0f);
    
    // 绿框左上
    CGContextMoveToPoint(context, CGRectGetMinX(self.holeRect), CGRectGetMinY(self.holeRect) + lineWidth);
    CGContextAddLineToPoint(context, CGRectGetMinX(self.holeRect), CGRectGetMinY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(self.holeRect) + lineWidth, CGRectGetMinY(self.holeRect));
    
    // 绿框右上
    CGContextMoveToPoint(context, CGRectGetMaxX(self.holeRect) - lineWidth, CGRectGetMinY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.holeRect), CGRectGetMinY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.holeRect), CGRectGetMinY(self.holeRect) + lineWidth);

    // 绿框右下
    CGContextMoveToPoint(context, CGRectGetMaxX(self.holeRect), CGRectGetMaxY(self.holeRect) - lineWidth);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.holeRect), CGRectGetMaxY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.holeRect) - lineWidth, CGRectGetMaxY(self.holeRect));

    // 绿框左下
    CGContextMoveToPoint(context, CGRectGetMinX(self.holeRect) + lineWidth, CGRectGetMaxY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(self.holeRect), CGRectGetMaxY(self.holeRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(self.holeRect), CGRectGetMaxY(self.holeRect) - lineWidth);
    
    CGContextStrokePath(context);
}

@end
