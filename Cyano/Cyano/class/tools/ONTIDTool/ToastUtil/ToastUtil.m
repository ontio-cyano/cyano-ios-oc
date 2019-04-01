//
//  ToastUtil.m
//  Customer2_0_0
//
//  Created by liuhaoyang on 16/7/1.
//  Copyright © 2016年 xjs_fdm. All rights reserved.
//

#import "ToastUtil.h"
#define appwwindow [[UIApplication sharedApplication].delegate window]

@implementation ToastUtil


+(void)shortToast:(UIView *)view value:(NSString *)text{
    ONTOMBProgressHUD *hud = [ONTOMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = ONTOMBProgressHUDModeText;
    hud.detailsLabel.text=text;
    hud.margin = 10.f;
//    hud.yOffset = 15.f;
//    hud.offset.y = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.font = [UIFont systemFontOfSize:18];
    [hud hideAnimated:YES afterDelay:2.0f];
}

+(void)toast:(UIView *)view value:(NSString *)text longTime:(CGFloat)time{
    ONTOMBProgressHUD *hud = [ONTOMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = ONTOMBProgressHUDModeText;
    hud.label.text=text;
     hud.label.font  = [UIFont systemFontOfSize:12];
    [hud hideAnimated:YES afterDelay:time];
}

+ (ONTOMBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if (view == nil) view = appwwindow;
    ONTOMBProgressHUD *hud = [ONTOMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
    return hud;
}


@end
