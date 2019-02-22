//
//  CCAvatarCell.h
//  Cyano
//
//  Created by Yuanhai on 16/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTableViewCell.h"
@protocol CCAvatarCellDelegate;

@interface CCAvatarCell : CCTableViewCell <CVActionSheetDelegate>

@property (assign, nonatomic) id <CCAvatarCellDelegate> target;
@property (strong, nonatomic) LFDownloadImageView *avatarImageView;

@end

@protocol CCAvatarCellDelegate
- (void)selectedImage;
@end
