//
//  CVNavCancelView.m
//  iQBTeacher
//
//  Created by Yuanhai on 10/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVNavCancelView.h"

@implementation CVNavCancelView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)boxRect
{
    float lineWidth = boxRect.size.width / 15;
    boxRect = CGRectMake(boxRect.origin.x + lineWidth / 2 + BackSpacing, boxRect.origin.y + lineWidth / 2 + BackSpacing, boxRect.size.width - lineWidth - BackSpacing * 2, boxRect.size.height - lineWidth - BackSpacing * 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    
    if (self.viewColor == BackViewColor_White)
    {
        CGContextSetRGBStrokeColor(context, 255 / 255.0f, 255 / 255.0f, 255 / 255.0f, 1.0f);
    }
    else
    {
        CGContextSetRGBStrokeColor(context, 0 / 255.0f, 0 / 255.0f, 0 / 255.0f, 1.0f);
    }
    
    CGContextMoveToPoint(context, boxRect.origin.x, boxRect.origin.y);
    CGContextAddLineToPoint(context, boxRect.origin.x + boxRect.size.width, boxRect.origin.y + boxRect.size.height);
    CGContextMoveToPoint(context, boxRect.origin.x + boxRect.size.width, boxRect.origin.y);
    CGContextAddLineToPoint(context, boxRect.origin.x, boxRect.origin.y + boxRect.size.height);
    
    CGContextStrokePath(context);
}

@end
