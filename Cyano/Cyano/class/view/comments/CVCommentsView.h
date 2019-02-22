//
//  CVCommentsView.h
//  Cyano
//
//  Created by Yuanhai on 14/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCommentsView : UIControl

@property(strong, nonatomic) void (^callBack) (NSString *text);

- (id)initWithPlaceholder:(NSString *)placeholder;
- (void)show;

@end
