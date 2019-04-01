//
//  CTLoginViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "CTLoginViewController.h"
#import "ONTECKey.h"
@interface CTLoginViewController ()
@property(nonatomic,copy)NSString *passwordString;
@end

@implementation CTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    
    [self layoutMainView];
}
-(void)layoutMainView{
    UIImageView * imageV =[[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"RegisterONTOLogo"];
    [self.view addSubview:imageV];
    
    UILabel * thirdName = [[UILabel alloc]init];
    thirdName.text = @"Ontology dApp Log-In Request";
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
    requiredLB1.text = @"Verify your identity";
    requiredLB1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    requiredLB1.textAlignment = NSTextAlignmentLeft;
    requiredLB1.numberOfLines = 0;
    [self.view addSubview:requiredLB1];
    
    UILabel * requiredLB2 =[[UILabel alloc]init];
    requiredLB2.numberOfLines = 0;
    requiredLB2.text = @"choose your log-in wallet";
    requiredLB2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    requiredLB2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:requiredLB2];
    
    UILabel * FromLB =[[UILabel alloc]init];
    FromLB.text = @"log-in wallet";
    FromLB.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    FromLB.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:FromLB];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.backgroundColor = RGBCOLOR(224, 225, 226);
    [btn setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
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
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(58);
        make.right.equalTo(self.view).offset(-58);
        make.height.mas_offset(60);
        make.bottom.equalTo(self.view).offset(-100 );
    }];
}
-(void)login{
    [GCHApplication inputPassword:^{
        [self signMessage];
    }];
}
-(void)signMessage{
    NSDictionary * params = self.loginInfo[@"params"];
    NSString * message = params[@"message"];
    NSData * messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSString * signMessage = [[self.account signMessage:messageData] lowercaseString];
    
    NSString * idStr = @"";
    if (self.loginInfo[@"id"]) {
        idStr = self.loginInfo[@"id"];
    }
    NSString * versionStr = @"";
    if (self.loginInfo[@"version"]) {
        versionStr = self.loginInfo[@"version"];
    }
    ONTECKey *ecKey = [[ONTECKey alloc] initWithPriKey:self.account.privateKey.data];
    NSDictionary * sendParams = @{@"user":self.account.address.address,
                              @"message":message,
                              @"publicKey":[ecKey.publicKeyAsHex lowercaseString],
                              @"signature":signMessage,
                              @"type":@"account"
                              };
    NSDictionary * submitDic = @{@"action":@"login",@"version":versionStr,@"params":sendParams,@"id":idStr};
    [[HTTPClient sharedClient] sendAsynchronousURL:params[@"callback"] httpMethod:REQUEST_POST parameters:submitDic bodyBlock:nil completionHandler:^(id data, BOOL success){
        if (success){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [CVShowLabelView showTitle:@"error" detail:nil];
        }
     }];
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
