//
//  GCDBModel.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DB_Create.h"
#import "NSObject+DB_Insert.h"
#import "NSObject+DB_Delete.h"
#import "NSObject+DB_Update.h"
#import "NSObject+DB_Select.h"

@interface GCDBModel : NSObject

@property (assign, nonatomic) NSInteger _id;

@end
