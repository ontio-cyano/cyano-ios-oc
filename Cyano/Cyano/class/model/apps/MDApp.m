//
//  MDApp.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "MDApp.h"

@implementation MDApp

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name": @"name",
             @"icon": @"icon",
             @"link": @"link",
             };
}

@end
