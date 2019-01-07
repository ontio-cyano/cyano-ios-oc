//
//  LFDownloadImageView.h
//  FileDownload
//
//  Created by Yuanhai on 21/7/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFDownloadImageView : UIControl

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString *imageURL;

@property (strong, nonatomic) void(^callBack)(LFDownloadImageView *);

@end
