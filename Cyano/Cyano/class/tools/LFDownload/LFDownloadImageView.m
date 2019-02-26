//
//  LFDownloadImageView.m
//  FileDownload
//
//  Created by Yuanhai on 21/7/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

#import "LFDownloadImageView.h"
#import "NSString+MD5Digest.h"

@interface LFDownloadImageView ()

@end

@implementation LFDownloadImageView

- (void)dealloc
{
    // NSLog(@"dealloc......................");
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initMainView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initMainView];
    }
    return self;
}

- (void)initMainView
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = self.bounds;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = LightWhiteColor;
    self.imageView.image = [UIImage imageNamed:@"LFDEFAULT"];
    [self addSubview:self.imageView];
}

#pragma mark - SET

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageView.frame = self.bounds;
}

- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    // NSLog(@"imageURL:%@", imageURL);
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"LFDEFAULT"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (self.callBack)
        {
            self.callBack(self);
        }
    }];
}

@end
