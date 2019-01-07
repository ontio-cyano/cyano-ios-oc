//
//  NSObject+DB_Delete.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//  删

#import "NSObject+DB_Delete.h"
#import "NSObject+DB_Common.h"
#import "GCDatabase.h"

@implementation NSObject (DB_Delete)

+ (void)deleteWhereArray:(NSArray *)whereArray
{
    NSString *modelName = [self modelName];
    
    // 删除场景中的该设备
    [self deleteDeviceFromScenario:whereArray];
    
    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"delete from %@ where %@", modelName, [GCDatabase getDatabaseStringFromArray:whereArray]];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    if(![[GCDatabase instance] deleteTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 删失败", modelName);
    }
}

+ (void)deleteTable
{
    NSString *modelName = [self modelName];
    
    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"delete from %@", modelName];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    if(![[GCDatabase instance] createTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 删除表失败", modelName);
    }
}

// 删除场景中的该设备
+ (void)deleteDeviceFromScenario:(NSArray *)whereArray
{
//    if ([modelName is]) {
//        <#statements#>
//    }
}

@end
