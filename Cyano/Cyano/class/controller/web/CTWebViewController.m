//
//  CTWebViewController.m
//  DaiGuanJia
//
//  Created by Faney on 16/11/7.
//  Copyright © 2016年 honeywell. All rights reserved.
//  Web 控制器

#import "CTWebViewController.h"
//#import "WebViewJavascriptBridge.h"
#import "RNJsWebView.h"

@interface CTWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) RNJsWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation CTWebViewController

- (void)dealloc
{
    NSLog(@"CTWebViewController dealloc...");
    [self.webView.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMainNavigationBar:NavigationBarType_None goBack:GoBackType_Back];
    [self initTitleViewWithText:self.controllerTitle];
    
    [self layoutMainView];
    
    [self initHandler];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![self.urlString containsString:@"http"])
    {
        self.urlString = [NSString stringWithFormat:@"http://%@", self.urlString];
    }
    
    NSLog(@"url:%@", self.urlString);
    [self.webView setURL:self.urlString];
}

- (void)layoutMainView
{
    // Web View
    self.webView = [[RNJsWebView alloc] initWithFrame:CGRectMake(0.0f, self.navBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navBar.frame.size.height)];
    [self.view addSubview:self.webView];
    
    // Progress
    [self layoutProgressView];
}

- (void)initHandler
{
    __weak typeof(self) weakSelf = self;
    
    // Login
    [self.webView setLoginCallback:^(NSDictionary *callbackDic) {
        NSLog(@"Login:%@", [callbackDic JSONString]);
        NSDictionary *params = @{
                                 @"action":@"login",
                                 @"version":@"v1.0.0",
                                 @"params":
                                     @{
                                         @"type":@"account",
                                         @"user":[GCHRAM instance].defaultAccount.address,
                                         @"dappName":callbackDic[@"params"][@"dappName"],
                                         @"dappIcon":callbackDic[@"params"][@"dappIcon"],
                                         @"message":callbackDic[@"params"][@"message"],
                                         },
                                 @"id":callbackDic[@"id"]
                                 };
        [weakSelf.webView sendMessageToWeb:params];
    }];
    
    // GetAccount
    [self.webView setGetAccountCallback:^(NSDictionary *callbackDic) {
        NSLog(@"GetAccount:%@", [callbackDic JSONString]);
        NSDictionary *params = @{
                                 @"action":@"getAccount",
                                 @"version":@"v1.0.0",
                                 @"error":@(0),
                                 @"desc":@"SUCCESS",
                                 @"result":[GCHRAM instance].defaultAccount.address,
                                 @"id":callbackDic[@"id"]
                                 };
        [weakSelf.webView sendMessageToWeb:params];
    }];
    
    // Invoke
    [self.webView setInvokeTransactionCallback:^(NSDictionary *callbackDic) {
        NSLog(@"Invoke:%@", [callbackDic JSONString]);
        [GCHApplication inputPassword:^{
            NSString *txHex = [weakSelf invokeHex:callbackDic];
            if (!txHex) return;
            [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:NO callback:^(NSString *txHash, NSError *error) {
                if (error)
                {
                    NSLog(@"error == %@", error);
                    [CVShowLabelView showTitle:@"Invoke failed." detail:nil];
                }
                else
                {
                    NSLog(@"txHash == %@", txHash);
                    NSLog(@"View on explorer：%@", kONTScanTxURL(txHash));
                    NSDictionary *params = @{
                                             @"action":@"invoke",
                                             @"version": @"v1.0.0",
                                             @"error": @(0),
                                             @"desc": @"SUCCESS",
                                             @"result":txHash,
                                             @"id":callbackDic[@"id"]
                                             };
                    [weakSelf.webView sendMessageToWeb:params];
                }
            }];
        }];
    }];
    
    // InvokeRead
    [self.webView setInvokeReadCallback:^(NSDictionary *callbackDic) {
        NSLog(@"InvokeRead:%@", [callbackDic JSONString]);
        [GCHApplication inputPassword:^{
            ONTAccount *account = [GCHApplication requestDefaultAccount];
            [[NeoVM shareInstance].oep4 sendInit:account
                                      byGasPayer:account
                                     useGasLimit:0//10000000
                                     useGasPrice:0//500
                                         preExec:YES
                                   queryCallback:^(id result, NSError *error) {
                                       if (error) {
                                           NSLog(@"error == %@", error);
                                           [CVShowLabelView showTitle:@"Invoke read failed." detail:nil];
                                       } else {
                                           NSLog(@"result == %@", result);
                                           NSDictionary *params = @{
                                                                    @"action":@"invokeRead",
                                                                    @"version": @"v1.0.0",
                                                                    @"error": @(0),
                                                                    @"desc": @"SUCCESS",
                                                                    @"result":result,
                                                                    @"id":callbackDic[@"id"]
                                                                    };
                                           [weakSelf.webView sendMessageToWeb:params];
                                       }
                                   }];
        }];
    }];
    
    // InvokePasswordFree
    [self.webView setInvokePasswordFreeCallback:^(NSDictionary *callbackDic) {
        NSLog(@"InvokePasswordFree:%@", [callbackDic JSONString]);
        [GCHApplication inputPassword:^{
            NSString *txHex = [weakSelf invokeHex:callbackDic];
            if (!txHex) return;
            [[ONTRpcApi shareInstance] sendRawtransactionWithHexTx:txHex preExec:NO callback:^(NSString *txHash, NSError *error) {
                if (error)
                {
                    NSLog(@"error == %@", error);
                    [CVShowLabelView showTitle:@"Invoke failed." detail:nil];
                }
                else
                {
                    NSLog(@"txHash == %@", txHash);
                    NSLog(@"View on explorer：%@", kONTScanTxURL(txHash));
                    NSDictionary *params = @{
                                             @"action":@"invokePasswordFree",
                                             @"version": @"v1.0.0",
                                             @"error": @(0),
                                             @"desc": @"SUCCESS",
                                             @"result":txHash,
                                             @"id":callbackDic[@"id"]
                                             };
                    [weakSelf.webView sendMessageToWeb:params];
                }
            }];
        }];
    }];
}

