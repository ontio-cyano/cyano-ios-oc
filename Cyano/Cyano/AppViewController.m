//
//  AppViewController.m
//  Painter
//
//  Created by Yuanhai on 23/8/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) NSMutableArray *tabControllerArray;

@end

@implementation AppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (SystemVersion >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.mainView = [[UIView alloc] init];
    self.mainView.frame = CGRectMake(- home_move_x, 0.0f, self.view.frame.size.width + home_move_x * 2, self.view.frame.size.height);
    [self.view addSubview:self.mainView];
    
    _whichTabSelect = 0;
    
    [self initNavigationControllers];
    [self initBottomToolView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
    if (self.tabControllerArray.count > self.whichTabSelect)
    {
        UIViewController *nowController = (UIViewController *)[self.tabControllerArray objectAtIndex:self.whichTabSelect];
        [nowController viewDidAppear:NO];
    }
}

#pragma
#pragma mark - TabController

// 添加所有主导航控制器
- (void)initNavigationControllers
{
    self.tabControllerArray = [NSMutableArray array];
    
    self.walletViewController = [[CTWalletViewController alloc] init];
    self.walletViewController.view.frame = CGRectMake(home_move_x, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.mainView addSubview:self.walletViewController.view];
    self.walletViewController.view.hidden = NO;
    [self.tabControllerArray addObject:self.walletViewController];
    
    self.identityViewController = [[CTIdentityViewController alloc] init];
    self.identityViewController.view.frame = CGRectMake(home_move_x, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.mainView addSubview:self.identityViewController.view];
    self.identityViewController.view.hidden = YES;
    [self.tabControllerArray addObject:self.identityViewController];
    
    self.appsViewController = [[CTAppsViewController alloc] init];
    self.appsViewController.view.frame = CGRectMake(home_move_x, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.mainView addSubview:self.appsViewController.view];
    self.appsViewController.view.hidden = YES;
    [self.tabControllerArray addObject:self.appsViewController];
    
    self.settingViewController = [[CTSettingViewController alloc] init];
    self.settingViewController.view.frame = CGRectMake(home_move_x, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.mainView addSubview:self.settingViewController.view];
    self.settingViewController.view.hidden = YES;
    [self.tabControllerArray addObject:self.settingViewController];
}

- (void)setWhichTabSelect:(int)whichTabSelect
{
    UIViewController *lastController = (UIViewController *)[self.tabControllerArray objectAtIndex:_whichTabSelect];
    UIViewController *nowController = (UIViewController *)[self.tabControllerArray objectAtIndex:whichTabSelect];
    
    _whichTabSelect = whichTabSelect;
    
    [self initBottomToolView];
    
    lastController.view.hidden = YES;
    nowController.view.hidden = NO;
    [self performSelector:@selector(changeController:) withObject:@[lastController, nowController] afterDelay:0.1f];
}

- (void)changeController:(NSArray *)controllers
{
    if (controllers.count != 2) return;
    UIViewController *lastController = [controllers objectAtIndex:0];
    UIViewController *nowController = [controllers objectAtIndex:1];
    [lastController viewDidDisappear:NO];
    [nowController viewDidAppear:NO];
    [(CTParentNavigationViewController *)nowController tabChangeController];
}

- (void)initBottomToolView
{
    if (!self.tab_bar)
    {
        self.tab_bar = [[UIView alloc] init];
        self.tab_bar.frame = CGRectMake(home_move_x, self.view.frame.size.height - tabBarHeight, self.view.frame.size.width, tabBarHeight);
        self.tab_bar.backgroundColor = PurityColor(250);
        [self.mainView addSubview:self.tab_bar];
    }
    
    for (UIView *view in self.tab_bar.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIView *upLine = [[UIView alloc] init];
    upLine.frame = CGRectMake(0.0f, 0.0f, self.tab_bar.width, border_line_height);
    upLine.backgroundColor = PurityColor(214);
    [self.tab_bar addSubview:upLine];
    
    NSArray *tabViewArray =
    @[
      @{@"title" : @"Asset", @"image" : @"tab_asset"},
      @{@"title" : @"Ont Id", @"image" : @"tab_id"},
      @{@"title" : @"DApp", @"image" : @"tab_game"},
      @{@"title" : @"Setting", @"image" : @"tab_me"},
      ];
    
    float imageRadius = tabBarHeight * 0.45;
    float titleHeight = imageRadius * 0.6;
    float imageTitleSpacing = 5.0f;
    float itemWidth = self.view.frame.size.width / tabViewArray.count;
    
    for (int f = 0; f < tabViewArray.count; f++)
    {
        NSDictionary *itemDic = [tabViewArray objectAtIndex:f];
        
        // Item Button
        UIButton *itemButton = [[UIButton alloc] init];
        itemButton.tag = f + 1;
        [itemButton addTarget:self action:@selector(toolBarItemButton:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.frame = CGRectMake(itemWidth * f, 0.0f, itemWidth, tabBarHeight);
        [self.tab_bar addSubview:itemButton];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((itemWidth - imageRadius) / 2, (tabBarHeight - imageRadius - titleHeight - imageTitleSpacing) / 2, imageRadius, imageRadius);
        [itemButton addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // Title
        float labelY = (tabBarHeight - imageRadius - titleHeight - imageTitleSpacing) / 2 + imageRadius + imageTitleSpacing;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0.0f, labelY, itemButton.frame.size.width, titleHeight);
        titleLabel.font = AppleFont_UltraLight(12);
        titleLabel.text = [itemDic objectForKey:@"title"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [itemButton addSubview:titleLabel];
        
        // Select
        if (f == self.whichTabSelect)
        {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [itemDic objectForKey:@"image"]]];
            titleLabel.textColor = RGBCOLOR(60, 79, 94);
        }
        else
        {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_un_selected", [itemDic objectForKey:@"image"]]];
            titleLabel.textColor = RGBCOLOR(170, 179, 180);
        }
    }
}

- (void)toolBarItemButton:(UIView *)item
{
    // 选择同一个Tab
    if (self.whichTabSelect == (int)item.tag - 1)
    {
        return;
    }
    
    // Tab选择
    self.whichTabSelect = (int)item.tag - 1;
}

#pragma mark - override

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
