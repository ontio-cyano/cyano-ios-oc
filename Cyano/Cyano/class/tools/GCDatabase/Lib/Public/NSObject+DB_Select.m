//
//  NSObject+DB_Select.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//  查

#import "NSObject+DB_Select.h"
#import "NSObject+DB_Common.h"
#import "GCDatabase.h"
#import "GCDatabase.h"

@implementation NSObject (DB_Select)

+ (NSMutableArray *)selectWhereArray:(NSArray *)whereArray orderBy:(NSString *)orderBy
{
    NSString *modelName = [self modelName];
    
    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"select * from %@", modelName];
    if (whereArray) [sql appendFormat:@" where %@", [GCDatabase getDatabaseStringFromArray:whereArray]];
    if (orderBy) [sql appendFormat:@"%@ %@", sql, orderBy];
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    NSArray *selectArr = [[GCDatabase instance] selectTable:db];
    
    // 返回数组
    NSMutableArray *returnArray = [NSMutableArray array];
    for (NSDictionary *dic in selectArr)
    {
        NSObject *model = [[self alloc] init];
        for (NSString *key in dic.allKeys)
        {
            NSObject *value = [dic objectForKey:key];
            if ([self isDateType:key])
            {
                value = [self convertToAppTime:[(NSNumber *)value longLongValue]];
            }
            [model setValue:value forKey:key];
        }
        [returnArray addObject:model];
    }
    
    // 若空数组，则添加一个空对象
    if (returnArray.count <= 0) return nil;
    return returnArray;
}

+ (BOOL)isDateType:(NSString *)checkType
{
    // 获取对象属性类型
    NSMutableArray *valueArr = [NSMutableArray array];
    [self enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        NSString *key = property.name;
        NSString *value = property.type.code;
        if ([key isEqualToString:checkType] && [value isEqualToString:CoreNSDate])
        {
            [valueArr addObject:@(YES)];
        }
    }];
    return valueArr.count > 0;
}

+ (NSDate *)convertToAppTime:(unsigned long long)serverTime
{
    return [NSDate dateWithTimeIntervalSince1970:(serverTime / 1000.0)];
}

@end
