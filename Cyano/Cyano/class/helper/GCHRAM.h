//
//  GCHRAM.h
//  Cyano
//
//  Created by Yuanhai on 20/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCHRAM : NSObject

@property (strong, nonatomic) MDAccount *defaultAccount;

+ (GCHRAM *)instance;

@end
