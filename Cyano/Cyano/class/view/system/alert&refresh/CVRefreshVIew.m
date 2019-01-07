//
//  CVRefreshVIew.m
//  CUBE
//
//  Created by Faney on 16/3/24.
//  Copyright © 2016年 Faney. All rights reserved.
//  请求转圈视图

#import "CVRefreshVIew.h"

#define backRadius getUIValue(80.0f)

@interface CVRefreshVIew ()

@property (strong, nonatomic) NSTimer *showActivityTimer;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@end

@implementation CVRefreshVIew

+ (CVRefreshVIew *)instance
{
    static CVRefreshVIew *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[CVRefreshVIew alloc] init];
        }
    }
    return instance;
}

- (void)startRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.showActivityTimer isValid]) [self.showActivityTimer invalidate];
        self.showActivityTimer = nil;
        self.showActivityTimer = [NSTimer scheduledTimerWithTimeInterval:RequestTimeOut target:self selector:@selector(activityOnTimeOut) userInfo:nil repeats:NO];
        
        // [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        // return;
        
        if (!self.backView)
        {
            self.backView = [[UIView alloc] init];
            
            // Activity
            self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        UIViewController *controller = MainAppDelegate.navigationController.topViewController;
        UIView *parentView = MainAppDelegate.navigationController.view;
        float parentWidth = parentView.width;
        float parentHeight = parentView.height;
        if ([controller isKindOfClass:[CTParentLandscapeViewController class]])
        {
            parentView = ((CTParentLandscapeViewController *)controller).mainView;
            parentWidth = ((CTParentLandscapeViewController *)controller).width;
            parentHeight = ((CTParentLandscapeViewController *)controller).height;
        }
        
        self.backView.frame = CGRectMake((parentWidth - backRadius) / 2, (parentHeight - backRadius) / 2, backRadius, backRadius);
        self.backView.backgroundColor = ActivityBackColor;
        self.backView.layer.masksToBounds = YES;
        self.backView.layer.cornerRadius = viewBorderRadius;
        [parentView addSubview:self.backView];
        
        self.activityView.center = CGPointMake(parentWidth / 2, parentHeight / 2);
        [parentView addSubview:self.activityView];
        [self.activityView startAnimating];
    });
}

- (void)stopRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.showActivityTimer isValid]) [self.showActivityTimer invalidate];
        self.showActivityTimer = nil;
        
        // [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // return;
        
        [self.activityView stopAnimating];
        [self.activityView removeFromSuperview];
        [self.backView removeFromSuperview];
    });
}

// Activity Time Out
- (void)activityOnTimeOut
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.showActivityTimer isValid]) [self.showActivityTimer invalidate];
        self.showActivityTimer = nil;
        [self stopRefresh];
    });
}

@end
