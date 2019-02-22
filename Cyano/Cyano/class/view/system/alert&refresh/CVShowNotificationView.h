//
//  CVShowNotificationView.h
//  Cyano
//
//  Created by Yuanhai on 5/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVShowNotificationView : UIControl

+ (void)showTitle:(NSString *)title callBack:(void(^)(void))callBack;

@end
