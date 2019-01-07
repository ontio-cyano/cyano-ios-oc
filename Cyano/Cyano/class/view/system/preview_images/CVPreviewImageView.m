//
//  CVPreviewImageView.m
//  Cyano
//
//  Created by Yuanhai on 12/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVPreviewImageView.h"

@interface CVPreviewImageView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

@end

@implementation CVPreviewImageView

+ (void)previewImage:(UIImage *)image
{
    CVPreviewImageView *view = [[CVPreviewImageView alloc] initImage:image];
    [view show];
}

- (id)initImage:(UIImage *)image
{
    if (self = [self init])
    {
        NSLog(@"image:%@", image);
        self.image = image;
        
        // 显示图片
        [self initImageView];
        
        // 其他地方点击
        [self addTarget:self action:@selector(itemPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tag = CVPreviewImageTag;
        
        // Frame
        UIViewController *controller = MainAppDelegate.navigationController.topViewController;
        UIView *parentView = MainAppDelegate.navigationController.view;
        if ([controller isKindOfClass:[CTParentLandscapeViewController class]])
        {
            parentView = ((CTParentLandscapeViewController *)controller).mainView;
        }
        self.frame = parentView.bounds;
        
        // Back Color
        self.backgroundColor = PopViewBlackBackColor;
    }
    return self;
}

- (void)show
{
    UIViewController *controller = MainAppDelegate.navigationController.topViewController;
    UIView *parentView = MainAppDelegate.navigationController.view;
    if ([controller isKindOfClass:[CTParentLandscapeViewController class]])
    {
        parentView = ((CTParentLandscapeViewController *)controller).mainView;
    }
    
    // 删除其他显示
    UIView *lastShowView = [parentView viewWithTag:CVPreviewImageTag];
    [lastShowView removeFromSuperview];
    
    [parentView endEditing:NO];
    [parentView addSubview:self];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.2f animations:^ {
        self.alpha = 1.0f;
    } completion:nil];
}

// 显示图片
- (void)initImageView
{
    self.imageView = [self createImageView:self];
    // self.imageView.image = [UIImage imageNamed:self.image];
    self.imageView.image = self.image;
    
    // Frame
    float imageWidth = self.imageView.image.size.width;
    float imageHeight = self.imageView.image.size.height;
    float viewHeight = 0.0f;
    float viewWidth = 0.0f;
    if (imageWidth / imageHeight < self.width / self.height)
    {
        viewHeight = self.height;
        viewWidth = viewHeight * imageWidth / imageHeight;
    }
    else
    {
        viewWidth = self.width;
        viewHeight = viewWidth * imageHeight / imageWidth;
    }
    NSLog(@"a:%f", (self.width - viewWidth) / 2);
    NSLog(@"a:%f", self.height);
    NSLog(@"a:%f", (self.height - viewHeight) / 2);
    NSLog(@"a:%f", viewWidth);
    NSLog(@"a:%f", viewHeight);
    self.imageView.frame = CGRectMake((self.width - viewWidth) / 2, (self.height - viewHeight) / 2, viewWidth, viewHeight);
}

- (void)itemPress:(UIControl *)button
{
    [UIView animateWithDuration:animate_duration animations:^ {
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
