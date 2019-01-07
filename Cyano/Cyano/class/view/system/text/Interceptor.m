//
//  Interceptor.m
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "Interceptor.h"

@implementation Interceptor

-(id)init
{
    if (self = [super init])
    {
        self.receiver = nil;
        self.middleMan = nil;
    }
    return self;
}

- (void)setMiddleMan:(id)middleMan
{
    if (middleMan != self)
    {
        _middleMan = middleMan;
    }
}

-(void)setReceiver:(id)receiver
{
    if (receiver != self && receiver != self.middleMan)
    {
        _receiver = receiver;
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.middleMan respondsToSelector:aSelector])
    {
        return self.middleMan;
    }
    if ([self.receiver respondsToSelector:aSelector])
    {
        return self.receiver;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.middleMan respondsToSelector:aSelector])
    {
        //stop at super, fix crash in UITextField keyboardInputChanged:
        if ([[self.middleMan superclass] instancesRespondToSelector:aSelector])
        {
            return NO;
        }
        return YES;
    }
    if ([self.receiver respondsToSelector:aSelector])
    {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

@end