// Invoke
- (NSString *)invokeHex:(NSDictionary *)dic
{
    NSDictionary *invokeConfig = dic[@"params"][@"invokeConfig"];
    NSArray *functions = invokeConfig[@"functions"];
    if (functions.count <= 0)
    {
        [CVShowLabelView showTitle:@"Params error." detail:nil];
        return nil;
    }
    
    NSDictionary *function = functions[0];
    NSArray *args = function[@"args"];
    if (args.count != 4)
    {
        [CVShowLabelView showTitle:@"Params error." detail:nil];
        return nil;
    }
    
    ONTTokenType tokenType = [(NSString *)(args[0][@"value"]) containsString:@"ong"] ? ONTTokenTypeONG : ONTTokenTypeONT;
    NSString *toAddress = [GCHString getDictionaryValue:args[2][@"value"]];
    NSString *amount = [NSString stringWithFormat:@"%@", args[3][@"value"]];
    long gasPrice = [invokeConfig[@"gasPrice"] longValue];
    long gasLimit = [invokeConfig[@"gasLimit"] longValue];
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    NSLog(@"account:%@", account);
    return [account makeTransferTxWithToken:tokenType toAddress:toAddress amount:amount gasPrice:gasPrice gasLimit:gasLimit];
}

#pragma mark - Progress

- (void)layoutProgressView
{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.navBar.bottom, [[UIScreen mainScreen] bounds].size.width, 1.0f)];
    self.progressView.tintColor = MainViewsColor;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    [self.webView.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = self.webView.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1)
        {
            [UIView animateWithDuration:0.2f animations:^ {
                self.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.progressView removeFromSuperview];
            }];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
