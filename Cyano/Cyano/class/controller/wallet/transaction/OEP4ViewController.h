//
//  OEP4ViewController.h
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTParentNavigationViewController.h"
#import "MDOep4InfoModel.h"


@interface OEP4ViewController : CTParentNavigationViewController
@property(nonatomic,strong)MDOep4InfoModel * model;
@property(nonatomic,copy)  NSString        * ontNum;
@property(nonatomic,copy)  NSString        * ongNum;
@property(nonatomic,assign)BOOL            isOEP4;
@end

