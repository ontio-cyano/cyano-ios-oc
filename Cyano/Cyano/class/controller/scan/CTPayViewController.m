//
//  CTPayViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTPayViewController.h"
#import "CTWebViewController.h"
#import "ONTTransaction.h"
#import "Helper.h"
#import "CTPaySureViewController.h"
@interface CTPayViewController ()
@property(nonatomic,copy)NSString *callback;
@property(nonatomic,copy)NSString *payerAddress;
@property(nonatomic,copy)NSString *toAddress;
@property(nonatomic,copy)NSString *payMoney ;
@property(nonatomic,assign)BOOL   isONT;
@property(nonatomic,strong)NSDictionary *payDetailDic;
@end

@implementation CTPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    
    [self layoutMainView];
}
-(void)what{
    CTWebViewController * controller = [[CTWebViewController alloc]init];
    controller.urlString = @"https://info.onto.app/#/detail/86";
    [MainAppDelegate.navigationController pushViewController:controller animated:YES];
}
-(void)getInvokeMessage{
    NSDictionary * pDic = self.payInfo[@"params"];
    if (pDic[@"callback"]) {
        self.callback = pDic[@"callback"];
    }
    NSString * urlString = pDic[@"qrcodeUrl"];
    [[HTTPClient sharedClient] sendAsynchronousURL:urlString httpMethod:REQUEST_GET parameters:nil bodyBlock:nil completionHandler:^(id data, BOOL success){
        if (success){
            NSLog(@"data=%@",data);
            if ([data isKindOfClass:[NSDictionary class]] && data[@"params"]) {
                self.payDetailDic = data;
                NSDictionary * paramsD = data[@"params"];
                NSDictionary * invokeConfig = paramsD[@"invokeConfig"];
                if (!invokeConfig[@"payer"]) {
                    [CVShowLabelView showTitle:@"There is no corresponding payment wallet, please add the wallet first." detail:nil];
                    return;
                }
                if (![self.account.address.address isEqualToString:invokeConfig[@"payer"]]) {
                    [CVShowLabelView showTitle:@"There is no corresponding payment wallet, please add the wallet first." detail:nil];
                    return;
                }
                [GCHApplication inputPassword:^{
                    [self makeTransactionWithDic:data];
                }];
            }
        }else{
            [CVShowLabelView showTitle:@"error" detail:nil];
        }
    }];

}
-(void)makeTransactionWithDic:(NSDictionary*)dic{
    ONTTransaction * tx = [ONTTransaction makeDappInvokeTransactionWithDic:dic];
    [tx addSign:self.account];
    NSString *txHex = tx.toRawByte.hexString;
    [self checkTrade:txHex];
}

