//
//  GCDatabase.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface GCDatabase : NSObject

@property (assign, nonatomic) sqlite3 *myDatabase;

@property (strong, nonatomic) NSLock *dbLock;

+ (GCDatabase *)instance;

+ (NSString *)databasePath;

// 数组转换成And连接的Database字符串
+ (NSString *)getDatabaseStringFromArray:(NSArray *)infoArray;

// 数组转换成逗号连接的Database字符串
+ (NSString *)getDatabaseDotStringFromArray:(NSArray *)infoArray;

// 创建表
- (BOOL)createTable:(NSString *)sql;

// 增
- (BOOL)insertTable:(NSString *)sql;

// 删
- (BOOL)deleteTable:(NSString *)sql;

// 改
- (BOOL)updateTable:(NSString *)sql;

// 查
- (NSMutableArray *)selectTable:(NSString *)sql;

@end
