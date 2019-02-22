//
//  CTScanViewController.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CVScanMaskView.h"
#import "Helper.h"
#import "CTLoginViewController.h"
#import "CTPayViewController.h"
@interface CTScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureDevice *inputDevice;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, assign) BOOL lightOn;

@end

@implementation CTScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Backgound Color
    self.view.backgroundColor = PurityColor(242);
    
    [self setMainNavigationBar:NavigationBarType_Normal goBack:GoBackType_Back];
    [self initTitleViewWithText:@"Scan"];
    [self initRightNavigationBarWithImageName:@"nav_album"];
    
    [self layoutMainView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.captureSession startRunning];
}

// (继承)Right Nav Button Press
- (void)navRightButtonItemPressed
{
    [self.view endEditing:NO];
    
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
            if (photos.count > 0)
            {
                UIImage *image = [photos lastObject];
                NSData *imageData = UIImagePNGRepresentation(image);
                CIImage *ciImage = [CIImage imageWithData:imageData];
                CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer: @(YES)}];
                CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
                NSArray *features = [detector featuresInImage:ciImage];
                if (features != nil && [features count] > 0)
                {
                    CIQRCodeFeature *feature = [features objectAtIndex:0];
                    [self dealWithCode:feature.messageString];
                }
                else
                {
                    [CVShowLabelView showTitle:@"Error QR code." detail:nil];
                }
            }
        });
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)layoutMainView
{
    [self initCapture];
    [self layoutMaskView];
}

- (void)layoutMaskView
{
    CVScanMaskView *maskView = [[CVScanMaskView alloc] initWithFrame:CGRectMake(0.0f, self.navBar.bottom, self.view.width, self.view.height - self.navBar.bottom)];
    [self.view addSubview:maskView];
    
    // QR code
    UILabel *titleLabel = [self createLabel:maskView];
    titleLabel.frame = CGRectMake(frameMove_X, CGRectGetMaxY(maskView.holeRect), maskView.width - frameMove_X * 2, getUIValue(80.0f));
    titleLabel.text = @"Align the QR code within the frame to scan";
    titleLabel.textColor = WhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // Lights
    float buttonRadius = getUIValue(50.0f);
    UIButton *lightButton = [self createButton:maskView];
    [lightButton addTarget:self action:@selector(lightButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    lightButton.frame = CGRectMake((maskView.width - buttonRadius) / 2, maskView.height - getUIValue(50.0f) - buttonRadius, buttonRadius, buttonRadius);
    [lightButton setBackgroundImage:[UIImage imageNamed:@"scan_lighting_off"] forState:UIControlStateNormal];
}

- (void)initCapture
{
    if (!self.captureSession)
    {
        self.inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:self.inputDevice error:nil];
        
        if (captureInput)
        {
            self.captureSession = [[AVCaptureSession alloc] init];
            [self.captureSession addInput:captureInput];
            
            AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [_captureSession addOutput:captureMetadataOutput];
            [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
            
            NSString* preset = 0;
            if (NSClassFromString(@"NSOrderedSet") && // Proxy for "is this iOS 5" ...
                [UIScreen mainScreen].scale > 1 &&
                [self.inputDevice
                 supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540])
            {
                // NSLog(@"960");
                preset = AVCaptureSessionPresetiFrame960x540;
            }
            if (!preset)
            {
                // NSLog(@"MED");
                preset = AVCaptureSessionPresetMedium;
            }
            self.captureSession.sessionPreset = preset;
        }
    }
    
    if (!self.captureVideoPreviewLayer)
    {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        // [self.view.layer addSublayer:self.captureVideoPreviewLayer];
        [self.view.layer insertSublayer:self.captureVideoPreviewLayer atIndex:0];
        self.captureVideoPreviewLayer.frame = self.view.bounds;
    }
}

#pragma mark - 按钮点击

- (void)lightButtonPress:(UIButton *)button
{
    [self.inputDevice lockForConfiguration:nil];
    if ([self.inputDevice hasFlash])
    {
        self.lightOn = !self.lightOn;
        if (self.lightOn)
        {
            self.inputDevice.flashMode = AVCaptureFlashModeOn;
            self.inputDevice.torchMode = AVCaptureTorchModeOn;
        }
        else
        {
            self.inputDevice.flashMode = AVCaptureFlashModeOff;
            self.inputDevice.torchMode = AVCaptureTorchModeOff;
        }
        [button setBackgroundImage:[UIImage imageNamed:self.lightOn ? @"scan_lighting_on" : @"scan_lighting_off"] forState:UIControlStateNormal];
    }
    [self.inputDevice unlockForConfiguration];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        [self dealWithCode:metadataObj.stringValue];
    }
}

#pragma mark - QR code

// 处理文本
- (void)dealWithCode:(NSString *)code
{
    NSLog(@"code:%@", code);
    
    if (![code isKindOfClass:[NSString class]])
    {
        [CVShowLabelView showTitle:@"Unknow QR code format." detail:nil];
        return;
    }
    
    [self.captureSession stopRunning];
    
    if ([GCHRAM instance].defaultAccount.password){
        ONTAccount *account = [GCHApplication requestDefaultAccount];
        NSDictionary * dic = [Helper dictionaryWithJsonString:code];
        if ([dic isKindOfClass:[NSDictionary class]] && dic[@"action"]) {
            if ([dic[@"action"] isEqualToString:@"login"]) {
                CTLoginViewController * controller = [[CTLoginViewController alloc]init];
                controller.loginInfo = dic;
                controller.account = account;
                [MainAppDelegate.navigationController pushViewController:controller animated:YES];
                return;
            }else if ([dic[@"action"] isEqualToString:@"invoke"]) {
                CTPayViewController * controller = [[CTPayViewController alloc]init];
                controller.payInfo = dic;
                controller.account = account;
                [MainAppDelegate.navigationController pushViewController:controller animated:YES];
                return;
            }
        }
    }else{
        
    }
//    [CVShowLabelView showTitle:code detail:nil];
}

@end
