//
//  NSObject+DB_Update.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//  改

#import "NSObject+DB_Update.h"
#import "NSObject+DB_Common.h"
#import "GCDatabase.h"

@implementation NSObject (DB_Update)

+ (void)update:(id)model
{
    NSString *modelName = [self modelName];
    
    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"update %@ set ", modelName];
    
    // Update
    NSMutableString *where = [NSMutableString string];
    [self enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        NSString *key = property.name;
        id value = [model valueForKey:key];
        if (value)
        {
            // Where
            if ([key isEqualToString:@"_id"])
            {
                [where appendString:[GCDatabase getDatabaseStringFromArray:@[key, [NSString stringWithFormat:@"(%@)", value]]]];
            }
            // Set
            else
            {
                if ([value isKindOfClass:[NSString class]])
                {
                    value = [NSString stringWithFormat:@"'%@'", value];
                }
                [sql appendFormat:@"%@=%@,", key, value];
            }
        }
    }];
    [sql deleteCharactersInRange:NSMakeRange(sql.length - 1, 1)];
    
    // Where
    [sql appendFormat:@" where %@", where];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    if(![[GCDatabase instance] updateTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 改失败", modelName);
    }
}

+ (void)updateWhereArray:(NSArray *)whereArray changeArray:(NSArray *)changeArray
{
    NSString *modelName = [self modelName];
    
    // SQL
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"update %@ set %@ where %@", modelName, [GCDatabase getDatabaseDotStringFromArray:changeArray], [GCDatabase getDatabaseStringFromArray:whereArray]];
    
    // Database
    NSString *db = [NSString stringWithFormat:@"%@;", sql];
    if(![[GCDatabase instance] updateTable:db])
    {
        NSLog(@"db:%@", db);
        NSLog(@"%@ 改失败", modelName);
    }
}

@end
