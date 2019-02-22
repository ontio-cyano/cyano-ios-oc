//
//  AppDelegate.h
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAppNavViewController.h"
#import "AppViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CTAppNavViewController *navigationController;
@property (strong, nonatomic) AppViewController *appViewController;


@end

