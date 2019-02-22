//
//  CTAppsViewController.m
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTAppsViewController.h"
#import "MDApps.h"

@interface CTAppsViewController ()
<UIScrollViewDelegate>

@property (strong, nonatomic) MDApps *appsModel;

@property (strong, nonatomic) UIScrollView *bannerView;
@property (strong, nonatomic) UILabel *indexLabel;
@property (assign, nonatomic) int currentPage;

@property (strong, nonatomic) UIScrollView *appsView;
@property (strong, nonatomic) UILabel *appsLabel;

@end

@implementation CTAppsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Backgound Color
    self.view.backgroundColor = PurityColor(242);
    
    [self setMainNavigationBar:NavigationBarType_None goBack:GoBackType_None];
    [self initRightNavigationBarWithImageName:@"menu"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 请求
    [[CVRefreshVIew instance] startRefresh];
    [[HTTPClient sharedClient]
     sendAsynchronousURL:URL_Dapps
     httpMethod:REQUEST_GET
     parameters:nil
     bodyBlock:nil
     completionHandler:^(id data, BOOL success)
     {
         [[CVRefreshVIew instance] stopRefresh];
         if (success)
         {
             self.appsModel = [[MDApps alloc] initFromDictionary:data[@"result"]];
             [self layoutMainView];
         }
     }];
}

// (继承)Right Nav Button Press
- (void)navRightButtonItemPressed
{
    [GCHApplication pushToWebController:@"" url:URL_Test_Dapp];
}

- (void)layoutMainView
{
    // Banner
    [self layoutBannerView];
    
    // Apps
    [self layoutAppsView];
}

#pragma mark - Banner

- (void)layoutBannerView
{
    if (!self.bannerView)
    {
        float bannerHeight = self.view.width * 336 / 604;
        self.bannerView = [self createScrollView:self.view];
        [self.view sendSubviewToBack:self.bannerView];
        self.bannerView.frame = CGRectMake(0.0f, 0.0f, self.view.width, bannerHeight);
        self.bannerView.pagingEnabled = YES;
        self.bannerView.delegate = self;
        self.bannerView.showsHorizontalScrollIndicator = NO;
        
        float labelHeight = getUIValue(60.0f);
        self.indexLabel = [self createLabel:self.view];
        self.indexLabel.frame = CGRectMake(frameMove_X, self.bannerView.height - labelHeight, self.bannerView.width - frameMove_X * 2, labelHeight);
        self.indexLabel.textColor = WhiteColor;
        self.indexLabel.font = AppleFont_UltraLight(18);
        self.indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    for (UIView *view in self.bannerView.subviews)
    {
        [view removeFromSuperview];
    }
    
    for (int f = 0; f < self.appsModel.banner.count; f++)
    {
        MDBanner *model = self.appsModel.banner[f];
        LFDownloadImageView *imageView = [self createDownloadImageView:self.bannerView];
        imageView.tag = f + 1;
        [imageView addTarget:self action:@selector(bannerItemPress:) forControlEvents:UIControlEventTouchUpInside];
        imageView.frame = CGRectMake(f * self.bannerView.width, 0.0f, self.bannerView.width, self.bannerView.height);
        imageView.imageURL = model.image;
    }
    
    self.bannerView.contentSize = CGSizeMake(self.bannerView.width * self.appsModel.banner.count, self.bannerView.height);
}

- (void)bannerItemPress:(UIView *)view
{
    MDBanner *model = self.appsModel.banner[view.tag - 1];
    [GCHApplication pushToWebController:model.name url:model.link];
}

#pragma mark - Apps

- (void)layoutAppsView
{
    if (!self.appsView)
    {
        float labelHeight = getUIValue(55.0f);
        self.appsLabel = [self createLabel:self.view];
        self.appsLabel.frame = CGRectMake(frameMove_X, self.bannerView.bottom, self.view.width - frameMove_X * 2, labelHeight);
        self.appsLabel.font = AppleFont_UltraLight(18);
        self.appsLabel.textAlignment = NSTextAlignmentCenter;
        self.appsLabel.text = @"Apps";
        
        self.appsView = [self createScrollView:self.view];
        self.appsView.frame = CGRectMake(0.0f, self.self.appsLabel.bottom, self.view.width, self.view.height - tabBarHeight - self.self.appsLabel.bottom);
    }
    
    for (UIView *view in self.appsView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Frame
    int columnCount = 4; // 列
    float itemWidthSpacing = getUIValue(20.0f);
    float itemWidth = (self.appsView.width - itemWidthSpacing * (columnCount + 1)) / columnCount;
    float iconRadius = itemWidth * 0.8;
    float labelHeight = getUIValue(40.0f);
    float itemHeight = iconRadius + labelHeight;
    float itemHeightSpacing = getUIValue(20.0f);
    
    // Layout
    for (int f = 0; f < self.appsModel.apps.count; f++)
    {
        int h = f / columnCount;
        int l = f % columnCount;
        
        MDApp *model = self.appsModel.apps[f];
        
        // Button
        UIButton *button = [self createButton:self.appsView];
        button.tag = f + 1;
        [button addTarget:self action:@selector(appItemPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(l * (itemWidth + itemWidthSpacing) + itemWidthSpacing, h * (itemHeight + itemHeightSpacing), itemWidth, itemHeight);
        
        // Button
        LFDownloadImageView *image = [self createDownloadImageView:button];
        image.frame = CGRectMake((itemWidth - iconRadius) / 2, 0.0f, iconRadius, iconRadius);
        image.imageView.contentMode = UIViewContentModeScaleAspectFit;
        image.imageView.backgroundColor = [UIColor clearColor];
        image.imageURL = model.icon;
        image.layer.masksToBounds = YES;
        image.layer.cornerRadius = viewBorderRadius;
        image.userInteractionEnabled = NO;
        
        // Title
        UILabel *titleLabel = [self createLabel:button];
        titleLabel.frame = CGRectMake(0.0f, image.bottom, button.width, labelHeight);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = AppleFont_UltraLight(14);
        titleLabel.text = model.name;
    }
    
    // Content Size
    self.appsView.contentSize = CGSizeMake(self.appsView.frame.size.width, MAX((self.appsModel.apps.count / columnCount + (self.appsModel.apps.count % columnCount == 0 ? 0 : 1)) * (itemHeight + itemHeightSpacing), self.appsView.frame.size.height + 1));
}

- (void)appItemPress:(UIView *)view
{
    MDApp *model = self.appsModel.apps[view.tag - 1];
    [GCHApplication pushToWebController:model.name url:model.link];
}

#pragma mark - Setter

- (void)setCurrentPage:(int)currentPage
{
    _currentPage = currentPage;
    
    float scrollViewWidth = self.bannerView.width;
    [self.bannerView setContentOffset:CGPointMake(self.currentPage * scrollViewWidth, 0) animated:YES];
    
    self.indexLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage + 1, (int)self.appsModel.banner.count];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float scrollViewWidth = scrollView.width;
    CGPoint offset = scrollView.contentOffset;
    int newPageIndex = offset.x / scrollViewWidth;
    if(offset.x / scrollViewWidth - newPageIndex >= 0.5)
    {
        newPageIndex++;
    }
    self.currentPage = newPageIndex;
}

@end
