//
//  CCAccountCountDownCell.h
//  Cyano
//
//  Created by Yuanhai on 22/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTableViewCell.h"
#import "CountdownButton.h"

@interface CCAccountCountDownCell : CCTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) CountdownButton *countdownButton;

@end
