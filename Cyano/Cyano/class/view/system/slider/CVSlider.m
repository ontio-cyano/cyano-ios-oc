//
//  CVSlider.m
//  CUBE
//
//  Created by Faney on 15/12/7.
//  Copyright © 2015年 Faney. All rights reserved.
//  不可滑动Slider

#import "CVSlider.h"

#define widthSpacing (rect.size.height / 2)
#define boxWidthSpacing 0.0f

@interface CVSlider ()

// 0.00f~100.00f间的Value
@property (assign, nonatomic) float touchValue;

// 上次操作点的坐标
@property (assign, nonatomic) CGPoint lastTouchPoint;

// 是否滑动
@property (assign, nonatomic) NSInteger sliderType;

@end

@implementation CVSlider

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)updateMinValue:(float)minValue maxValue:(float)maxValue
{
    minimumValue = minValue;
    maximumValue = maxValue;
}

// 更新换算后的值
- (void)updateValue:(float)value
{
    self.touchValue = (value - minimumValue) / (maximumValue - minimumValue) * 100.00f;
}

- (void)setValue:(float)value
{
    if (value != _value)
    {
        if (value > maximumValue)
        {
            value = maximumValue;
        }
        
        if (value < minimumValue)
        {
            value = minimumValue;
        }
        _value = value;
    }
}

- (void)setTouchValue:(float)value
{
    if (value != _touchValue)
    {
        if (value > 100.00f)
        {
            value = 100.00f;
        }
        
        if (value < 0.00f)
        {
            value = 0.00f;
        }
        _touchValue = value;
        [self setNeedsDisplay];
        
        // 设置Value
        self.value = minimumValue + (maximumValue - minimumValue) / 100.00f * self.touchValue;
        self.value = ((int)(self.value * 2)) / 2.0f;
    }
}

- (void)drawRect:(CGRect)rect
{
    float rectHeight = 10.0f; // 矩形高度
    // Frame
    rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - rectHeight) / 2, rect.size.width, rectHeight);
    
    // 圆角矩形
    CGRect boxRect = CGRectMake(rect.origin.x + boxWidthSpacing, rect.origin.y + (rect.size.height - rectHeight) / 2, rect.size.width - boxWidthSpacing * 2, rectHeight);
    
    // Center Point X
    float sliderButton_CenterX = CGRectGetMinX(boxRect) + (self.touchValue / 100) * (boxRect.size.width - widthSpacing) + widthSpacing / 2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    float radius = boxRect.size.height / 2;
    
    // 是否顶到头
    if (self.value >= maximumValue)
    {
        CGContextSetRGBFillColor(context, 58 / 255.0f, 187 / 255.0f, 250 / 255.0f, 1.0f);
        float radius = boxRect.size.height / 2;
        CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
        CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * M_PI / 2, M_PI / 2, 0);
        CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, M_PI / 2, 3 * M_PI / 2, 0);
        CGContextFillPath(context);
        return;
    }
    
    // 右
    CGContextSetRGBFillColor(context, 230 / 255.0f, 231 / 255.0f, 232 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, sliderButton_CenterX, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * M_PI / 2, M_PI / 2, 0);
    CGContextAddLineToPoint(context, sliderButton_CenterX, CGRectGetMaxY(boxRect));
    CGContextFillPath(context);
    
    // 左
    CGContextSetRGBFillColor(context, 58 / 255.0f, 187 / 255.0f, 250 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, sliderButton_CenterX, CGRectGetMaxY(boxRect));
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, M_PI / 2, 3 * M_PI / 2, 0);
    CGContextAddLineToPoint(context, sliderButton_CenterX, CGRectGetMinY(boxRect));
    CGContextFillPath(context);
}

@end
