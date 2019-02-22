//
//  NSObject+DB_Update.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DB_Update)

+ (void)update:(id)model;

+ (void)updateWhereArray:(NSArray *)whereArray changeArray:(NSArray *)changeArray;

@end
