//
//  GCHInputVerify.m
//  Cyano
//
//  Created by Yuanhai on 29/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "GCHInputVerify.h"

@implementation GCHInputVerify

+ (BOOL)containsEmoji:(NSString *)text
{
    // emoji表情
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *match = [regex matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    return (match.count > 0);
}

+ (BOOL)verifyPassword:(NSString *)password
{
    if (password.length < 6)
    {
        [CVShowLabelView showTitle:@"密码必须不少于6个字符" detail:nil];
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateMoblieNumber:(NSString *)number showToast:(BOOL)showToast
{
    number = [GCHString trimString:number trimInside:YES];
    if (number.length < 11)
    {
        if (showToast)
        {
            [CVShowLabelView showTitle:@"请输入完整的11位手机号码" detail:nil];
        }
        return NO;
    }
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[1]\\d{10}$"];
    BOOL res = [regex evaluateWithObject:number];
    if (res)
    {
        return YES;
    }
    else
    {
        if (showToast)
        {
            [CVShowLabelView showTitle:@"手机号码格式不正确" detail:nil];
        }
        return NO;
    }
}

@end
