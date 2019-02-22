//
//  CTParentLandscapeViewController.h
//  iQBTeacher
//
//  Created by Yuanhai on 23/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#define ScreenHeight UIScreen.mainScreen.bounds.size.height
#define ScreenWidth UIScreen.mainScreen.bounds.size.width

@interface CTParentLandscapeViewController : CTParentNavigationViewController

@property (strong, nonatomic) UIView *mainView; // 横屏基础视图
@property (assign, nonatomic) float width; // 基础视图宽度
@property (assign, nonatomic) float height; // 基础视图高度

@end