-(void)checkTrade:(NSString*)txHex{
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:YES callback:^(NSString *txHash, NSError *error) {
        if (error) {
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            NSString * jsonString = [self convertToString:txHash];
            NSDictionary * resultDic = [Helper dictionaryWithJsonString:jsonString];
            NSArray * Notify = resultDic[@"Notify"];
            for (NSDictionary * payDic in Notify) {
                NSString * ContractAddress = payDic[@"ContractAddress"];
                if ([ContractAddress isEqualToString:@"0100000000000000000000000000000000000000"]) {
                    self.isONT = YES;
                    NSArray * arr = payDic[@"States"];
                    if ([arr[1] isEqualToString:self.account.address.address] && [arr[0] isEqualToString:@"transfer"]) {
                        self.payerAddress = arr[1];
                        self.toAddress  = arr[2];
                        self.payMoney = arr[3];
                    }
                }else if ([ContractAddress isEqualToString:@"0200000000000000000000000000000000000000"]) {
                    self.isONT = NO;
                    NSArray * arr = payDic[@"States"];
                    if ([arr[1] isEqualToString:self.account.address.address] && [arr[0] isEqualToString:@"transfer"]) {
                        self.payerAddress = arr[1];
                        self.toAddress  = arr[2];
                        self.payMoney = [Helper getPayMoney:[NSString stringWithFormat:@"%@",arr[3]]];
                    }
                }
            }
            if ([Helper isBlankString:self.payMoney] || [Helper isBlankString:self.toAddress]) {
                // TODO
                [self sendTrade:txHex];
                return ;
            }
            
            CTPaySureViewController * controller = [[CTPaySureViewController alloc]init];
            controller.toAddress = self.toAddress    ;
            controller.hashString = txHex;
            controller.payerAddress = self.payerAddress;
            controller.callback = self.callback  ;
            controller.isONT = self.isONT;
            controller.payMoney = self.payMoney;
            controller.payDetailDic = self.payDetailDic;
            controller.account = self.account;
            [MainAppDelegate.navigationController pushViewController:controller animated:YES];
        }
    }];
}
-(void)sendTrade:(NSString*)hash{
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:hash preExec:NO callback:^(NSString *txHash, NSError *error) {
        if (error) {
            if (self.callback) {
                [self sendHash:NO hash:hash];
            }
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            if (self.callback) {
                [self sendHash:YES hash:hash];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            [CVShowLabelView showTitle:@"The transaction has been issued." detail:nil];
        }
    }];
}
-(void)sendHash:(BOOL)isSuccess hash:(NSString*)hash{
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
                   @"result":hash,
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
-(NSString*)convertToString:(NSString*)string{
   
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
-(void)layoutMainView{
    UIImageView * imageV =[[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"RegisterONTOLogo"];
    [self.view addSubview:imageV];
    
    UILabel * thirdName = [[UILabel alloc]init];
    thirdName.text = @"Ontology dApp Transaction Request";
    thirdName.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    thirdName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thirdName];
    
    UILabel * requiredLB = [[UILabel alloc]init];
    requiredLB.text = @"Requirements:";
    requiredLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    requiredLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:requiredLB];
    
    UIImageView * dotImage1 =[[UIImageView alloc]init];
    dotImage1.layer.cornerRadius = 3.5;
    dotImage1.backgroundColor = [UIColor colorWithHexString:@"#6E6F70"];
    [self.view addSubview:dotImage1];
    
    UIImageView * dotImage2 =[[UIImageView alloc]init];
    dotImage2.layer.cornerRadius = 3.5;
    dotImage2.backgroundColor = [UIColor colorWithHexString:@"#6E6F70"];
    [self.view addSubview:dotImage2];
    
    UILabel * requiredLB1 =[[UILabel alloc]init];
    requiredLB1.numberOfLines = 0;
    requiredLB1.text = @"Prepare executive and obtain transaction details";
    requiredLB1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    requiredLB1.textAlignment = NSTextAlignmentLeft;
    requiredLB1.numberOfLines = 0;
    [self.view addSubview:requiredLB1];
    
    UILabel * requiredLB2 =[[UILabel alloc]init];
    requiredLB2.numberOfLines = 0;
    requiredLB2.text = @"Confirm transaction and send transaction";
    requiredLB2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    requiredLB2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:requiredLB2];
    
    UILabel * FromLB =[[UILabel alloc]init];
    FromLB.text = @"Payment wallet";
    FromLB.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    FromLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:FromLB];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.backgroundColor = RGBCOLOR(224, 225, 226);
    [btn setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getInvokeMessage) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [self.view addSubview:btn];
    
    UILabel * nameLB =[[UILabel alloc]init];
    nameLB.text = self.account.name;
    nameLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    nameLB.textColor = [UIColor colorWithHexString:@"#6E6F70"];
    nameLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nameLB];
    
    UILabel * addressLB =[[UILabel alloc]init];
    addressLB.text = self.account.address.address;
    addressLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    addressLB.textColor = [UIColor colorWithHexString:@"#000000"];
    addressLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:addressLB];
    
    UIView * line =[[ UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.view addSubview:line];
    
    
    UIButton * whatBtn = [[UIButton alloc]init];
    [whatBtn setImage:[UIImage imageNamed:@"cotlink"] forState:UIControlStateNormal];
    [whatBtn setTitle:@" What is 'Prepare executive'?" forState:UIControlStateNormal];
    [whatBtn setTitleColor:[UIColor colorWithHexString:@"#216ed5"] forState:UIControlStateNormal];
    [whatBtn addTarget:self action:@selector(what) forControlEvents:UIControlEventTouchUpInside];
    whatBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    
    [self.view addSubview:whatBtn];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom).offset(15);
        make.width.height.mas_offset(60);
    }];
    
    [thirdName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
    }];
    
    [requiredLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(thirdName.mas_bottom).offset(30);
    }];
    
    [dotImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_offset(7);
        make.top.equalTo(requiredLB.mas_bottom).offset(19);
    }];
    
    
    
    [requiredLB1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(20);
        make.top.equalTo(requiredLB.mas_bottom).offset(15);
    }];
    
    [dotImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_offset(7);
        make.top.equalTo(requiredLB1.mas_bottom).offset(10);
    }];
    [requiredLB2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(20);
        make.top.equalTo(requiredLB1.mas_bottom).offset(5);
    }];
    
    [FromLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(requiredLB2.mas_bottom).offset(18);
    }];
    
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(FromLB.mas_bottom).offset(12);
    }];
    
    [addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FromLB);
        make.top.equalTo(nameLB.mas_bottom).offset(6);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_offset(1);
        make.top.equalTo(addressLB.mas_bottom).offset(18);
    }];
    
    [whatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_offset(25);
        make.top.equalTo(line.mas_bottom).offset(15);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(58);
        make.right.equalTo(self.view).offset(-58);
        make.height.mas_offset(60);
        make.bottom.equalTo(self.view).offset(-100 );
    }];

}


@end
