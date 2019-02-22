//
//  CCTitleTextViewCell.h
//  Cyano
//
//  Created by Yuanhai on 28/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTableViewCell.h"
#import "SXTextView.h"

@interface CCTitleTextViewCell : CCTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *textBackView;
@property (strong, nonatomic) SXTextView *textView;

@end
