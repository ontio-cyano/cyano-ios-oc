//
//  GCHThreadManager.h
//  CUBE
//
//  Created by Faney on 15/12/24.
//  Copyright © 2015年 Faney. All rights reserved.
//

@interface GCHThreadManager : NSObject

+ (GCHThreadManager *)instance;

@property (strong, nonatomic) NSOperationQueue *operationQueue;

- (void)startThread:(SEL)selector toTarget:(id)target withObject:(id)argument;

- (void)clearThread;

@end
