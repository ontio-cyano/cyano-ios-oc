//
//  CVPickerView.h
//  Cyano
//
//  Created by Yuanhai on 13/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NumberPickerGetter)(NSString *title);

@interface CVPickerView : UIControl

@property (strong, nonatomic) NumberPickerGetter numberPickerGetter;

@property (strong, nonatomic) NSString *title;

- (id)initWithTitles:(NSArray *)titles select:(NSString *)select;

- (void)show;

@end
