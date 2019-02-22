//
//  ReceiveViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/10.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "ReceiveViewController.h"
#import <Masonry.h>
#import "QRCodeGenerator.h"
@interface ReceiveViewController ()

@end

@implementation ReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    [self initTitleViewWithText:@"Receive funds"];
    
    [self layoutMainView];
}

-(void)layoutMainView{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    
    UIView * topV = [self createView:self.view];
    topV.backgroundColor = MainViewsColor;
    
    UILabel * alertLB = [self createLabel:topV];
    alertLB.textColor = WhiteColor;
    alertLB.text = @"Use your public address to send funds to your wallet.";
    alertLB.font = AppleFont_UltraLight(14);
    alertLB.textAlignment = NSTextAlignmentCenter;
    alertLB.numberOfLines = 0;
    
    UILabel * pubkeyLB = [[UILabel alloc]init];
    pubkeyLB.text = @"Public address";
    pubkeyLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:pubkeyLB];
    
    UITextField * addressLB = [[UITextField alloc]init];
    addressLB.enabled = NO;
    addressLB.clearButtonMode = UITextFieldViewModeNever;
    addressLB.text = account.address.address;
    addressLB.font = [UIFont systemFontOfSize:14];
    addressLB.layer.borderWidth = 1;
    addressLB.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:addressLB];
    
    UIImageView * qrImage =[[ UIImageView alloc]init];
    qrImage.image = [QRCodeGenerator qrImageForString:account.address.address imageSize:200];
    [self.view addSubview:qrImage];
    
    UIButton * copyBtn = [[UIButton alloc]init];
    [copyBtn addTarget:self action:@selector(copyAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copyBtn];
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    [alertLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(topV).offset(20);
        make.bottom.equalTo(topV.mas_bottom).offset(-40);
    }];
    
    [pubkeyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(topV.mas_bottom).offset(20);
    }];
    
    [addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(pubkeyLB.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(pubkeyLB.mas_bottom).offset(20);
        make.height.mas_offset(60);
    }];
    
    [qrImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(addressLB.mas_bottom).offset(30);
        make.width.height.mas_offset(200);
    }];
    

    
}
-(void)copyAddress{
    [CVShowLabelView showTitle:@"Copied wallet address" detail:nil];
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = account.address.address;
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
