//
//  CVCellIndicator.m
//  CUBE
//
//  Created by Faney on 15/8/14.
//  Copyright (c) 2015年 Faney. All rights reserved.
//  单元格指示器

#import "CVCellIndicator.h"

#define spacing 2.0f

@implementation CVCellIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setIndicatorType:(NSInteger)type
{
    _indicatorType = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)boxRect
{
    float lineWidth = boxRect.size.width * 0.08;
    boxRect = CGRectMake(boxRect.origin.x + lineWidth / 2 + spacing, boxRect.origin.y + lineWidth / 2 + spacing, boxRect.size.width - lineWidth - spacing * 2, boxRect.size.height - lineWidth - spacing * 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    
    // 单元格向下
    if (self.indicatorType == Indicator_Type_Down)
    {
        CGContextSetRGBStrokeColor(context, 120 / 255.0f, 120 / 255.0f, 120 / 255.0f, 0.9f);
        CGContextMoveToPoint(context, boxRect.origin.x, boxRect.origin.y + boxRect.size.height / 4);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 2, boxRect.origin.y + boxRect.size.height / 4 * 3);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width, boxRect.origin.y + boxRect.size.height / 4);
    }
    // 单元格向上
    else if (self.indicatorType == Indicator_Type_Up)
    {
        CGContextSetRGBStrokeColor(context, 120 / 255.0f, 120 / 255.0f, 120 / 255.0f, 0.9f);
        CGContextMoveToPoint(context, boxRect.origin.x, boxRect.origin.y + boxRect.size.height / 4 * 3);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 2, boxRect.origin.y + boxRect.size.height / 4);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width, boxRect.origin.y + boxRect.size.height / 4 * 3);
    }
    // 单元格向右
    else if (self.indicatorType == Indicator_Type_Right)
    {
        CGContextSetRGBStrokeColor(context, 120 / 255.0f, 120 / 255.0f, 120 / 255.0f, 1.0f);
        CGContextMoveToPoint(context, boxRect.origin.x + boxRect.size.width / 4, boxRect.origin.y);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 4 * 3, boxRect.origin.y + boxRect.size.height / 2);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 4, boxRect.origin.y + boxRect.size.height);
    }
    // 单元格向右，蓝色
    else if (self.indicatorType == Indicator_Type_Right_Blue)
    {
        CGContextSetRGBStrokeColor(context, 36 / 255.0f, 144 / 255.0f, 235 / 255.0f, 1.0f);
        CGContextMoveToPoint(context, boxRect.origin.x + boxRect.size.width / 4, boxRect.origin.y);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 4 * 3, boxRect.origin.y + boxRect.size.height / 2);
        CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width / 4, boxRect.origin.y + boxRect.size.height);
    }
    
    CGContextStrokePath(context);
}

@end
