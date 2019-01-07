//
//  MDAccount.h
//  Cyano
//
//  Created by Yuanhai on 6/1/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAccount : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mnemonicText;
@property (nonatomic, strong) NSString *encryptMnemonicText;
@property (nonatomic, strong) NSString *privateKeyHex;
@property (nonatomic, strong) NSString *wif;
@property (nonatomic, strong) NSString *keystore;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *address;

@end
