//
//  CVPageMaskView.m
//  iQBTeacher
//
//  Created by Yuanhai on 3/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVPageMaskView.h"

@implementation CVPageMaskView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)boxRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 渐变色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){106 / 255.0f, 160 / 255.0f, 136 / 255.0f, 1.0f});
    CGColorRef centerColor = CGColorCreate(colorSpaceRef, (CGFloat[]){213 / 255.0f, 144 / 255.0f, 50 / 255.0f, 1.0f});
    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){185 / 255.0f, 69 / 255.0f, 189 / 255.0f, 1.0f});
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, centerColor, endColor}, 3, nil);
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){0.0f, 0.5, 1.0f});
    CFRelease(colorArray);
    CGColorRelease(beginColor);
    CGColorRelease(endColor);
    CGColorSpaceRelease(colorSpaceRef);
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(boxRect.size.width / 2, boxRect.origin.y), CGPointMake(boxRect.size.width / 2, boxRect.origin.y + boxRect.size.height), 0);
    CGGradientRelease(gradientRef);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    // 渐变色
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){106 / 255.0f, 160 / 255.0f, 136 / 255.0f, 0.8f});
    centerColor = CGColorCreate(colorSpaceRef, (CGFloat[]){160 / 255.0f, 158 / 255.0f, 202 / 255.0f, 0.8f});
    endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){185 / 255.0f, 69 / 255.0f, 189 / 255.0f, 0.8f});
    colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, centerColor, endColor}, 3, nil);
    gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){0.0f, 0.5, 1.0f});
    CFRelease(colorArray);
    CGColorRelease(beginColor);
    CGColorRelease(endColor);
    CGColorSpaceRelease(colorSpaceRef);
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(boxRect.origin.x, boxRect.origin.y), CGPointMake(boxRect.origin.x + boxRect.size.width, boxRect.origin.y + boxRect.size.height), 0);
    CGGradientRelease(gradientRef);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
