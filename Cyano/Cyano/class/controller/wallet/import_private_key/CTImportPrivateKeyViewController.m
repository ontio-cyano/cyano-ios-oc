//
//  CTImportPrivateKeyViewController.m
//  Cyano
//
//  Created by Yuanhai on 27/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTImportPrivateKeyViewController.h"
#import "CCTitleTextFieldCell.h"
#import "CCTitleTextViewCell.h"
#import "CTAccountSuccessViewController.h"

#define headerHeight getUIValue(150.0f)
#define MyCellHeight getUIValue(80.0f)
#define MyTextViewCellHeight getUIValue(120.0f)

@interface CTImportPrivateKeyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UITableView *customTableView;
@property (strong, nonatomic) NSArray *customArray;

@end

@implementation CTImportPrivateKeyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.needCheckKeyboard = YES;
    
    [self setMainNavigationBar:NavigationBarType_None goBack:GoBackType_None];
    
    [self layoutMainView];
}

- (void)layoutMainView
{
    // Header
    [self layoutHeaderView];
    
    // Table
    [self layoutTableView];
}

#pragma mark - Header

- (void)layoutHeaderView
{
    self.headerView = [self createView:self.view];
    self.headerView.frame = CGRectMake(0.0f, 0.0f, self.view.width, headerHeight);
    
    // Icon
    float iconSpacing = getUIValue(10.0f);
    float iconWidth = getUIValue(40.0f);
    float iconHeight = iconWidth * 176 / 196;
    UIImageView *iconImageView = [self createImageView:self.headerView];
    iconImageView.frame = CGRectMake(iconSpacing, NavigationStatusBarHeight + iconSpacing, iconWidth, iconHeight);
    iconImageView.image = [UIImage imageNamed:@"logo"];
    
    // Title
    UILabel *titleLabel = [self createLabel:self.headerView];
    titleLabel.frame = CGRectMake(iconImageView.right + iconSpacing, iconImageView.top, self.headerView.width - iconImageView.right - iconSpacing - frameMove_X, iconImageView.height);
    titleLabel.text = @"Import private key";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = WhiteColor;
    
    // Detail
    float detailHeightSpacing = getUIValue(5.0f);
    float detailHeight = getUIValue(60.0f);
    UILabel *detailLabel = [self createLabel:self.headerView];
    detailLabel.frame = CGRectMake(frameMove_X, titleLabel.bottom + detailHeightSpacing, self.headerView.width - frameMove_X * 2, detailHeight);
    detailLabel.text = @"Enter your private key and passphrase for account encryption.";
    detailLabel.font = AppleFont_Regular(15);
    detailLabel.textColor = WhiteColor;
}

#pragma mark - Table

- (void)layoutTableView
{
    // 添加表
    self.customTableView = [self createTable:self.view frame:CGRectMake(0.0f, self.headerView.bottom, self.view.width, self.view.height - self.headerView.bottom) target:self];
    self.customTableView.rowHeight = MyCellHeight;
    self.customTableView.backgroundColor = PurityColor(242);
    
    // Footer
    [self layoutTableFooterView];
    
    // Data
    self.customArray = @[@"Private key (WIF format)", @"Password", @"Password again"];
    [self.customTableView reloadData];
}

- (void)layoutTableFooterView
{
    float footerHeight = getUIValue(80.0f);
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0.0f, 0.0f, self.view.width, footerHeight);
    self.customTableView.tableFooterView = footerView;
    
    // Items
    NSArray *itemsArr = @[@"RESTORE", @"CANCEL"];
    float itemWidth = getUIValue(100.0f);
    float itemHeight = getUIValue(40.0f);
    float itemWidthSpacing = getUIValue(4.0f);
    float totalWidth = itemsArr.count * itemWidth + (itemsArr.count - 1) * itemWidthSpacing;
    for (int f = 0; f < itemsArr.count; f++)
    {
        UIButton *button = [self createButton:footerView];
        button.tag = f + 1;
        [button addTarget:self action:@selector(buttonItemPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((footerView.width - totalWidth) / 2 + (itemWidth + itemWidthSpacing) * f, footerView.height - itemHeight - frameMove_X, itemWidth, itemHeight);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2.0f;
        [button setTitle:itemsArr[f] forState:UIControlStateNormal];
        [button setTitleColor:MainBlueColor forState:UIControlStateNormal];
        button.backgroundColor = RGBCOLOR(224, 225, 226);
        button.titleLabel.font = AppleFont_Regular(14);
        
        // Shadow
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:button.layer.cornerRadius];
        button.layer.masksToBounds = NO;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.5f;
        button.layer.shadowPath = shadowPath.CGPath;
        button.layer.shadowColor = self.customTableView.backgroundColor.CGColor;
    }
}

#pragma mark - 按钮点击

- (void)buttonItemPress:(UIButton *)button
{
    // RESTORE
    if (button.tag == 1)
    {
        CCTitleTextViewCell *cell_0 = [self.customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CCTitleTextFieldCell *cell_1 = [self.customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        CCTitleTextFieldCell *cell_2 = [self.customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        NSString *wif = cell_0.textView.text;
        NSString *pwd = cell_1.textField.text;
        NSString *pwdConfirm = cell_2.textField.text;
        
        if (wif.length != 64 && wif.length != 52)
        {
            [CVShowLabelView showTitle:@"The length of key should be 64 or 52." detail:nil];
            return;
        }
        
        if (wif.length <= 0 || pwd.length <= 0 || pwdConfirm.length <= 0)
        {
            [CVShowLabelView showTitle:@"Please fill in the blanks." detail:nil];
            return;
        }
        
        if (![pwd isEqualToString:pwdConfirm])
        {
            [CVShowLabelView showTitle:@"Passwords must be the same." detail:nil];
            return;
        }
        
        [[CVRefreshVIew instance] startRefresh];
        ONTAccount *account = [[ONTAccount alloc] initWithName:@"" password:pwd wif:wif];
        // NSLog(@"account:\n%@", account);
        [[CVRefreshVIew instance] stopRefresh];
        
        if (![account.wif isEqualToString:wif])
        {
            [CVShowLabelView showTitle:@"No this wallet." detail:nil];
            return;
        }
        
        // 保存账号
        [GCHApplication saveDefaultAccount:account password:pwd];
        
        [self navLeftButtonItemPressed];
    }
    // CANCEL
    else if (button.tag == 2)
    {
        [self navLeftButtonItemPressed];
    }
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
    
    if (indexPath.row == 0)
    {
        static NSString *CustomCellIdentifier = @"TextViewCellIdentifier";
        CCTitleTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[CCTitleTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier frame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, MyTextViewCellHeight)];
        }
        
        cell.titleLabel.text = title;
        
        return cell;
    }
    
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    CCTitleTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CCTitleTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier frame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, MyCellHeight)];
    }
    
    cell.titleLabel.text = title;
    cell.textField.secureTextEntry = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return MyTextViewCellHeight;
    return MyCellHeight;
}

#pragma mark - Responding to keyboard events

// (继承)
- (void)showKeyboard:(float)height
{
    self.customTableView.frame = CGRectMake(0.0f, self.headerView.bottom, self.view.width, self.view.height - self.headerView.bottom - height);
}

// (继承)
- (void)hideKeyboard
{
    self.customTableView.frame = CGRectMake(0.0f, self.headerView.bottom, self.view.width, self.view.height - self.headerView.bottom);
}

@end
