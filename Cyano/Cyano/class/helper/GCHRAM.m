//
//  GCHRAM.m
//  Cyano
//
//  Created by Yuanhai on 20/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "GCHRAM.h"

@implementation GCHRAM

+ (GCHRAM *)instance
{
    static GCHRAM *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[GCHRAM alloc] init];
        }
    }
    return instance;
}

- (MDAccount *)defaultAccount
{
    if (!_defaultAccount)
    {
        NSData *accountData = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
        _defaultAccount = [NSKeyedUnarchiver unarchiveObjectWithData:accountData];
    }
    return _defaultAccount;
}

@end
