//
//  MDApps.h
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "BaseModel.h"
#import "MDBanner.h"
#import "MDApp.h"

@interface MDApps : BaseModel

@property (strong, nonatomic) NSArray <MDBanner *> *banner;
@property (strong, nonatomic) NSArray <MDApp *> *apps;

@end
