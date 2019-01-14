//
//  MDOep4Model.m
//  Cyano
//
//  Created by Apple on 2019/1/11.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "MDOep4Model.h"
#import "MDOep4InfoModel.h"
@implementation MDOep4Model
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"ContractList": @"ContractList",
             };
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"ContractList"])
    {
        return [self JSONTransformerForMDOep4InfoModel];
    }
    return nil;
}
+ (NSValueTransformer *)JSONTransformerForMDOep4InfoModel
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
            MDOep4InfoModel *model = [[MDOep4InfoModel alloc] initFromDictionary:dic];
            [returnArr addObject:model];
        }
        
        return returnArr;
    }];
}
@end
