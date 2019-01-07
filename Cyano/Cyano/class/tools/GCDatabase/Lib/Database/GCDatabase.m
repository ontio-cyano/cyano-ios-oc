//
//  GCDatabase.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import "GCDatabase.h"

@implementation GCDatabase

+ (NSString *)databasePath
{
    return [NSString stringWithFormat:@"%@/gc.sqlite3", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
}

// 数组转换成And连接的Database字符串
+ (NSString *)getDatabaseStringFromArray:(NSArray *)infoArray
{
    NSString *setStr = @"";
    for (int f = 0; f < infoArray.count; f++)
    {
        NSString *info = [infoArray objectAtIndex:f];
        if (f % 2 == 0)
        {
            setStr = [NSString stringWithFormat:@"%@%@", setStr, info];
        }
        else
        {
            setStr = [NSString stringWithFormat:@"%@ in %@", setStr, info];
            
            // 不是最后加"And"继续
            if (f != infoArray.count - 1)
            {
                setStr = [NSString stringWithFormat:@"%@ and ", setStr];
            }
        }
    }
    return setStr;
}

// 数组转换成逗号连接的Database字符串
+ (NSString *)getDatabaseDotStringFromArray:(NSArray *)infoArray
{
    NSString *setStr = @"";
    for (int f = 0; f < infoArray.count; f++)
    {
        NSString *info = [infoArray objectAtIndex:f];
        if (f % 2 == 0)
        {
            setStr = [NSString stringWithFormat:@"%@%@", setStr, info];
        }
        else
        {
            setStr = [NSString stringWithFormat:@"%@ = %@", setStr, info];
            
            if (f != infoArray.count - 1)
            {
                setStr = [NSString stringWithFormat:@"%@, ", setStr];
            }
        }
    }
    return setStr;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dbLock = [[NSLock alloc] init];
    }
    return self;
}

+ (GCDatabase *)instance
{
    static GCDatabase *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[GCDatabase alloc] init];
        }
    }
    return instance;
}

- (BOOL)connDatabase
{
    if (sqlite3_open([[GCDatabase databasePath] UTF8String], &_myDatabase) != SQLITE_OK)
    {
        sqlite3_close(_myDatabase);
        return NO;
    }
    return YES;
}

- (BOOL)dealTable:(NSString *)sql
{
    [self.dbLock lock];
    char *errorMsg = nil;
    BOOL isSucceed = NO;
    if([self connDatabase])
    {
        int isOK = sqlite3_exec(_myDatabase, [sql UTF8String], NULL, NULL, &errorMsg);
        if(isOK == SQLITE_OK) isSucceed = YES;
    }
    sqlite3_close(_myDatabase);
    [self.dbLock unlock];
    return isSucceed;
}

// 创建表
- (BOOL)createTable:(NSString *)sql
{
    return [self dealTable:sql];
}

// 增
- (BOOL)insertTable:(NSString *)sql
{
    return [self dealTable:sql];
}

// 删
- (BOOL)deleteTable:(NSString *)sql
{
    return [self dealTable:sql];
}

// 改
- (BOOL)updateTable:(NSString *)sql
{
    return [self dealTable:sql];
}

// 查
- (NSMutableArray *)selectTable:(NSString *)sql
{
    [self.dbLock lock];
    NSMutableArray *allArray = [NSMutableArray array];
    if([self connDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_myDatabase, [sql UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                // Body
                NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
                
                // 所有字段
                int columnCount = sqlite3_column_count(statement);
                for (int column = 0; column < columnCount; column++)
                {
                    const char *valueChar = (const char *)sqlite3_column_text(statement, column);
                    if (valueChar)
                    {
                        NSString *key = [NSString stringWithUTF8String:sqlite3_column_name(statement, column)];
                        NSString *value = [NSString stringWithUTF8String:valueChar];
                        // Set Value
                        [bodyDic setObject:value forKey:key];
                    }
                }
                
                // Add
                if (bodyDic) [allArray addObject:bodyDic];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_myDatabase);
    }
    [self.dbLock unlock];
    return allArray;
}

@end
