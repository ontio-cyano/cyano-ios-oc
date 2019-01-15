//
//  CTPaySureViewController.h
//  Cyano
//
//  Created by Apple on 2019/1/15.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTParentNavigationViewController.h"


@interface CTPaySureViewController : CTParentNavigationViewController
@property(nonatomic,copy)  NSString * toAddress;
@property(nonatomic,copy)  NSString * payerAddress;
@property(nonatomic,copy)  NSString * payMoney;
@property(nonatomic,copy)  NSString * callback;
@property(nonatomic,copy)  NSString * passwordString;
@property(nonatomic,copy)  NSString * hashString;
@property(nonatomic,strong)NSDictionary * payInfo;
@property(nonatomic,strong)NSDictionary * defaultDic;
@property(nonatomic,strong)NSDictionary * payDetailDic;
@property(nonatomic,assign)BOOL isONT;
@property(nonatomic,strong)ONTAccount   *   account;
@end

