
//
//  GCHThreadManager.m
//  CUBE
//
//  Created by Faney on 15/12/24.
//  Copyright © 2015年 Faney. All rights reserved.
//  线程管理

#import "GCHThreadManager.h"

@implementation GCHThreadManager

- (id)init
{
    self = [super init];
    if (self)
    {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

+ (GCHThreadManager *)instance
{
    static GCHThreadManager *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[GCHThreadManager alloc] init];
        }
    }
    return instance;
}

- (void)startThread:(SEL)selector toTarget:(id)target withObject:(id)argument
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:target selector:selector object:argument];
    [self.operationQueue addOperation:operation];
}

- (void)clearThread
{
    [self.operationQueue cancelAllOperations];
}

@end
