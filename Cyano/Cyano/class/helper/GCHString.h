//
//  GCHString.h
//  Cyano
//
//  Created by Yuanhai on 13/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCHString : NSObject

+ (float)getTextWidth:(NSString *)text font:(UIFont *)font;

+ (NSString *)trimString:(NSString *)str trimInside:(BOOL)inside;

+ (NSString *)getDictionaryValue:(NSString *)dicStr;

@end
