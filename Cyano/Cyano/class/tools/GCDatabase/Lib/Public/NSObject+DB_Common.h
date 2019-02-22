//
//  NSObject+DB_Common.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import "MJProperty.h"
#import "GCModelConst.h"

@interface NSObject (DB_Common)

// 名称
+ (NSString *)modelName;

// 不需要加入数据库的属性
+ (NSArray *)exceptProperty;

// 属性
+ (void)enumNSObjectProperties:(void(^)(MJProperty *property, BOOL *stop))properties;

// 删除字符
+ (NSString *)deleteLastChar:(NSString *)str length:(int)length;

@end
