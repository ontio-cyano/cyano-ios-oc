//
//  GCHInputVerify.h
//  Cyano
//
//  Created by Yuanhai on 29/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCHInputVerify : NSObject

+ (BOOL)containsEmoji:(NSString *)text;

+ (BOOL)verifyPassword:(NSString *)password;

+ (BOOL)validateMoblieNumber:(NSString *)number showToast:(BOOL)showToast;

@end
