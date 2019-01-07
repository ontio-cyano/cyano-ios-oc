//
//  NSObject+DB_Create.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//  创建表

#import "NSObject+DB_Create.h"
#import "NSObject+DB_Common.h"
#import "GCDatabase.h"

@implementation NSObject (DB_Create)

+ (void)createTable
{
    NSString *modelName = [self modelName];

    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"create table if not exists %@ (", modelName];
    
    // 属性
    [self enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        NSString *sql_field = [self fieldSql:property];
        [sql appendString:sql_field];
     }];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@);", [self deleteLastChar:sql length:1]];
    if(![[GCDatabase instance] createTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 创建表失败", modelName);
    }
}

// 排列要添加字段('Key Type,')
+ (NSString *)fieldSql:(MJProperty *)ivar
{
    NSString *sqliteTye = INTEGER_TYPE;
    if ([ivar.type.code isEqualToString:CoreNSString])
    {
        sqliteTye = TEXT_TYPE;
    }
    else if ([ivar.type.code isEqualToString:CoreNSDate])
    {
        sqliteTye = TIMESTAMP_TYPE;
    }
    NSString *fieldSql=[NSString stringWithFormat:@"%@ %@",ivar.name, sqliteTye];
    if ([ivar.name isEqualToString:@"_id"]) fieldSql = [NSString stringWithFormat:@"%@ primary key", fieldSql];
    fieldSql = [NSString stringWithFormat:@"%@,", fieldSql];
    return fieldSql;
}

@end
