//
//  CCRoundTitleTextFieldCell.h
//  Cyano
//
//  Created by Yuanhai on 10/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

@interface CCRoundTitleTextFieldCell : CCRoundCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;

- (void)layoutFrame;

@end
