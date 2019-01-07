//
//  CTSettingViewController.m
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTSettingViewController.h"
#import "CCRoundTitleCell.h"
#import "CTExportWalletViewController.h"

@interface CTSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *customTableView;
@property (strong, nonatomic) NSMutableArray *customArray;

@end

@implementation CTSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Backgound Color
    self.view.backgroundColor = PurityColor(242);
    
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initTitleViewWithText:@"Setting"];
    
    [self layoutMainView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initData];
}

- (void)layoutMainView
{
    // 添加表
    self.customTableView = [self createTable:self.view frame:CGRectMake(0.0f, self.navBar.bottom + frameMove_X, self.view.width, self.view.height - tabBarHeight - self.navBar.bottom - frameMove_X) target:self];
}

- (void)initData
{
    // Data
    self.customArray = [NSMutableArray array];
    
    // Balances
    if ([GCHRAM instance].defaultAccount.password)
    {
        [self.customArray addObject:@"CLEAR WALLET"];
        [self.customArray addObject:@"WALLET INFO"];
    }
    // Account
    else
    {
        [self.customArray addObject:@"NEW WALLET"];
    }
    
    [self.customTableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.customArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.customArray[indexPath.row];
    
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    CCRoundTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CCRoundTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier frame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, customCellHeight)];
    }
    
    cell.titleLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.customArray[indexPath.row];
    if ([title isEqualToString:@"CLEAR WALLET"])
    {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self clearWallet];
        });
    }
    else if ([title isEqualToString:@"WALLET INFO"])
    {
        [GCHApplication inputPassword:^{
            CTExportWalletViewController *controller = [[CTExportWalletViewController alloc] init];
            [MainAppDelegate.navigationController pushViewController:controller animated:YES];
        }];
    }
    else if ([title isEqualToString:@"NEW WALLET"])
    {
        MainAppDelegate.appViewController.whichTabSelect = 0;
    }
}

- (void)clearWallet
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Clearing will erase your account and identity from this device." message:nil preferredStyle:UIAlertControllerStyleAlert];
    alertController.view.tintColor = MainAlertTintColor;
    // 确定
    [alertController addAction:[UIAlertAction actionWithTitle:@"CLEAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 删除账号
        [GCHApplication clearDefaultAccount];
        // New account
        MainAppDelegate.appViewController.whichTabSelect = 0;
    }]];
    // 取消
    [alertController addAction:[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:nil]];
    [MainAppDelegate.navigationController presentViewController:alertController animated:YES completion:nil];
}

@end
