//
//  CTAccountSuccessViewController.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTAccountSuccessViewController.h"
#import "CCTitleTextViewCell.h"

#define headerHeight getUIValue(150.0f)
#define MyTextViewCellHeight getUIValue(120.0f)

@interface CTAccountSuccessViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UITableView *customTableView;
@property (strong, nonatomic) NSMutableArray *customArray;

@end

@implementation CTAccountSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    titleLabel.text = @"New account";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = WhiteColor;
    
    // Detail
    float detailHeightSpacing = getUIValue(5.0f);
    float detailHeight = getUIValue(60.0f);
    UILabel *detailLabel = [self createLabel:self.headerView];
    detailLabel.frame = CGRectMake(frameMove_X, titleLabel.bottom + detailHeightSpacing, self.headerView.width - frameMove_X * 2, detailHeight);
    detailLabel.text = @"Here you have your mnemonics phrase and private key. You can use either to restore your account.";
    detailLabel.font = AppleFont_Regular(15);
    detailLabel.textColor = WhiteColor;
}

#pragma mark - Table

- (void)layoutTableView
{
    // 添加表
    self.customTableView = [self createTable:self.view frame:CGRectMake(0.0f, self.headerView.bottom, self.view.width, self.view.height - self.headerView.bottom) target:self];
    self.customTableView.rowHeight = MyTextViewCellHeight;
    self.customTableView.backgroundColor = PurityColor(242);
    
    // Footer
    [self layoutTableFooterView];
    
    // Data
    self.customArray = [NSMutableArray array];
    [self.customArray addObject:@"Mnemonics phrase"];
    [self.customArray addObject:@"Private key (WIF format)"];
    [self.customTableView reloadData];
}

- (void)layoutTableFooterView
{
    float footerHeight = getUIValue(80.0f);
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0.0f, 0.0f, self.view.width, footerHeight);
    self.customTableView.tableFooterView = footerView;
    
    // Items
    NSArray *itemsArr = @[@"CONTINUE"];
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
        button.layer.shadowColor = PurityColor(240).CGColor;
    }
}

#pragma mark - 按钮点击

- (void)buttonItemPress:(UIButton *)button
{
    if (button.tag == 1)
    {
        [MainAppDelegate.navigationController popToRootViewControllerAnimated:YES];
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
    
    static NSString *CustomCellIdentifier = @"TextViewCellIdentifier";
    CCTitleTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CCTitleTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier frame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, MyTextViewCellHeight)];
        cell.textView.editable = NO;
    }
    
    cell.titleLabel.text = title;
    
    // Mnemonics phrase
    if ([title isEqualToString:@"Mnemonics phrase"])
    {
        cell.textView.text = [GCHRAM instance].defaultAccount.mnemonicText;
    }
    // Private key (WIF format)
    else if ([title isEqualToString:@"Private key (WIF format)"])
    {
        cell.textView.text = [GCHRAM instance].defaultAccount.wif;
    }
    
    return cell;
}

@end
