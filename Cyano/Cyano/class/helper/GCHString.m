//
//  GCHString.m
//  Cyano
//
//  Created by Yuanhai on 13/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "GCHString.h"

@implementation GCHString

+ (float)getTextWidth:(NSString *)text font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(100000, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    return rect.size.width;
}

+ (NSString *)trimString:(NSString *)str trimInside:(BOOL)inside
{
    if (!inside)
    {
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    else
    {
        return [[str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    }
}

+ (NSString *)getDictionaryValue:(NSString *)dicStr
{
    NSArray *arr = [dicStr componentsSeparatedByString:@":"];
    if (arr.count < 2) return @"";
    return arr[1];
}

@end
