//
//  CCTitleTextFieldCell.h
//  iQBTeacher
//
//  Created by Yuanhai on 10/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCLineCell.h"

@interface CCTitleTextFieldCell : CCTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *textBackView;
@property (strong, nonatomic) UITextField *textField;

@end
