//
//  NSObject+DB_Common.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import "NSObject+DB_Common.h"
#import "NSObject+MJProperty.h"

@implementation NSObject (DB_Common)

// 名称
+ (NSString *)modelName
{
    return [NSString stringWithUTF8String:object_getClassName([self class])];
}

// 不需要加入数据库的属性
+ (NSArray *)exceptProperty
{
    return @[@"hash", @"superclass", @"description", @"debugDescription", @"dictionaryValue"];
}

// 属性
+ (void)enumNSObjectProperties:(void(^)(MJProperty *property, BOOL *stop))properties
{
    [self mj_enumerateProperties:^(MJProperty *p, BOOL *stop) {
        BOOL haveExcept = NO;
        for (NSString *except in [self exceptProperty])
        {
            if ([p.name isEqualToString:except])
            {
                haveExcept = YES;
                break;
            }
        }
        if (!haveExcept)
        {
            properties(p, stop);
        }
    }];
}

// 删除字符
+ (NSString *)deleteLastChar:(NSString *)str length:(int)length
{
    if(str.length == 0) return @"";
    if(str.length < length) return str;
    return [str substringToIndex:str.length - length];
}

@end
