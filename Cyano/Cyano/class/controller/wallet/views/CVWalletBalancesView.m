//
//  CVWalletBalancesView.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVWalletBalancesView.h"
#import "ReceiveViewController.h"
#import "SendViewController.h"
#import "CTWebViewController.h"
#import "MDOep4Model.h"
#import "TokensCell.h"
#import "OEP4ViewController.h"
#import "Helper.h"
#define headerHeight getUIValue(200.0f)
#define toolHeight getUIValue(60.0f)

@interface CVWalletBalancesView ()
<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *ontValueLabel;
@property (strong, nonatomic) UILabel *ongValueLabel;
@property (strong, nonatomic) UILabel *claimValueLabel;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *toolView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) MDOep4Model *oep4Model;

@property (copy,   nonatomic) NSString *claimOngString;
@end

@implementation CVWalletBalancesView

- (void)layoutMainView
{
    // Header
    [self layoutHeaderView];
    
    // Tool
    [self layoutToolView];
    
    // Content
    [self layoutContentView];
    
    // OEP-4
    [self layoutOep4];
    
    // Data
    [self updateData];
    
    // oep4 data
    [self getOep4data];
    
    // UnboundOng
    [self getUnboundOng];
}

#pragma mark - Data

- (void)updateData
{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    [[ONTRpcApi shareInstance] getBalanceWithAddress:account.address.address callback:^(NSArray *balances, NSError *error) {
        if (error) return;
        for (ONTBalance *balance in balances)
        {
            NSLog(@"%@ == %@", balance.name, balance.balances);
            if ([[balance.name uppercaseString] isEqualToString:@"ONT"])
            {
                self.ontValueLabel.text = balance.balances;
            }
            else if ([[balance.name uppercaseString] isEqualToString:@"ONG"])
            {
                self.ongValueLabel.text = balance.balances;
            }
            else if ([[balance.name uppercaseString] isEqualToString:@"CLAIM"])
            {
//                self.claimValueLabel.text = balance.balances;
            }
        }
    }];
}

#pragma mark - oep4 data

- (void)getOep4data{
    [[HTTPClient sharedClient]
     sendAsynchronousURL:OEP4INFO
     httpMethod:REQUEST_GET
     parameters:nil
     bodyBlock:nil
     completionHandler:^(id data, BOOL success)
     {
         if (success)
         {
             self.oep4Model =  [[MDOep4Model alloc]initFromDictionary:data[@"Result"]];
             [self layoutOep4];
         }
     }];
}
#pragma mark - Header

#pragma mark - getUnboundOng
-(void)getUnboundOng{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    [[ONTRpcApi shareInstance] getUnboundOng:account.address.address callback:^(NSString *amount, NSError *error) {
        if (error) {
            return ;
        }
        NSLog(@"amount=%@",amount);
        self.claimOngString = [ONTUtils decimalNumber:amount byDividingBy:@"1000000000.0"];
        self.claimValueLabel.text = [NSString stringWithFormat:@"%@ (Claim)",[ONTUtils decimalNumber:amount byDividingBy:@"1000000000.0"]];
    }];
}
- (void)layoutHeaderView
{
    if (!self.headerView)
    {
        self.headerView = [self createView:self];
        self.headerView.frame = CGRectMake(0.0f, 0.0f, self.width, headerHeight);
    }
    
    for (UIView *view in self.headerView.subviews)
    {
        [view removeFromSuperview];
    }
    
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
    titleLabel.text = @"Balances";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = WhiteColor;
    
    // Values
    float labelsHeightSpacing = getUIValue(10);
    float labelsTop = iconImageView.bottom + labelsHeightSpacing;
    float labelWidth = self.headerView.width / 2;
    float labelHeight = (self.headerView.height - labelsTop - labelsHeightSpacing) / 3;
    float labelLargeHeight = labelHeight * 2;
    for (int f = 0; f < 5; f++)
    {
        UILabel *label = [self createLabel:self.headerView];
        label.font = AppleFont_UltraLight(22);
        label.textColor = WhiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        
        // ONT
        if (f == 0)
        {
            label.text = @"ONT";
            label.frame = CGRectMake(0.0f, labelsTop, labelWidth, labelHeight);
        }
        // ONG
        else if (f == 1)
        {
            label.text = @"ONG";
            label.frame = CGRectMake(labelWidth, labelsTop, labelWidth, labelHeight);
        }
        // ONT Value
        else if (f == 2)
        {
            self.ontValueLabel = label;
            label.font = AppleFont_Thin(40);
            label.text = @"0";
            label.frame = CGRectMake(0.0f, labelsTop + labelHeight, labelWidth, labelLargeHeight);
        }
        // ONG Value
        else if (f == 3)
        {
            self.ongValueLabel = label;
            label.text = @"0";
            label.frame = CGRectMake(labelWidth, labelsTop + labelHeight, labelWidth, labelHeight);
        }
        // Claim
        else if (f == 4)
        {
            self.claimValueLabel = label;
            self.claimValueLabel.font = [UIFont systemFontOfSize:14];
            self.claimValueLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer
            *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(claimOng)];
            [self.claimValueLabel addGestureRecognizer:tapGesture];
            label.text = @"0 (Claim)";
            label.frame = CGRectMake(labelWidth, labelsTop + labelHeight * 2, labelWidth, labelHeight);
        }
    }
}

