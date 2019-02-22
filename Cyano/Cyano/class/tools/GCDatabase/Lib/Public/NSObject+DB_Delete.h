//
//  NSObject+DB_Delete.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DB_Delete)

+ (void)deleteWhereArray:(NSArray *)whereArray;

+ (void)deleteTable;

@end
