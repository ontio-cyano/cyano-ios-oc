//
//  NSObject+DB_Insert.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//  增

#import "NSObject+DB_Insert.h"
#import "NSObject+DB_Common.h"
#import "GCDatabase.h"

@implementation NSObject (DB_Insert)

+ (void)insert:(id)model
{
    NSString *modelName = [self modelName];
    
    // SQL
    // insert or replace into table (name, name1) values ('value', 'value1')
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"insert or replace into %@ (", modelName];
    
    NSMutableArray *keyArr = [NSMutableArray array];
    NSMutableArray *valueArr = [NSMutableArray array];
    [self enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        NSString *key = property.name;
        id value = [model valueForKey:key];
        if (value)
        {
            [keyArr addObject:key];
            [valueArr addObject:value];
        }
    }];
    
    // Keys
    NSMutableString *keyStr = [NSMutableString string];
    for (NSString *key in keyArr)
    {
        [keyStr appendFormat:@"%@,", key];
    }
    [sql appendFormat:@"%@)", [self deleteLastChar:keyStr length:1]];
    
    // Values
    [sql appendFormat:@" values ("];
    NSMutableString *valueStr = [NSMutableString string];
    for (NSString *value in valueArr)
    {
        if ([value isKindOfClass:[NSString class]])
        {
            [valueStr appendFormat:@"'%@',", value];
        }
        else if ([value isKindOfClass:[NSDate class]])
        {
            [valueStr appendFormat:@"%lld,", [self convertToServerTime:(NSDate *)value]];
        }
        else
        {
            [valueStr appendFormat:@"%@,", value];
        }
    }
    [sql appendFormat:@"%@)", [self deleteLastChar:valueStr length:1]];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    if(![[GCDatabase instance] insertTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 增失败", modelName);
    }
}

+ (unsigned long long)convertToServerTime:(NSDate *)date
{
    return [date timeIntervalSince1970] * 1000;
}

@end
