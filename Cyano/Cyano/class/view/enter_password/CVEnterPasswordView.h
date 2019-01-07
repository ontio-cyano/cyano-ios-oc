//
//  CVEnterPasswordView.h
//  Cyano
//
//  Created by Yuanhai on 1/1/19.
//  Copyright © 2019年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVEnterPasswordView : UIView

@property (strong, nonatomic) void (^callBack)(void);

- (void)show;

@end
