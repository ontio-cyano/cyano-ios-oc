//
//  GCHApplication.m
//  ComfortHome
//
//  Created by Yuanhai on 15/8/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "GCHApplication.h"
#import "CTWebViewController.h"
#import "CTEnterPasswordViewController.h"
#import "CVEnterPasswordView.h"

@implementation GCHApplication

// 应用初始化
+ (void)initDelegate
{
    // 创建需要的文件
    [self initNeedFiles];
}

// 创建需要的文件
+ (void)initNeedFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:Image_Path])
    {
        [fileManager createDirectoryAtPath:Image_Path withIntermediateDirectories:NO attributes:nil error:nil];
    }
}

// 是否显示白字导航
+ (void)setStatusBarWithLightColor:(BOOL)light
{
    if (light)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

// 返回到第几个界面
+ (void)popControllerWithPage:(NSNumber *)page
{
    NSArray *viewControllers = MainAppDelegate.navigationController.viewControllers;
    int index = (int)viewControllers.count - 1 - [page intValue];
    [MainAppDelegate.navigationController popToViewController:[viewControllers objectAtIndex:index > 0 ? index : 0] animated:YES];
}

// 跳转到指定网页
+ (void)pushToWebController:(NSString *)title url:(NSString *)url
{
    CTWebViewController *controller = [[CTWebViewController alloc] init];
    controller.controllerTitle = title;
    controller.urlString = url;
    [MainAppDelegate.navigationController pushViewController:controller animated:YES];
}

// 保存账号
+ (void)saveDefaultAccount:(ONTAccount *)account password:(NSString *)password
{
    MDAccount *model = [[MDAccount alloc] init];
    model.name = account.name;
    model.mnemonicText = account.mnemonicText;
    model.encryptMnemonicText = account.encryptMnemonicText;
    model.privateKeyHex = account.privateKeyHex;
    model.wif = account.wif;
    model.keystore = account.keystore;
    model.password = password;
    model.address = account.address.address;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:kAccount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 删除账号
+ (void)clearDefaultAccount
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 输入密码
+ (void)inputPassword:(void(^)(void))callBack
{
    CVEnterPasswordView *passwordView = [[CVEnterPasswordView alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^ {
        [passwordView show];
    });
    passwordView.callBack = ^() {
        callBack();
    };
}

// 请求获取默认账号
+ (ONTAccount *)requestDefaultAccount
{
    NSString *wif = [GCHRAM instance].defaultAccount.wif;
    NSString *password = [GCHRAM instance].defaultAccount.password;
    ONTAccount *account = [[ONTAccount alloc] initWithName:@"" password:password wif:wif];
    return account;
}

@end
