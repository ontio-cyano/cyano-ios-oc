//
//  MDApps.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "MDApps.h"

@implementation MDApps

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"banner": @"banner",
             @"apps": @"apps",
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"banner"])
    {
        return [self JSONTransformerForMDBanner];
    }
    else if ([key isEqualToString:@"apps"])
    {
        return [self JSONTransformerForMDApp];
    }
    return nil;
}

// MDBanner
+ (NSValueTransformer *)JSONTransformerForMDBanner
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *serverArr = (NSArray *)value;
        if (serverArr.count <= 0)
        {
            return value;
        }
        
        NSMutableArray *returnArr = [NSMutableArray array];
        for (NSDictionary *dic in serverArr)
        {
            MDBanner *model = [[MDBanner alloc] initFromDictionary:dic];
            [returnArr addObject:model];
        }
        
        return returnArr;
    }];
}

// MDApp
+ (NSValueTransformer *)JSONTransformerForMDApp
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *serverArr = (NSArray *)value;
        if (serverArr.count <= 0)
        {
            return value;
        }
        
        NSMutableArray *returnArr = [NSMutableArray array];
        for (NSDictionary *dic in serverArr)
        {
            MDApp *model = [[MDApp alloc] initFromDictionary:dic];
            [returnArr addObject:model];
        }
        
        return returnArr;
    }];
}

@end
