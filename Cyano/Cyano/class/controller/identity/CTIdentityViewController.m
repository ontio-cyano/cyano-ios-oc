//
//  CTIdentityViewController.m
//  Cyano
//
//  Created by Yuanhai on 26/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTIdentityViewController.h"

@interface CTIdentityViewController ()

@end

@implementation CTIdentityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Backgound Color
    self.view.backgroundColor = PurityColor(242);
    
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_None];
    [self initTitleViewWithText:@"Identity"];
    
    [self layoutMainView];
}

- (void)layoutMainView
{
}

@end
