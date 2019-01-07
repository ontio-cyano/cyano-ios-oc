//
//  FACameraViewController.m
//  CloudStudyTeacher
//
//  Created by Yuanhai on 30/10/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import "FACameraViewController.h"

static NSString *const kPublicImageMediaType = @"public.image";

@interface FACameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, copy) CameraBlock cameraBlock;

@end

@implementation FACameraViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied)
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
            alertController.view.tintColor = MainAlertTintColor;
            // 设置
            [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }]];
            // 取消
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [MainAppDelegate.navigationController.topViewController presentViewController:alertController animated:YES completion:nil];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.delegate = self;
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        else
        {
            NSLog(@"设备不支持照相功能");
        }
    }
    return self;
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:kPublicImageMediaType])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.cameraBlock(image, info);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getResultFromCameraWithBlock:(CameraBlock)block
{
    self.cameraBlock = block;
}

@end
