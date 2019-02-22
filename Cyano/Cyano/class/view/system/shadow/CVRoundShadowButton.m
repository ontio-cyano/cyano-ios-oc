//
//  CVRoundShadowButton.m
//  Cyano
//
//  Created by Yuanhai on 8/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVRoundShadowButton.h"

@implementation CVRoundShadowButton

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self addShadow];
}

- (void)addShadow
{
    // Back
    self.layer.cornerRadius = self.width / 2;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 阴影
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shadowColor = PurityColor(150).CGColor;
}

- (void)setImageEdge:(float)imageEdge
{
    _imageEdge = imageEdge;
    [self setImageEdgeInsets:UIEdgeInsetsMake(imageEdge, imageEdge, imageEdge, imageEdge)];
}

@end
