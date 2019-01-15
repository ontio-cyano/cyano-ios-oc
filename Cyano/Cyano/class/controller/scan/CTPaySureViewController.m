//
//  CTPaySureViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/15.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTPaySureViewController.h"

@interface CTPaySureViewController ()

@end

@implementation CTPaySureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    
    [self layoutMainView];
}
-(void)sendTrade{
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:self.hashString preExec:NO callback:^(NSString *txHash, NSError *error) {
        if (error) {
            if (self.callback) {
                [self sendHash:NO];
            }
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            if (self.callback) {
                [self sendHash:YES];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
             [CVShowLabelView showTitle:@"The transaction has been issued." detail:nil];
        }
    }];
}
-(void)sendHash:(BOOL)isSuccess{
    NSDictionary * params;
    NSString * idStr = @"";
    if (self.payDetailDic[@"id"]) {
        idStr = self.payDetailDic[@"id"];
    }
    NSString * versionStr = @"";
    if (self.payDetailDic[@"version"]) {
        versionStr = self.payDetailDic[@"version"];
    }
    if (isSuccess) {
        params = @{@"action":@"invoke",
                   @"desc":@"SUCCESS",
                   @"error":@0,
                   @"result":_hashString,
                   @"version":versionStr,
                   @"id":idStr
                   };
    }else{
        params = @{@"action":@"invoke",
                   @"desc":@"SEND TX ERROR",
                   @"error":@8001,
                   @"result":@1,
                   @"version":versionStr,
                   @"id":idStr
                   };
    }
    [[HTTPClient sharedClient] sendAsynchronousURL:_callback httpMethod:REQUEST_POST parameters:params bodyBlock:nil completionHandler:^(id data, BOOL success){
        
    }];
}
-(void)layoutMainView{
    UILabel * feeLB = [[UILabel alloc]init];
    feeLB.numberOfLines = 0;
    feeLB.attributedText = [self getFeeString];
    feeLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:feeLB];
    
    UILabel * fromLB = [[UILabel alloc]init];
    fromLB.text = @"FROM";
    fromLB.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    fromLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLB];
    
    UILabel * nameLB = [[UILabel alloc]init];
    nameLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    nameLB.textColor = [UIColor colorWithHexString:@"#6E6F70"];
    nameLB.text = _account.name;
    nameLB.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:nameLB];
    
    UILabel * addressLB = [[UILabel alloc]init];
    addressLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    addressLB.textColor = [UIColor colorWithHexString:@"#000000"];
    addressLB.text = _account.address.address;
    addressLB.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:addressLB];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:line];
    
    UILabel * toLB = [[UILabel alloc]init];
    toLB.text = @"TO";
    toLB.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    toLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:toLB];
    
    UILabel * toAddressLB = [[UILabel alloc]init];
    toAddressLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    toAddressLB.textColor = [UIColor colorWithHexString:@"#000000"];
    toAddressLB.text = _toAddress;
    toAddressLB.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:toAddressLB];
    
    UIView * line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:line1];
    
    UIButton * confirmBtn = [[UIButton alloc]init];
    confirmBtn.backgroundColor = RGBCOLOR(224, 225, 226);
    [confirmBtn setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(sendTrade) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [self.view addSubview:confirmBtn];
    
    
    
    [feeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.navBar.mas_bottom).offset(30);
    }];
    
    [fromLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(feeLB.mas_bottom).offset(48);
    }];
    
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromLB);
        make.top.equalTo(fromLB.mas_bottom).offset(12);
    }];
    
    [addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromLB);
        make.top.equalTo(nameLB.mas_bottom).offset(6);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(addressLB.mas_bottom).offset(18);
        make.height.mas_offset(1);
    }];
    
    [toLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromLB);
        make.top.equalTo(line.mas_bottom).offset(28);
    }];
    
    [toAddressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fromLB);
        make.top.equalTo(toLB.mas_bottom).offset(12);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(toAddressLB.mas_bottom).offset(18);
        make.height.mas_offset(1);
    }];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(58);
        make.right.equalTo(self.view).offset(-58);
        make.height.mas_offset(60);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}
-(NSMutableAttributedString*)getFeeString{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]init];
    [string appendAttributedString:[self appendColorStrWithString:@"You will pay " font:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium] color:[UIColor colorWithHexString:@"#000000" ]]];
    [string appendAttributedString:[self appendColorStrWithString:[NSString stringWithFormat:@"%@",_payMoney] font:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium] color:[UIColor colorWithHexString:@"#196BD8" ]]];
    [string appendAttributedString:[self appendColorStrWithString:self.isONT? @" ONT":@" ONG" font:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium] color:[UIColor colorWithHexString:@"#000000" ]]];
    return string;
}
-(NSMutableAttributedString*)appendColorStrWithString:(NSString*)String font:(UIFont*)font color:(UIColor*)color{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:String attributes:@{NSKernAttributeName :@0}];
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, String.length)];
    [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, String.length)];
    return string;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
