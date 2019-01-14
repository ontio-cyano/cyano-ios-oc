//
//  MDOep4InfoModel.m
//  Cyano
//
//  Created by Apple on 2019/1/11.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "MDOep4InfoModel.h"

@implementation MDOep4InfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"ContractHash": @"ContractHash",
             @"Decimals": @"Decimals",
             @"Logo": @"Logo",
             @"Name":@"Name",
             @"Symbol":@"Symbol"
             };
}

@end
