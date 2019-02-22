//
//  MDOep4Model.h
//  Cyano
//
//  Created by Apple on 2019/1/11.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "BaseModel.h"


@class MDOep4InfoModel;
@interface MDOep4Model : BaseModel
@property (strong, nonatomic) NSArray <MDOep4InfoModel *> *ContractList;
@end

