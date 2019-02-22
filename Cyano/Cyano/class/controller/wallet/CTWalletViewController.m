//
//  CTWalletViewController.m
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTWalletViewController.h"
#import "CVWalletBalancesView.h"
#import "CVWalletAccountView.h"
#import "CTScanViewController.h"

@interface CTWalletViewController ()

@property (strong, nonatomic) CVWalletBalancesView *balancesView;
@property (strong, nonatomic) CVWalletAccountView *accountView;

@end

@implementation CTWalletViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMainNavigationBar:NavigationBarType_None goBack:GoBackType_None];
    [self initRightNavigationBarWithImageName:@"icon_scan_qr"];
    
    [self layoutMainView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    self.balancesView.hidden = YES;
//    self.accountView.hidden = YES;
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.balancesView.hidden = YES;
//    self.accountView.hidden = YES;
//    // Balances
//    if ([GCHRAM instance].defaultAccount.password)
//    {
//        self.balancesView.hidden = NO;
//        [self.balancesView layoutMainView];
//    }
//    // Account
//    else
//    {
//        self.accountView.hidden = NO;
//        [self.accountView layoutMainView];
//    }
//}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.balancesView.hidden = YES;
    self.accountView.hidden = YES;
    
    // Balances
    if ([GCHRAM instance].defaultAccount.password)
    {
        self.balancesView.hidden = NO;
        [self.balancesView layoutMainView];
    }
    // Account
    else
    {
        self.accountView.hidden = NO;
        [self.accountView layoutMainView];
    }
}

// (继承)Right Nav Button Press
- (void)navRightButtonItemPressed
{
    CTScanViewController *controller = [[CTScanViewController alloc] init];
    [MainAppDelegate.navigationController pushViewController:controller animated:YES];
}

- (void)layoutMainView
{
    // Balances
    self.balancesView = [[CVWalletBalancesView alloc] init];
    self.balancesView.frame = self.view.bounds;
    self.balancesView.hidden = YES;
    [self.view addSubview:self.balancesView];
    
    // Account
    self.accountView = [[CVWalletAccountView alloc] init];
    self.accountView.frame = self.view.bounds;
    self.accountView.hidden = YES;
    [self.view addSubview:self.accountView];
}

@end
