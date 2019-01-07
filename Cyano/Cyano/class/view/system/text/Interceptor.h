//
//  Interceptor.h
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interceptor : NSObject

@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;

@end
