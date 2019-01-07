//
//  HDCustomComponent.h
//  HDecoration
//
//  Created by koki on 15-4-24.
//  Copyright (c) 2015年 HDecoration. All rights reserved.
//
#define CHTwitterCoverViewHeight      MAX(SCREENWIDTH * 8 / 16, 200)
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (PerformBlockAfterDelay)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end

@interface NSObject (RequestBlock)
@property (nonatomic, strong) NSMutableDictionary *observerDictionary;
- (void)responseBlock:(void (^)(NSDictionary *response))block subAction:(NSString *)subAction;
- (void)notificationBlock:(void (^)(NSDictionary *response))block subAction:(NSString *)subAction;
@end

@interface UIColor (HexStringToColor)
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;
@end

@interface UIView (UIViewFrame)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end

@interface NSObject (CreateView)
- (UIView *)createView:(UIView *)parentView;
- (UIControl *)createControl:(UIView *)parentView;
- (CVParentButton *)createButton:(UIView *)parentView;
- (UILabel *)createLabel:(UIView *)parentView;
- (UIImageView *)createImageView:(UIView *)parentView;
- (UITextField *)createTextField:(UIView *)parentView;
- (UITableView *)createTable:(UIView *)parentView frame:(CGRect)frame target:(id)target;
- (UITextView *)createTextView:(UIView *)parentView;
- (UIScrollView *)createScrollView:(UIView *)parentView;
- (LFDownloadImageView *)createDownloadImageView:(UIView *)parentView;
@end













