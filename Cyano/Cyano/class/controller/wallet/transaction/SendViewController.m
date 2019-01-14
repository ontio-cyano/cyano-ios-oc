//
//  SendViewController.m
//  Cyano
//
//  Created by Apple on 2019/1/10.
//  Copyright © 2019 Yuanhai. All rights reserved.
//

#import "SendViewController.h"

@interface SendViewController ()
<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isHaveDian;
}
@property(nonatomic,strong)UITextField * AssetTypeField;
@property(nonatomic,strong)UITextField * AmountLBNumField;
@property(nonatomic,strong)UITextField * addressField;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)  NSString      *confirmPwd;
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PurityColor(242);
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initLeftNavigationBarWithImageName:@"BackWhite"];
    [self initTitleViewWithText:@"Send"];
    
    [self layoutMainView];
}
-(void)layoutMainView{
    UIView * topV = [self createView:self.view];
    topV.backgroundColor = MainViewsColor;
    
    UILabel * alertLB = [self createLabel:topV];
    alertLB.textColor = WhiteColor;
    alertLB.text = @"Double check the address of the recipient.";
    alertLB.font = AppleFont_UltraLight(14);
    alertLB.textAlignment = NSTextAlignmentCenter;
    alertLB.numberOfLines = 0;
    
    UILabel * RecipientLB = [[UILabel alloc]init];
    RecipientLB.text = @"Recipient";
    RecipientLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:RecipientLB];
    
    _addressField = [[UITextField alloc]init];
    //    _addressField.delegate = self;
    _addressField.backgroundColor = WhiteColor;
    _addressField.font = [UIFont systemFontOfSize:14];
    _addressField.layer.borderWidth = 1;
    _addressField.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:_addressField];
    
    UILabel * AssetLB = [[UILabel alloc]init];
    AssetLB.text = @"Asset";
    AssetLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:AssetLB];
    
    _AssetTypeField = [[UITextField alloc]init];
    _AssetTypeField.enabled = NO;
    _AssetTypeField.text = @"ONT";
    _AssetTypeField.backgroundColor = WhiteColor;
    _AssetTypeField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    _AssetTypeField.layer.borderWidth = 1;
    _AssetTypeField.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.view addSubview:_AssetTypeField];
    
    UIButton * changeBtn = [[UIButton alloc]init];
    [changeBtn addTarget:self action:@selector(hiddenTableV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    UIImageView * arrowImage = [[UIImageView alloc]init];
    arrowImage.image = [UIImage imageNamed:@"sDown"];
    [self.view addSubview:arrowImage];
    
    
    UILabel * AmountLB = [[UILabel alloc]init];
    AmountLB.text = @"Amount";
    AmountLB.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:AmountLB];
    
    _AmountLBNumField = [[UITextField alloc]init];
    //    _AmountLBNumField.text = @"0";
    [_AmountLBNumField addTarget:self action:@selector(limit10Chars:) forControlEvents:UIControlEventEditingChanged];
    
    _AmountLBNumField.keyboardType = _isONT ? UIKeyboardTypeNumberPad : UIKeyboardTypeDecimalPad;
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
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.layer.borderWidth = 1;
    _tableView.layer.borderColor = [[UIColor blackColor]CGColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];

    
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    [alertLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(topV).offset(20);
        make.bottom.equalTo(topV.mas_bottom).offset(-30);
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
    
    [AssetLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.addressField.mas_bottom).offset(20);
    }];
    
    [_AssetTypeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(AssetLB.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(AssetLB.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(changeBtn);
        make.top.equalTo(self.AssetTypeField.mas_bottom).offset(-1);
        make.height.mas_offset(120);
    }];
    
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(changeBtn.mas_centerY);
        make.width.height.mas_offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    [AmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.AssetTypeField.mas_bottom).offset(20);
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
    NSDecimalNumber *decimalAmount = [[NSDecimalNumber alloc] initWithString:_isONT ? _ontNum: _ongNum];
    
    // 这里比较ONG或者ONT发送的总量是否大于余额
    NSComparisonResult resultOfBalanceAndAmount = [decimalSend compare:decimalAmount];
    if (resultOfBalanceAndAmount == NSOrderedDescending) {
        [CVShowLabelView showTitle:@"The amount of the transfer is greater than the total amount." detail:nil];
        return;
    }
    NSDecimalNumber *decimalCost = nil;
    if (!_isONT) {
        decimalCost = [decimalSend decimalNumberByAdding:decimalFee];
    } else {
        decimalCost = decimalFee;
    }
    NSDecimalNumber *decimalOngAmount = [[NSDecimalNumber alloc] initWithString:_ongNum];
    
    // 这里是比较ong是否足够，如果是发送ong，那么就要把ong手续费和发送的ong加起来和ong余额比较
    NSComparisonResult resultOfCostAndOngAmount = [decimalCost compare:decimalOngAmount];
    if (resultOfCostAndOngAmount == NSOrderedDescending) {
        [CVShowLabelView showTitle:@"Not enough ONG to make the transaction." detail:nil];
        return;
    }
    [GCHApplication inputPassword:^{
        if (self.isONT) {
            [self makeOntTrade];
        }else{
            [self makeOngTrade];
        }
    }];
}
-(void)makeOntTrade{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONT toAddress:_addressField.text amount:_AmountLBNumField.text gasPrice:500 gasLimit:20000];
    
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:NO callback:^(NSString *txHash, NSError *error) {
        if (error) {
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            [CVShowLabelView showTitle:@"The transaction has been issued." detail:nil];
        }
    }];
}
-(void)makeOngTrade{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    NSString *txHex = [account makeTransferTxWithToken:ONTTokenTypeONG toAddress:_addressField.text amount:_AmountLBNumField.text gasPrice:500 gasLimit:20000];
    
    [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:NO callback:^(NSString *txHash, NSError *error) {
        if (error) {
            [CVShowLabelView showTitle:@"error" detail:nil];
        } else {
            [CVShowLabelView showTitle:@"The transaction has been issued." detail:nil];
        }
    }];
}
-(void)hiddenTableV{
    if (self.tableView.isHidden == YES) {
        self.tableView.hidden = NO;
    }else{
        self.tableView.hidden = YES;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UITextField * field = [[UITextField alloc]init];
        field.tag = 1001;
        field.enabled = NO;
        field.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [cell.contentView addSubview:field];
        
        UIView * line = [[UIView alloc]init];
        line.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:line];
        
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cell.contentView);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
            make.height.mas_offset(1);
        }];
    }
    
    UITextField * assetField = [cell.contentView viewWithTag:1001];
    if (indexPath.row == 0) {
        assetField.text = @"ONT";
        if (self.isONT) {
            cell.backgroundColor = PurityColor(242);
        }else{
            cell.backgroundColor = WhiteColor;
        }
    }else{
        assetField.text = @"ONG";
        if (self.isONT) {
            cell.backgroundColor = WhiteColor;
        }else{
            cell.backgroundColor = PurityColor(242);
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _AssetTypeField.text = @"ONT";
        self.isONT = YES;
    }else{
        _AssetTypeField.text = @"ONG";
        self.isONT = NO;
    }
    _AmountLBNumField.keyboardType = _isONT ? UIKeyboardTypeNumberPad : UIKeyboardTypeDecimalPad;
    [_tableView reloadData];
    _tableView.hidden = YES;
}
- (void)limit10Chars:(UITextField *)textField {
    if (_isONT) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_isONT) {
        return [self validateNumber:string];
    }
    
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
                
                if (_isONT == YES) {
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
                    if (range.location - ran.location <= 9) {
                        return YES;
                    } else {
                        return NO;
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
