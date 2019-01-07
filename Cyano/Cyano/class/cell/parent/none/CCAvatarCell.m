//
//  CCAvatarCell.m
//  Cyano
//
//  Created by Yuanhai on 16/11/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCAvatarCell.h"

#define avatarHeight getUIValue(62.0f)

@implementation CCAvatarCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // 头像
    self.avatarImageView = [self createDownloadImageView:self.contentView];
    self.avatarImageView.frame = CGRectMake(self.center.x - avatarHeight / 2, (self.height - avatarHeight) / 2, avatarHeight, avatarHeight);
    [self.avatarImageView addTarget:self action:@selector(avatarPress) forControlEvents:UIControlEventTouchUpInside];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = avatarHeight / 2;
}

#pragma mark - 按钮点击

- (void)avatarPress
{
    NSArray *titlesArr = @[@"拍照", @"从相册中选取", @"取消"];
    CVActionSheet *actionSheet = [[CVActionSheet alloc] initWithTitles:titlesArr message:nil delegate:self highlight:YES localized:NO];
    [actionSheet show];
}

#pragma mark - CVActionSheetDelegate

- (void)CVActionSheet:(CVActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Select the index : %ld", buttonIndex);
    
    // 拍照
    if (buttonIndex == 0)
    {
        [self getPhotoFromTakePhoto];
    }
    // 从相册中选取
    else if (buttonIndex == 1)
    {
        [self getPhotoFromAlbum];
    }
}

#pragma mark - 拍照

- (void)getPhotoFromTakePhoto
{
    FACameraViewController *cameraVC = [[FACameraViewController alloc] init];
    [cameraVC getResultFromCameraWithBlock:^(UIImage *image, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dealWithImage:image];
        });
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MainAppDelegate.navigationController presentViewController:cameraVC animated:YES completion:nil];
    });
}

- (void)getPhotoFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO;
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.alwaysEnableDoneBtn = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.isStatusBarDefault = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (photos.count > 0) [self dealWithImage:photos[0]];
        });
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MainAppDelegate.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
    });
}

- (void)dealWithImage:(UIImage *)image
{
    self.avatarImageView.imageView.image = image;
    if (self.target) [self.target selectedImage];
}

@end
