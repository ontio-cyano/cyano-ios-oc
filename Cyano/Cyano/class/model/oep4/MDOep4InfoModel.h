//
//  MDOep4InfoModel.h
//  Cyano
//
//  Created by Apple on 2019/1/11.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "BaseModel.h"



@interface MDOep4InfoModel : BaseModel
@property (nonatomic, strong) NSString *ContractHash;
@property (nonatomic, assign) int Decimals;
@property (nonatomic, strong) NSString *Logo;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Symbol;
@end


