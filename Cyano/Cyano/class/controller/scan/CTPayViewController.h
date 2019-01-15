//
//  CTPayViewController.h
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTParentNavigationViewController.h"



@interface CTPayViewController : CTParentNavigationViewController
@property(nonatomic,strong)NSDictionary *   payInfo;
@property(nonatomic,strong)ONTAccount   *   account;
@end


