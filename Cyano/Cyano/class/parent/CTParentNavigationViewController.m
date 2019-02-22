//
//  CTParentNavigationViewController.m
//  iQBTeacher
//
//  Created by Yuanhai on 23/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//
//  带导航的Controller

#import "CTParentNavigationViewController.h"
#import "CVNavBackView.h"
#import "CVNavCancelView.h"

// 导航左右Item，文字按钮
#define labelWidthSpacing 20.0f
#define labelHeightSpacing 7.0f

// 左右Item
#define imageRadius 28.0f
#define widthSpacing (frameMove_X * 1.5)
#define buttonWidth 65.0f

@interface CTParentNavigationViewController ()

// Nav
@property (strong, nonatomic) UILabel *titleItemButton;

@property (strong, nonatomic) CVParentButton *leftItemButton;
@property (strong, nonatomic) UILabel *leftLabel;

@property (strong, nonatomic) CVParentButton *rightItemButton;
@property (strong, nonatomic) CVParentButton *rightSecondItemButton;
@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation CTParentNavigationViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 注册侦查者
    [self addObserverSelectors];
    
    // Backgound Color
    self.view.backgroundColor = MainViewsColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self viewEnter];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self viewEnter];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:NO];
    [self.customRequest cancel];
    
    // 键盘
    if (self.needCheckKeyboard)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)viewEnter
{
    [self.view bringSubviewToFront:self.navBar];
    
    // 键盘
    if (self.needCheckKeyboard)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark - 继承

// (继承)注册侦查者
- (void)addObserverSelectors
{
}

// (继承)Left Nav Button Press
- (void)navLeftButtonItemPressed
{
    if (_showControllerType == ShowControllerType_Present)
    {
        [MainAppDelegate.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [GCHApplication popControllerWithPage:@(1)];
    }
}

// (继承)Right Nav Button Press
- (void)navRightButtonItemPressed
{
}

// (继承)Right Scond Nav Button Press
- (void)navRightSecondButtonItemPressed
{
}

// (继承)Tab 切换
- (void)tabChangeController
{
}

#pragma mark - Views

// Nav Title Text
- (void)initTitleViewWithText:(NSString *)title
{
    // 横屏模式
    float checkFrameWidth = self.view.width;
    
    // StatusBar
    float statusHeight = NavigationStatusBarHeight;
    
    // Frame
    UIFont *titleFont = AppleFont_UltraLight(18);
    float titleWidth = [title sizeWithAttributes: @{NSFontAttributeName:titleFont}].width;
    CGSize titleLabelSize = CGSizeMake(titleWidth > checkFrameWidth - 120.0f ? checkFrameWidth - 120.0f : titleWidth, navigationHeight);
    CGRect titleFrame = CGRectMake((checkFrameWidth - titleLabelSize.width) / 2.0f, statusHeight, titleLabelSize.width, navigationHeight);
    
    if (self.titleItemButton)
    {
        self.titleItemButton.frame = titleFrame;
        [self.titleItemButton setText:title];
    }
    else
    {
        self.titleItemButton = [[UILabel alloc] init];
        self.titleItemButton.frame = titleFrame;
        self.titleItemButton.backgroundColor = [UIColor clearColor];
        self.titleItemButton.textColor = MainNavigationColor;
        self.titleItemButton.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleItemButton.font = titleFont;
        self.titleItemButton.text = title;
        self.titleItemButton.numberOfLines = 0;
        self.titleItemButton.textAlignment = NSTextAlignmentCenter;
        [self.navBar addSubview:self.titleItemButton];
    }
}

// Left Back Button
- (void)initLeftNavigationBar:(GoBackType)goBack
{
    self.leftItemButton = [[CVParentButton alloc] init];
    self.leftItemButton.frame = CGRectMake(0.0f, NavigationStatusBarHeight, buttonWidth, navigationHeight);
    [self.leftItemButton addTarget:self action:@selector(navLeftButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:self.leftItemButton];
    
    float spacing = 10.0f;
    float itemHeight = self.leftItemButton.height - spacing * 2;
    CGRect backFrame = CGRectMake(spacing * 1.2, (self.leftItemButton.height - itemHeight) / 2, itemHeight, itemHeight);
    if (goBack == GoBackType_Back)
    {
        CVNavBackView *backView = [[CVNavBackView alloc] init];
        backView.viewColor = BackViewColor_White;
        backView.frame = backFrame;
        [self.leftItemButton addSubview:backView];
    }
    else if (goBack == GoBackType_Cancel)
    {
        CVNavCancelView *backView = [[CVNavCancelView alloc] init];
        backView.viewColor = BackViewColor_White;
        backView.frame = backFrame;
        [self.leftItemButton addSubview:backView];
    }
    if (goBack == GoBackType_BackBlack)
    {
        CVNavBackView *backView = [[CVNavBackView alloc] init];
        backView.viewColor = BackViewColor_Black;
        backView.frame = backFrame;
        [self.leftItemButton addSubview:backView];
    }
}

// Left Nav Button
- (void)initLeftNavigationBarWithImageName:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithColor:MainNavigationColor];
    if (self.leftItemButton)
    {
        [self.leftItemButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
        self.leftItemButton = [[CVParentButton alloc] init];
        self.leftItemButton.frame = CGRectMake(0.0f, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.leftItemButton setImage:image forState:UIControlStateNormal];
        [self.leftItemButton setImageEdgeInsets:UIEdgeInsetsMake((self.leftItemButton.height - imageRadius) / 2, (self.leftItemButton.width - imageRadius) / 2 * 1.0, (self.leftItemButton.height - imageRadius) / 2, (self.leftItemButton.width - imageRadius) / 2 * 1.0)];
        [self.leftItemButton addTarget:self action:@selector(navLeftButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.leftItemButton];
    }
}

// Left Nav Button Text
- (void)initLeftNavigationBarWithTitle:(NSString *)title
{
    if (self.leftItemButton)
    {
        self.leftLabel.text = title;
    }
    else
    {
        self.leftItemButton = [[CVParentButton alloc] init];
        self.leftItemButton.frame = CGRectMake(0.0f, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.leftItemButton addTarget:self action:@selector(navLeftButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.leftItemButton];
        
        self.leftLabel = [[UILabel alloc] init];
        self.leftLabel.backgroundColor = [UIColor clearColor];
        self.leftLabel.frame = CGRectMake(labelWidthSpacing, 0.0f, self.leftItemButton.width - labelWidthSpacing, self.leftItemButton.height);
        self.leftLabel.text = title;
        self.leftLabel.textColor = MainNavigationColor;
        self.leftLabel.font = AppleFont_UltraLight(15);
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        [self.leftItemButton addSubview:self.leftLabel];
    }
}

- (void)destroyLeftNavigationBar
{
    [self.leftItemButton removeFromSuperview];
    self.leftItemButton = nil;
}

// Right Nav Button
- (void)initRightNavigationBarWithImageName:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithColor:MainNavigationColor];
    if (self.rightItemButton)
    {
        [self.rightItemButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
        self.rightItemButton = [[CVParentButton alloc] init];
        self.rightItemButton.frame = CGRectMake(self.view.width - buttonWidth, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.rightItemButton setImage:image forState:UIControlStateNormal];
        [self.rightItemButton setImageEdgeInsets:UIEdgeInsetsMake((self.rightItemButton.height - imageRadius) / 2, (self.rightItemButton.width - imageRadius) / 2 * 1.0, (self.rightItemButton.height - imageRadius) / 2, (self.rightItemButton.width - imageRadius) / 2 * 1.0)];
        [self.rightItemButton addTarget:self action:@selector(navRightButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.rightItemButton];
    }
}

// Right Nav Button Color
- (void)initRightNavigationBarWithImageName:(NSString *)imageName color:(UIColor *)color
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithColor:color];
    if (self.rightItemButton)
    {
        [self.rightItemButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
        self.rightItemButton = [[CVParentButton alloc] init];
        self.rightItemButton.frame = CGRectMake(self.view.width - buttonWidth, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.rightItemButton setImage:image forState:UIControlStateNormal];
        [self.rightItemButton setImageEdgeInsets:UIEdgeInsetsMake((self.rightItemButton.height - imageRadius) / 2, (self.rightItemButton.width - imageRadius) / 2 * 1.0, (self.rightItemButton.height - imageRadius) / 2, (self.rightItemButton.width - imageRadius) / 2 * 1.0)];
        [self.rightItemButton addTarget:self action:@selector(navRightButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.rightItemButton];
    }
}

// Right Second Nav Button
- (void)initRightSecondNavigationBarWithImageName:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithColor:MainNavigationColor];
    if (self.rightSecondItemButton)
    {
        [self.rightSecondItemButton setImage:image forState:UIControlStateNormal];
    }
    else
    {
        self.rightSecondItemButton = [[CVParentButton alloc] init];
        self.rightSecondItemButton.frame = CGRectMake(self.view.width - buttonWidth * 2, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.rightSecondItemButton setImage:image forState:UIControlStateNormal];
        [self.rightSecondItemButton setImageEdgeInsets:UIEdgeInsetsMake((self.rightSecondItemButton.height - imageRadius) / 2, self.rightSecondItemButton.width - imageRadius, (self.rightSecondItemButton.height - imageRadius) / 2, 0.0f)];
        [self.rightSecondItemButton addTarget:self action:@selector(navRightSecondButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.rightSecondItemButton];
    }
}

// Right Nav Button Text
- (void)initRightNavigationBarWithTitle:(NSString *)title
{
    if (self.rightItemButton)
    {
        self.rightLabel.text = title;
    }
    else
    {
        self.rightItemButton = [[CVParentButton alloc] init];
        self.rightItemButton.frame = CGRectMake(self.navBar.width - buttonWidth - labelWidthSpacing, NavigationStatusBarHeight, buttonWidth, navigationHeight);
        [self.rightItemButton addTarget:self action:@selector(navRightButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:self.rightItemButton];
        
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.frame = CGRectMake(0.0f, 0.0f, self.rightItemButton.width, self.rightItemButton.height);
        self.rightLabel.text = title;
        self.rightLabel.textColor = MainNavigationColor;
        self.rightLabel.font = AppleFont_UltraLight(15);
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self.rightItemButton addSubview:self.rightLabel];
    }
}

#pragma mark - Other

// 从父View中获取Cell View
- (UITableViewCell *)getParentCellView:(UIView *)view
{
    if (!view) return nil;
    UIView *parentView = view.superview;
    if ([parentView isKindOfClass:[UITableViewCell class]])
    {
        return (UITableViewCell *)parentView;
    }
    else
    {
        return [self getParentCellView:parentView];
    }
}

// Nav Bar
- (void)setMainNavigationBar:(NavigationBarType)barType goBack:(GoBackType)goBack;
{
    if (!self.navBar)
    {
        float navHeight = (barType == NavigationBarType_CurveLine) ? (navigationHeight + NavigationStatusBarHeight + navigationCurveHeight) : (navigationHeight + NavigationStatusBarHeight);
        self.navBar = [[CVNavBarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, navHeight)];
        self.navBar.barType = barType;
        [self.view addSubview:self.navBar];
    }
    
    // Left
    if (goBack != GoBackType_None)
    {
        [self initLeftNavigationBar:goBack];
    }
}

// 隐藏左Item
- (void)hideLeftNavigationItem
{
    if (self.leftItemButton) self.leftItemButton.hidden = YES;
}

// 禁用右Item
- (void)disableRightNavigationItem:(BOOL)disable
{
    self.rightItemButton.userInteractionEnabled = !disable;
    self.rightLabel.textColor = disable ? LightGreyColor : MainNavigationColor;
}

// 弹出相册权限
- (void)showAlbumAuthorizedAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相册" message:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
    alertController.view.tintColor = MainAlertTintColor;
    // 设置
    [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    // 取消
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 改变Frame
    [self showKeyboard:keyboardRect.size.height];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    // 改变Frame
    [self hideKeyboard];
}

// (继承)
- (void)showKeyboard:(float)height
{
}

// (继承)
- (void)hideKeyboard
{
}

#pragma mark - Override

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
