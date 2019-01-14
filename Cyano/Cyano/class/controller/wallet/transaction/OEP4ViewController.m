//
//  OEP4ViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/14.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "OEP4ViewController.h"
#import "Helper.h"
@interface OEP4ViewController ()
<UITextFieldDelegate>
{
    BOOL isHaveDian;
}
@property(nonatomic,strong)UITextField * AmountLBNumField;
@property(nonatomic,strong)UITextField * addressField;
@property(nonatomic,copy)  NSString    * confirmPwd;
@property(nonatomic,strong)UILabel     * amountLB;
@end

@implementation OEP4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    [self initTitleViewWithText:self.model.Symbol];
    
    [self layoutMainView];
    [self getTokenDetail];
}
-(void)getTokenDetail{
    [NeoVM shareInstance].oep4.contractAddress = self.model.ContractHash;
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    [[NeoVM shareInstance].oep4 queryBalanceOf:account.address.address queryCallback:^(NSString *balance, NSError *error) {
        NSLog(@"balance == %@, %@", balance, [error localizedDescription]);
        NSString * oep4Amount = [NSString stringWithFormat:@"%@",balance];
        NSString * oep4Ori =[Helper changeOEP4Str:oep4Amount Decimals:self.model.Decimals];
        self.amountLB.text = [Helper getPrecision9Str:oep4Ori Decimal:self.model.Decimals];
    }];
}
-(void)layoutMainView{
    
    UIView * topV = [[UIView alloc]init];
    topV.backgroundColor = MainViewsColor;
    [self.view addSubview:topV];
    
    _amountLB = [[UILabel alloc]init];
    _amountLB.textColor = WhiteColor;
    _amountLB.text = @"0000";
    _amountLB.textAlignment = NSTextAlignmentLeft;
    _amountLB.font = [UIFont systemFontOfSize:16];
    _amountLB.numberOfLines = 0;
    [topV addSubview:_amountLB];
    
    UILabel * RecipientLB = [[UILabel alloc]init];
    RecipientLB.text = @"Recipient";
    RecipientLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:RecipientLB];
    
    _addressField = [[UITextField alloc]init];
    _addressField.backgroundColor = WhiteColor;
    _addressField.font = [UIFont systemFontOfSize:14];
    _addressField.layer.borderWidth = 1;
    _addressField.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:_addressField];
    
    
    UILabel * AmountLB = [[UILabel alloc]init];
    AmountLB.text = @"Amount";
    AmountLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:AmountLB];
    
    _AmountLBNumField = [[UITextField alloc]init];
    _AmountLBNumField.keyboardType = UIKeyboardTypeDecimalPad;
    _AmountLBNumField.backgroundColor = WhiteColor;
    _AmountLBNumField.delegate = self;
    _AmountLBNumField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _AmountLBNumField.layer.borderWidth = 1;
    _AmountLBNumField.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:_AmountLBNumField];
    
    UIButton * confirmBtn = [[UIButton alloc]init];
    [confirmBtn setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    confirmBtn.backgroundColor = RGBCOLOR(224, 225, 226);
    [confirmBtn addTarget:self action:@selector(confirmInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    [_amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.navBar.mas_bottom).offset(20);
        make.bottom.equalTo(topV.mas_bottom).offset(-40);
    }];
    
    [RecipientLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(topV.mas_bottom).offset(20);
    }];
    
    [_addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(RecipientLB.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    [AmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.addressField.mas_bottom).offset(20);
    }];
    
    [_AmountLBNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(AmountLB.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(58);
        make.right.equalTo(self.view).offset(-58);
        make.height.mas_offset(60);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}
-(void)confirmInfo{
    [_AmountLBNumField resignFirstResponder];
    [_addressField resignFirstResponder];
    if (_addressField.text.length != 34 || ![[self firstCharactorWithString:_addressField.text] isEqualToString:@"A"]) {
        [CVShowLabelView showTitle:@"Recipient's address is invalid." detail:nil];
        return;
    }
    
    if (_addressField.text.length <= 0 || _AmountLBNumField.text.length<=0)
    {
        [CVShowLabelView showTitle:@"Please fill in the blanks." detail:nil];
        return;
    }
    
    NSDecimalNumber
    *decimalFee = [[NSDecimalNumber alloc] initWithString:@"0.01"];//[Common getRealFee:@"500" GasLimit:@"20000"]];;
    NSDecimalNumber *decimalSend = [[NSDecimalNumber alloc] initWithString:_AmountLBNumField.text];
    NSDecimalNumber *decimalAmount = [[NSDecimalNumber alloc] initWithString: _ongNum];
    
    // 这里比较ONG或者ONT发送的总量是否大于余额
    NSComparisonResult resultOfBalanceAndAmount = [decimalSend compare:decimalAmount];
    if (resultOfBalanceAndAmount == NSOrderedDescending) {
        [CVShowLabelView showTitle:@"The amount of the transfer is greater than the total amount." detail:nil];
        return;
    }
    NSDecimalNumber *decimalCost = decimalCost = decimalFee;
    
    NSDecimalNumber *decimalOngAmount = [[NSDecimalNumber alloc] initWithString:_ongNum];
    
    // 这里是比较ong是否足够，如果是发送ong，那么就要把ong手续费和发送的ong加起来和ong余额比较
    NSComparisonResult resultOfCostAndOngAmount = [decimalCost compare:decimalOngAmount];
    if (resultOfCostAndOngAmount == NSOrderedDescending) {
        [CVShowLabelView showTitle:@"Not enough ONG to make the transaction." detail:nil];
        return;
    }
    [GCHApplication inputPassword:^{
        [self createTrade];
    }];
}
-(void)createTrade{
    NSLog(@"createTrade");
    [NeoVM shareInstance].oep4.contractAddress = self.model.ContractHash;
    
    ONTAccount *from = [GCHApplication requestDefaultAccount];
    NSString * sendvalue = [Helper getOEP4Str:_AmountLBNumField.text Decimals:self.model.Decimals];;
    BOOL isPreExec = NO;
    [[NeoVM shareInstance].oep4 sendTransfer:from
                                          to:_addressField.text
                                  withAmount:[sendvalue longLongValue]
                                  byGasPayer:from
                                 useGasLimit:20000
                                 useGasPrice:500
                                     preExec:isPreExec
                               queryCallback:^(id result, NSError *error) {
                                   if (error) {
                                       NSLog(@"error == %@", error);
                                   } else {
                                       if (isPreExec) {
                                           NSLog(@"result == %@", result);
                                       } else {
                                           NSString *txhash = (NSString *)result;
                                           NSLog(@"txhash == %@", txhash);
                                       }
                                   }
                               }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {


if ([textField.text rangeOfString:@"."].location == NSNotFound) {
    isHaveDian = NO;
}
if ([string length] > 0) {
    
    unichar single = [string characterAtIndex:0];//当前输入的字符
    if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
        
        //首字母不能为0和小数点
        if ([textField.text length] == 0) {
            if (single == '.') {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            if (!_isOEP4) {
                if (single == '0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
        }
        //输入的字符是否是小数点
        if (single == '.') {
            
            if (!isHaveDian)//text中还没有小数点
            {
                isHaveDian = YES;
                return YES;
                
            } else {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        } else {
            if (isHaveDian) {//存在小数点
                
                //判断小数点的位数
                NSRange ran = [textField.text rangeOfString:@"."];
                if (_isOEP4) {
                    if (range.location - ran.location <= self.model.Decimals ) {
                        return YES;
                    } else {
                        return NO;
                    }
                }else{
                    if (range.location - ran.location <= 9) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
                
            } else {
                return YES;
            }
        }
    } else {//输入的数据格式不正确
        [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
} else {
    return YES;
}
}
- (BOOL)validateNumber:(NSString *)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//获取某个字符串或者汉字的首字母.
- (NSString *)firstCharactorWithString:(NSString *)string {
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
    
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
