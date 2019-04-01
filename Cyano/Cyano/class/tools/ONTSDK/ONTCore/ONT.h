//
//  ONT.h
//  ONTWallet
//
//  Created by zhangyutao on 2018/8/4.
//  Copyright © 2018年 zhangyutao. All rights reserved.
//

#ifndef ONT_h
#define ONT_h

#define kONTMainNet NO  // MainNet or TestNet
//#define kONTRpcURL kONTMainNet?@"http://dappnode1.ont.io:20336":@"http://polaris1.ont.io:20336"
#define kONTRpcURL kONTMainNet?@"http://dappnode1.ont.io:20336":@"http://polaris5.ont.io:20336"
#define kONTRestfulURL kONTMainNet?@"http://dappnode1.ont.io:20334":@"http://polaris1.ont.io:20334"
#define kONTDappServerNode kONTMainNet?@"http://dappnode3.ont.io:20336":@"http://polaris5.ont.io:20336"

#define RECORDURI kONTMainNet?@"https://explorer.ont.io/address/%@/20/1":@"https://explorer.ont.io/address/%@/20/1/testnet"
#define OEP4INFO kONTMainNet?@"https://explorer.ont.io/api/v1/explorer/oepcontract/oep4/20/1":@"https://polarisexplorer.ont.io/api/v1/explorer/oepcontract/oep4/20/1"
//#define kONTRpcURL @"http://192.168.2.176:20336"
//#define kONTRestfulURL @"http://192.168.2.176:20334"


#define kONTScanTxURL(hash) kONTMainNet?[NSString stringWithFormat:@"https://explorer.ont.io/transaction/%@",hash]:[NSString stringWithFormat:@"https://explorer.ont.io/transaction/%@/testnet",hash]
#define kONTExplorerBaseURL(version) kONTMainNet?[NSString stringWithFormat:@"https://explorer.ont.io/api/v%@/explorer",version]:[NSString stringWithFormat:@"https://polarisexplorer.ont.io/api/v%@/explorer",version]

#endif /* ONT_h */
