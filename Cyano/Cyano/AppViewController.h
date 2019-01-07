//
//  AppViewController.h
//  Painter
//
//  Created by Yuanhai on 23/8/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTWalletViewController.h"
#import "CTIdentityViewController.h"
#import "CTAppsViewController.h"
#import "CTSettingViewController.h"

@interface AppViewController : UIViewController

@property (assign, nonatomic) int whichTabSelect;
@property (strong, nonatomic) UIView *tab_bar;

@property (strong, nonatomic) CTWalletViewController *walletViewController;
@property (strong, nonatomic) CTIdentityViewController *identityViewController;
@property (strong, nonatomic) CTAppsViewController *appsViewController;
@property (strong, nonatomic) CTSettingViewController *settingViewController;

@end