#pragma mark - Content

- (void)layoutContentView
{
    if (!self.contentView)
    {
        self.contentView = [self createView:self];
        self.contentView.frame = CGRectMake(0.0f, self.headerView.bottom, self.width, self.toolView.top - self.headerView.bottom);
        self.contentView.backgroundColor = PurityColor(242);
    }
    
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Title
    float titleWidthSpacing = getUIValue(10.0f);
    float titleHeightSpacing = getUIValue(20.0f);
    float titleHeight = getUIValue(40.0f);
    UILabel *titleLabel = [self createLabel:self.contentView];
    titleLabel.frame = CGRectMake(titleWidthSpacing, titleHeightSpacing, self.contentView.width - titleWidthSpacing * 2, titleHeight);
    titleLabel.text = @"OEP-4 tokens";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = RGBCOLOR(79, 77, 77);
}

#pragma mark - oep-4

- (void)layoutOep4{
    if (!self.tableView) {
        self.tableView = [self createTable:self frame:CGRectZero target:self];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.contentView.mas_top).offset(getUIValue(70.0f));
            make.bottom.equalTo(self.toolView.mas_top).offset(-10);
        }];
    }
    for (UIView *view in self.tableView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self.tableView reloadData];
}
#pragma mark - Tool

- (void)layoutToolView
{
    if (!self.toolView)
    {
        self.toolView = [self createView:self];
        self.toolView.frame = CGRectMake(0.0f, self.height - tabBarHeight - toolHeight, self.width, toolHeight);
        self.toolView.backgroundColor = PurityColor(242);
    }
    
    for (UIView *view in self.toolView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Items
    NSArray *itemsArr = @[@"SEND", @"RECEIVE",@"RECORD"];
    float itemWidth = getUIValue(100.0f);
    float itemHeight = getUIValue(40.0f);
    float itemWidthSpacing = getUIValue(4.0f);
    float totalWidth = itemsArr.count * itemWidth + (itemsArr.count - 1) * itemWidthSpacing;
    for (int f = 0; f < itemsArr.count; f++)
    {
        UIButton *button = [self createButton:self.toolView];
        button.tag = f + 1;
        [button addTarget:self action:@selector(buttonItemPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((self.toolView.width - totalWidth) / 2 + (itemWidth + itemWidthSpacing) * f, 0.0f, itemWidth, itemHeight);
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
    // SEND
    if (button.tag == 1)
    {
        SendViewController * controller = [[SendViewController alloc]init];
        controller.isONT = YES;
        controller.ontNum = self.ontValueLabel.text;
        controller.ongNum = self.ongValueLabel.text;
        [MainAppDelegate.navigationController pushViewController:controller animated:YES];
    }
    // RECEIVE
    else if (button.tag == 2)
    {
        ReceiveViewController * controller = [[ReceiveViewController alloc]init];
        [MainAppDelegate.navigationController pushViewController:controller animated:YES];
    }
    // RECORD
    else if (button.tag == 3){
        ONTAccount *account = [GCHApplication requestDefaultAccount];
        CTWebViewController * controller = [[CTWebViewController alloc]init];
        controller.urlString = [NSString stringWithFormat:RECORDURI,account.address.address];
        [MainAppDelegate.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - claimOng
-(void)claimOng{
    NSString * fee = [Helper getRealFee:@"500" GasLimit:@"20000"];
    BOOL isEnough = [Helper isEnoughOng:self.ongValueLabel.text fee:fee];
    if (isEnough) {
        [GCHApplication inputPassword:^{
            [self claimOngTrade];
        }];
        
    }else{
        [CVShowLabelView showTitle:@"Not enough ONG to make the transaction." detail:nil];
    }
}
-(void)claimOngTrade{
    ONTAccount *account = [GCHApplication requestDefaultAccount];;
    NSString *txHex = [account makeClaimOngTxWithAddress:account.address.address amount:self.claimOngString gasPrice:500 gasLimit:20000];
    
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:NO callback:^(NSString *txHash, NSError *error) {
        if (error) {
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            [self getUnboundOng];
        }
    }];
}
#pragma mark OEP4
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.oep4Model.ContractList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    TokensCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TokensCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    MDOep4InfoModel * model = self.oep4Model.ContractList[indexPath.row];
    [cell reloadCell:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MDOep4InfoModel * model = self.oep4Model.ContractList[indexPath.row];
    OEP4ViewController * controller = [[OEP4ViewController alloc]init];
    controller.model = model;
    controller.isOEP4 = YES;
    controller.ongNum = self.ongValueLabel.text;
    controller.ontNum = self.ontValueLabel.text;
    [MainAppDelegate.navigationController pushViewController:controller animated:YES];
}
@end
