//
//  CVAlertView.h
//  CUBE
//
//  Created by Faney on 15/10/12.
//  Copyright © 2015年 Faney. All rights reserved.
//

@protocol CVAlertViewDelegate;

@interface CVAlertView : UIControl

@property (weak, nonatomic) id <CVAlertViewDelegate> delegate;

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail needCancel:(BOOL)needCancel delegate:(id<CVAlertViewDelegate>)delegate;

- (void)show;

@end

@protocol CVAlertViewDelegate

@optional
- (void)CVAlertView:(CVAlertView *)alert selected:(int)selected;

@end
