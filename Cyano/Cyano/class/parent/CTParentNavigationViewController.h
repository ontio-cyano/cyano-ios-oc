//
//  CTParentNavigationViewController.h
//  iQBTeacher
//
//  Created by Yuanhai on 23/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVNavBarView.h"

typedef enum
{
    ShowControllerType_Push = 0,
    ShowControllerType_Present,
}
ShowControllerType;

typedef enum
{
    GoBackType_None = 0,
    GoBackType_Back,
    GoBackType_Cancel,
    GoBackType_BackBlack,
}
GoBackType;

@interface CTParentNavigationViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) CVNavBarView *navBar;
@property (assign, nonatomic) ShowControllerType showControllerType;
@property (strong, nonatomic) NSURLSessionDataTask *customRequest;
@property (strong, nonatomic) NSString *controllerTitle;
@property (assign, nonatomic) BOOL needCheckKeyboard;

#pragma mark - Table

@property (assign, nonatomic) BOOL requesting;
@property (assign, nonatomic) BOOL requestMoreDone;

#pragma mark - Title View

- (void)initTitleViewWithText:(NSString *)title;

#pragma mark - Left Item

- (void)initLeftNavigationBarWithImageName:(NSString *)imageName;
- (void)initLeftNavigationBarWithTitle:(NSString *)title;
- (void)destroyLeftNavigationBar;

#pragma mark - Right Item

- (void)initRightNavigationBarWithImageName:(NSString *)imageName;
- (void)initRightNavigationBarWithImageName:(NSString *)imageName color:(UIColor *)color;
- (void)initRightSecondNavigationBarWithImageName:(NSString *)imageName;
- (void)initRightNavigationBarWithTitle:(NSString *)title;

#pragma mark - Extends

// (继承)注册侦查者
- (void)addObserverSelectors;

// (继承)Left Nav Button Press
- (void)navLeftButtonItemPressed;

// (继承)Right Nav Button Press
- (void)navRightButtonItemPressed;

// (继承)Right Second Nav Button Press
- (void)navRightSecondButtonItemPressed;

// (继承)Tab 切换
- (void)tabChangeController;

#pragma mark - Others

// 从父View中获取Cell View
- (UITableViewCell *)getParentCellView:(UIView *)view;

// Nav Bar
- (void)setMainNavigationBar:(NavigationBarType)barType goBack:(GoBackType)goBack;

// 隐藏左Item
- (void)hideLeftNavigationItem;

// 禁用右Item
- (void)disableRightNavigationItem:(BOOL)disable;

// 弹出相册权限
- (void)showAlbumAuthorizedAlert;

@end
