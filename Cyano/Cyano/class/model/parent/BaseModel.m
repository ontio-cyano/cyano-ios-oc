//
//  BaseModel.m
//  iQBTeacher
//
//  Created by Yuanhai on 25/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSAssert(NO, @"Not implemented.");
    return nil;
}

- (id)initFromDictionary:(NSDictionary *)dictJSON
{
    if (self = [super init])
    {
        NSError *error;
        self = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dictJSON error:&error];
        NSAssert(!error, error.localizedDescription);
    }
    return self;
}

- (NSDictionary *)serializeToDictionary
{
    NSError *error;
    NSDictionary *dictJSON = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    NSAssert(!error, error.localizedDescription);
    return dictJSON;
}

+ (NSArray<BaseModel *> *)loadArrayFromJSON:(NSArray<NSDictionary *> *)arrayJSON
{
    NSError *error;
    NSArray<BaseModel *> *arrayModel = [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:arrayJSON error:&error];
    NSAssert(!error, error.localizedDescription);
    return arrayModel;
}

+ (NSArray<NSDictionary *> *)serializeArrayToJSON:(NSArray<BaseModel *> *)arrayModel
{
    NSError *error;
    NSArray<NSDictionary *> *arrayJSON = [MTLJSONAdapter JSONArrayFromModels:arrayModel error:&error];
    NSAssert(!error, error.localizedDescription);
    return arrayJSON;
}

- (void)loadFromNetwork:(NSDictionary *)dictParam
{
    NSAssert(NO, @"Not implemented.");
}

// 时间戳与NSDate互转
+ (NSValueTransformer *)JSONTransformerForDateTime
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSNumber *serverTime = (NSNumber *)value;
        if ([serverTime longLongValue] == 0)
        {
            return nil;
        }
        return [NSDate dateWithTimeIntervalSince1970:([serverTime doubleValue] / 1000.0)];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = (NSDate *)value;
        if (date == nil)
        {
            return 0;
        }
        return @([date timeIntervalSince1970] * 1000);
    }];
}

// 'true' 转 YES
+ (NSValueTransformer *)JSONTransformerForBOOL
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSString *boolValue = (NSString *)value;
        return @([boolValue isEqualToString:@"true"]);
    }];
}

// '2018-11-21T13:26:44.000Z' 转 '昨天 13:26'
+ (NSValueTransformer *)JSONTransformerDateString
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSString *serverTime = (NSString *)value;
        if (serverTime.length == 0)
        {
            return nil;
        }
        return [GCHDateUtil formatCompactDateTime:serverTime];
    }];
}

// '2018-11-21T13:26:44.000Z' 转 'NSDate'
+ (NSValueTransformer *)JSONTransformerDateStringToDate
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSString *serverTime = (NSString *)value;
        if (serverTime.length == 0)
        {
            return nil;
        }
        return [GCHDateUtil getDateFromNormalZoneDateString:serverTime];
    }];
}

@end
