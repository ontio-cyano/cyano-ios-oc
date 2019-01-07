//
//  GCDBModel.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import "GCDBModel.h"

@implementation GCDBModel

- (id)init
{
    self = [super init];
    if (self)
    {
        [[self class] createTable];
    }
    return self;
}

@end
