//
//  CVSimpleSlider.m
//  CUBE
//
//  Created by Faney on 15/8/28.
//  Copyright (c) 2015年 Faney. All rights reserved.
//  滑块

#import "CVSimpleSlider.h"

#define widthSpacing (rect.size.height / 2)
#define boxWidthSpacing 8.0f
#define PRValueChange 10.0f

@interface CVSimpleSlider () <UIGestureRecognizerDelegate>

// 0.00f~100.00f间的Value
@property (assign, nonatomic) float touchValue;

// 两次值一样，不发送
@property (assign, nonatomic) float lastSendValue;

// 手势
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;

@property (assign, nonatomic) CGPoint panStartPoint;

@end

@implementation CVSimpleSlider

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // 拖拽
        self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
        self.gestureRecognizer.delegate = self;
        [self addGestureRecognizer:self.gestureRecognizer];
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
        if (value > 100.0f)
        {
            value = 100.0f;
        }
        
        if (value < 0.0f)
        {
            value = 0.0f;
        }
        
        _touchValue = (int)value;
        [self setNeedsDisplay];
        
        // 设置Value
        self.value = minimumValue + (maximumValue - minimumValue) / 100.00f * self.touchValue;
        self.value = ((int)(self.value * 2)) / 2.0f;
    }
}

- (void)drawRect:(CGRect)rect
{
    float roundPointHeight = 25.0f; // 圆点高度
    float rectHeight = 10.0f; // 矩形高度
    // Frame
    rect = CGRectMake(rect.origin.x + frameMove_X, rect.origin.y + (rect.size.height - roundPointHeight) / 2, rect.size.width - frameMove_X, roundPointHeight);
    
    // 圆角矩形
    CGRect boxRect = CGRectMake(rect.origin.x + boxWidthSpacing, rect.origin.y + (rect.size.height - rectHeight) / 2, rect.size.width - boxWidthSpacing * 2, rectHeight);
    
    // Center Point X
    float sliderButton_CenterX = CGRectGetMinX(boxRect) + (self.touchValue / 100) * (boxRect.size.width - widthSpacing) + widthSpacing / 2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    float radius = boxRect.size.height / 2;
    // 右
    CGContextSetRGBFillColor(context, 180 / 255.0f, 180 / 255.0f, 180 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, sliderButton_CenterX, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * M_PI / 2, M_PI / 2, 0);
    CGContextAddLineToPoint(context, sliderButton_CenterX, CGRectGetMaxY(boxRect));
    CGContextFillPath(context);
    
    // 左
    CGContextSetRGBFillColor(context, 238 / 255.0f, 89 / 255.0f, 27 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, sliderButton_CenterX, CGRectGetMaxY(boxRect));
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, M_PI / 2, 3 * M_PI / 2, 0);
    CGContextAddLineToPoint(context, sliderButton_CenterX, CGRectGetMinY(boxRect));
    CGContextFillPath(context);
    
    // 圆点
    radius = rect.size.height / 2;
    CGContextSetRGBFillColor(context, 255 / 255.0f, 255 / 255.0f, 255 / 255.0f, 1.0f);
    CGPoint sliderButtonCenterPoint = CGPointMake(sliderButton_CenterX, rect.origin.y + rect.size.height / 2);
    CGContextMoveToPoint(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y);
    CGContextAddArc(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y, radius, 0.0, 2 * M_PI, NO);
    CGContextFillPath(context);
    // 外圈
    radius = rect.size.height / 2;
    CGContextSetRGBStrokeColor(context, 238 / 255.0f, 89 / 255.0f, 27 / 255.0f, 1.0f);
    CGContextAddArc(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y, radius, 0.0, 2 * M_PI, NO);
    CGContextSetLineWidth(context, radius * 0.1);
    CGContextStrokePath(context);
    // 内点
    radius = boxRect.size.height / 2 * 1.4;
    CGContextSetRGBFillColor(context, 238 / 255.0f, 89 / 255.0f, 27 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y);
    CGContextAddArc(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y, radius, 0.0, 2 * M_PI, NO);
    CGContextFillPath(context);
}

// 结束手势
- (void)endGesture
{
    if (minimumValue == 0.0f && maximumValue == 100.0f && self.touchValue < 5.0f)
    {
        self.touchValue = 0.0f;
    }
    
    if(self.delegate && self.lastSendValue != self.value)
    {
        self.lastSendValue = self.value;
        [self.delegate CVSimpleSliderTouched:self];
    }
}

#pragma
#pragma mark - UIGestureRecognizerDelegate

// 拖拽
- (void)gestureEvent:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.panStartPoint = [recognizer translationInView:self];
        self.lastSendValue = self.value;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [recognizer translationInView:self];
        CGFloat moveX = currentPoint.x - self.panStartPoint.x;
        moveX = moveX / 2;
        
        if (moveX != 0)
        {
            self.panStartPoint = [recognizer translationInView:self];
            self.touchValue += moveX;
            
            // 滑动更新Label
            if (self.delegate && [(NSObject *)self.delegate respondsToSelector:@selector(CVSimpleSliderMoved:)])
            {
                [self.delegate CVSimpleSliderMoved:self];
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        // 结束手势
        [self endGesture];
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled)
    {
        // 结束手势
        [self endGesture];
    }
}

@end
