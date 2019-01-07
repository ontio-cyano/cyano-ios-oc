//
//  HDCustomComponent.m
//  HDecoration
//
//  Created by koki on 15-4-24.
//  Copyright (c) 2015年 HDecoration. All rights reserved.
//

#import "HDCustomComponent.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "AccessoryTextField.h"
#import "SXTextView.h"

#pragma mark - NSObject (PerformBlockAfterDelay)

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}

@end

#pragma mark - NSObject (RequestBlock)

static const void *ObserverDictionaryKey = &ObserverDictionaryKey;
@implementation NSObject (RequestBlock)
@dynamic observerDictionary;

- (NSMutableDictionary *)observerDictionary
{
    return objc_getAssociatedObject(self, ObserverDictionaryKey);
}

- (void)setObserverDictionary:(NSMutableDictionary *)observerDictionary
{
    objc_setAssociatedObject(self, ObserverDictionaryKey, observerDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)responseBlock:(void (^)(NSDictionary *response))block subAction:(NSString *)subAction
{
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:subAction object:nil queue:nil usingBlock:^(NSNotification * _Nonnull notification) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            block(notification.object);
        });
        [[NSNotificationCenter defaultCenter] removeObserver:self.observerDictionary[subAction]];
        [self.observerDictionary removeObjectForKey:subAction];
    }];
    if (!self.observerDictionary) self.observerDictionary = [NSMutableDictionary dictionary];
    [self.observerDictionary setObject:observer forKey:subAction];
}

- (void)notificationBlock:(void (^)(NSDictionary *response))block subAction:(NSString *)subAction
{
    [[NSNotificationCenter defaultCenter] addObserverForName:subAction object:nil queue:nil usingBlock:^(NSNotification * _Nonnull notification) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            block(notification.object);
        });
    }];
}

@end

#pragma mark - UIColor (HexStringToColor)

@implementation UIColor (HexStringToColor)

+(UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

@end

#pragma mark - UIView (UIViewFrame)

@implementation UIView (UIViewFrame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end

#pragma mark - NSObject (CreateView)

@implementation NSObject (CreateView)

- (UIView *)createView:(UIView *)parentView
{
    UIView *view = [[UIView alloc] init];
    [parentView addSubview:view];
    return view;
}

- (UIControl *)createControl:(UIView *)parentView
{
    UIControl *view = [[UIControl alloc] init];
    [parentView addSubview:view];
    return view;
}

- (CVParentButton *)createButton:(UIView *)parentView
{
    CVParentButton *button = [[CVParentButton alloc] init];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [button setTitleColor:LightGreyColor forState:UIControlStateHighlighted];
    button.titleLabel.font = AppleFont_UltraLight(16);
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.minimumScaleFactor = 0.5;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImageEdgeInsets:UIEdgeInsetsMake(15.0f, 0.0f, 15.0f, 0.0f)];
    [parentView addSubview:button];
    return button;
}

- (UILabel *)createLabel:(UIView *)parentView
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = AppleFont_UltraLight(16);
    label.textColor = DarkGreyColor;
    label.numberOfLines = 0;
    label.userInteractionEnabled = NO;
    [parentView addSubview:label];
    return label;
}

- (UIImageView *)createImageView:(UIView *)parentView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [parentView addSubview:imageView];
    imageView.userInteractionEnabled = NO;
    return imageView;
}

- (UITextField *)createTextField:(UIView *)parentView
{
    UITextField *textField = [[AccessoryTextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = AppleFont_UltraLight(16);
    textField.textColor = BlackColor;
    [parentView addSubview:textField];
    return textField;
}

- (UITableView *)createTable:(UIView *)parentView frame:(CGRect)frame target:(id)target
{
    UITableView *tableView = [[CVHideTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.rowHeight = customCellHeight;
    tableView.dataSource = target;
    tableView.delegate = target;
    tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    tableView.backgroundView = nil;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = NO;
    [parentView addSubview:tableView];
    return tableView;
}

- (UITextView *)createTextView:(UIView *)parentView
{
    SXTextView *textView = [[SXTextView alloc] init];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = AppleFont_UltraLight(16);
    textView.textColor = BlackColor;
    [parentView addSubview:textView];
    return textView;
}

- (UIScrollView *)createScrollView:(UIView *)parentView
{
    UIScrollView *scrollView = [[CVHideScrollView alloc] init];
    [parentView addSubview:scrollView];
    return scrollView;
}

- (LFDownloadImageView *)createDownloadImageView:(UIView *)parentView
{
    LFDownloadImageView *imageView = [[LFDownloadImageView alloc] init];
    [parentView addSubview:imageView];
    return imageView;
}

@end

