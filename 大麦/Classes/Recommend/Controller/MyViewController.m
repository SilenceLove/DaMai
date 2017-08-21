//
//  MyViewController.m
//  大麦
//
//  Created by 洪欣 on 2017/7/4.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "MyViewController.h"
#import <GPUImage.h>
@interface MyViewController ()
@property (nonatomic , strong) GPUImageVideoCamera *videoCamera;
//写入视频文件类
@property (nonatomic , strong) GPUImageMovieWriter *movieWriter;
//显示录制视频view
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
//显示录制视频view
@property (nonatomic , strong) GPUImageView *filterView;
@property (nonatomic , strong) GPUImageOutput<GPUImageInput> *filter;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCameraView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.videoCamera startCameraCapture];
    
    //如果未开启相机权限 则返回上级页面
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    switch (AVstatus) {
            //允许状态
        case AVAuthorizationStatusAuthorized:{
            NSLog(@"Authorized");
            
            break;
        }
            //不允许状态，可以弹出一个alertview提示用户在隐私设置中开启权限
        case AVAuthorizationStatusDenied:{
            NSLog(@"Denied");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            break;
        }
            //未知，第一次申请权限
        case AVAuthorizationStatusNotDetermined:
            break;
            //此应用程序没有被授权访问,可能是家长控制权限
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.videoCamera stopCameraCapture];
    
}
- (void)setupCameraView {
    
    //录制视频
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    //该句可防止允许声音通过的情况下，避免录制第一帧黑屏闪屏(====)
    [self.videoCamera addAudioInputsAndOutputs];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    self.videoInput = [self.videoCamera valueForKey:@"videoInput"];
    
    
    self.filter = [[GPUImageFilter alloc] init];
    [self.videoCamera addTarget:self.filter];
    
    CGRect frame = CGRectMake(0, 0,ScreenWidth , ScreenHeight);
    //显示视频
    self.filterView = [[GPUImageView alloc] initWithFrame:frame];
    self.filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    self.filterView.clipsToBounds = YES;
    [self.filterView.layer setMasksToBounds:YES];
    [self.view addSubview: _filterView];
    
}
@end
