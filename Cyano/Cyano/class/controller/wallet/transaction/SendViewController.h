//
//  SendViewController.h
//  Cyano
//
//  Created by Apple on 2019/1/10.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTParentNavigationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendViewController : CTParentNavigationViewController
@property(nonatomic,strong)NSDictionary * walletDict;
@property(nonatomic,copy)  NSString     * ontNum;
@property(nonatomic,copy)  NSString     * ongNum;
@property(nonatomic,assign)BOOL           isONT;
@end

NS_ASSUME_NONNULL_END
