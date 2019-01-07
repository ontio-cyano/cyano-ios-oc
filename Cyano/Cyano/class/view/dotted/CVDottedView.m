//
//  CVDottedView.m
//  iQBTeacher
//
//  Created by Yuanhai on 27/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVDottedView.h"

#define widthCount 30
#define dottedTimes 2
#define lineWidth 1.5f
#define paintColor 220 / 255.0f, 220 / 255.0f, 220 / 255.0f, 1.0f

@implementation CVDottedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)boxRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, paintColor);
    CGContextSetLineWidth(context, lineWidth);
    
    float littleDottedLine = boxRect.size.width / (widthCount * (dottedTimes + 1) - 1);
    float littleLine = littleDottedLine * dottedTimes;
    
    // Totted
    for (int f = 0; f < widthCount; f++)
    {
        CGContextMoveToPoint(context, boxRect.origin.x + f * (littleDottedLine + littleLine), boxRect.origin.y);
        CGContextAddLineToPoint(context, boxRect.origin.x + littleLine * (f + 1) + littleDottedLine * f, boxRect.origin.y);
    }
    
    CGContextStrokePath(context);
}

@end
