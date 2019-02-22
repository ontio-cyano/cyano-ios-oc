//
//  CTLoginViewController.h
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTParentNavigationViewController.h"


@interface CTLoginViewController : CTParentNavigationViewController
@property(nonatomic,strong)NSDictionary *   loginInfo;
@property(nonatomic,strong)ONTAccount   *   account;
@end

