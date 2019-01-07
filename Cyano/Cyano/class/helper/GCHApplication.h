//
//  GCHApplication.h
//  ComfortHome
//
//  Created by Yuanhai on 15/8/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCHApplication : NSObject

// 应用初始化
+ (void)initDelegate;

// 是否显示白字导航
+ (void)setStatusBarWithLightColor:(BOOL)light;

// 返回到第几个界面
+ (void)popControllerWithPage:(NSNumber *)page;

// 跳转到指定网页
+ (void)pushToWebController:(NSString *)title url:(NSString *)url;

// 保存账号
+ (void)saveDefaultAccount:(ONTAccount *)account password:(NSString *)password;

// 删除账号
+ (void)clearDefaultAccount;

// 输入密码
+ (void)inputPassword:(void(^)(void))callBack;

// 请求获取默认账号
+ (ONTAccount *)requestDefaultAccount;

@end
