//
//  AppDelegate.m
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:209 / 255.0f green:203 / 255.0f blue:198 / 255.0f alpha:1.0f];
    [self.window makeKeyAndVisible];
    
    // 白字状态栏
    [GCHApplication setStatusBarWithLightColor:YES];
    
    // 应用初始化
    [GCHApplication initDelegate];
    
    // Navigation
    self.navigationController = [[CTAppNavViewController alloc] initWithRootViewController:self.appViewController];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = self.navigationController;
    
    return YES;
}

- (AppViewController *)appViewController
{
    if (!_appViewController) _appViewController = [[AppViewController alloc] init];
    return _appViewController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
