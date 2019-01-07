//
//  FACameraViewController.h
//  CloudStudyTeacher
//
//  Created by Yuanhai on 30/10/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CameraBlock) (UIImage *image, NSDictionary *info);

@interface FACameraViewController : UIImagePickerController

/** 拍摄照片回调方法
 * @brief image: 拍摄获取的图片, info: 图片的相关信息
 */
- (void)getResultFromCameraWithBlock:(CameraBlock)block;

@end
