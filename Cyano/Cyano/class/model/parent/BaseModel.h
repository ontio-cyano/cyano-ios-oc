//
//  BaseModel.h
//  iQBTeacher
//
//  Created by Yuanhai on 25/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mantle.h"

@interface BaseModel : MTLModel <MTLJSONSerializing>

/**
 Load data from dictionary into model.
 It uses MTLJSONAdapter to parse model's properties from JSON dictionary.
 Subclass must implement:
 + (NSDictionary *)JSONKeyPathsByPropertyKey
 + (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
 */
- (id)initFromDictionary:(NSDictionary *)dictJSON;

/**
 Serialize this model into JSON dictionary. It's same key as "initFromDictionary".
 */
- (NSDictionary *)serializeToDictionary;

/**
 Load an array of model from JSON array.
 */
+ (NSArray<BaseModel *> *)loadArrayFromJSON:(NSArray<NSDictionary *> *)arrayJSON;

/**
 Serialize a model array into JSON array.
 */
+ (NSArray<NSDictionary *> *)serializeArrayToJSON:(NSArray<BaseModel *> *)arrayModel;

/**
 Send request to server and parse json into model.
 */
- (void)loadFromNetwork:(NSDictionary *)dictParam;

// 时间戳与NSDate互转
+ (NSValueTransformer *)JSONTransformerForDateTime;

// 'true' 转 YES
+ (NSValueTransformer *)JSONTransformerForBOOL;

// '2018-11-21T13:26:44.000Z' 转 '昨天 13:26'
+ (NSValueTransformer *)JSONTransformerDateString;

// '2018-11-21T13:26:44.000Z' 转 'NSDate'
+ (NSValueTransformer *)JSONTransformerDateStringToDate;

// '2016-05-21' 转 '3.5岁'
+ (NSValueTransformer *)JSONTransformerAge;

// 'girl' 转 '女宝'
+ (NSValueTransformer *)JSONTransformerSex;

@end
