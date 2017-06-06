//
//  HBQRCodeController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBQRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "HBVHButton.h"
#import "HBManalLockController.h"
static const CGFloat kBorderW = 100;
static const CGFloat kMargin = 30;
@interface HBQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak)   UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIImageView *scanNetImageView;

@end

@implementation HBQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"扫码开锁";
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont systemFontOfSize:14];
    [bt setTitle:@"使用帮助" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(qrCodeHelpBtViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.rightBarButtonItem =leftBar;
    
    
    // 这个属性必须打开否则返回的时候会出现黑边
    self.view.clipsToBounds=YES;
    //1.遮罩
    [self setupMaskView];
   
    //3.提示文本
    [self setupTipTitleView];
    //2.下边栏
    [self setupBottomBar];
    //5.扫描区域
    [self setupScanWindowView];
    //6.开始动画
    [self beginScanning];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resumeAnimation) name:@"EnterForeground" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self resumeAnimation];
    
    
}

-(void)setupTipTitleView{
    
    //1.补充遮罩
    
    UIView*masktop=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, _maskView.y)];
    masktop.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:masktop];
    UIImageView *imagev=[[UIImageView alloc] init];
    imagev.backgroundColor=[UIColor clearColor];
    imagev.contentMode=UIViewContentModeScaleAspectFit;
    imagev.frame=CGRectMake(kMargin, 10, self.view.width-kMargin*2, kBorderW-20);
    [imagev setImage:[UIImage imageNamed:@"bikeIcon1"]];
    [masktop addSubview:imagev];
    
    
    UIView*mask=[[UIView alloc]initWithFrame:CGRectMake(0, _maskView.y+_maskView.height, self.view.width, kBorderW+200)];
    mask.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:mask];
    //2.操作提示
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height*0.9-kBorderW*2, self.view.bounds.size.width, kBorderW)];
    tipLabel.text = @"对准车上的二维码";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
}

- (void)setupMaskView
{
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    
    mask.bounds = CGRectMake(0, 0, self.view.width + kBorderW  , self.view.width + kBorderW );
    mask.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    mask.y = 20;
    
    [self.view addSubview:mask];
}


- (void)setupBottomBar

{
    //1.下边栏
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-64-self.view.height * 0.20, self.view.width, self.view.height * 0.15)];
    [self.view addSubview:bottomBar];
    
    //2.我的二维码
    HBVHButton * myCodeBtn=[[HBVHButton alloc] init];
    myCodeBtn.frame = CGRectMake(0,0, 200, self.view.height * 0.15);
    myCodeBtn.center=CGPointMake(self.view.width/4, self.view.height * 0.15/2);
    [myCodeBtn setTitle:@"输入编号开锁" forState:UIControlStateNormal];
    [myCodeBtn setImage:[UIImage imageNamed:@"manual_input"] forState:UIControlStateNormal];
    myCodeBtn.contentMode=UIViewContentModeScaleAspectFit;
    [myCodeBtn addTarget:self action:@selector(inputLockNumOnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:myCodeBtn];
    //3.闪光灯
    HBVHButton * flashBtn=[[HBVHButton alloc] init];
    flashBtn.frame = CGRectMake(0,0, 200, self.view.height * 0.15);
    flashBtn.center=CGPointMake(self.view.width/4*3, self.view.height * 0.15/2);
    [flashBtn setTitle:@"打开闪光灯" forState:UIControlStateNormal];
     [flashBtn setImage:[UIImage imageNamed:@"lamplight_open"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:flashBtn];
}



-(void)inputLockNumOnClick
{
    HBManalLockController *manalLockVc=[[HBManalLockController alloc] init];
    [self.navigationController pushViewController:manalLockVc animated:YES];
}


- (void)setupScanWindowView
{
    CGFloat scanWindowH = self.view.width - kBorderW;
    CGFloat scanWindowW = self.view.width - kBorderW;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kBorderW/2, kBorderW+20, scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line"]];
    CGFloat buttonWH = 18;
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_case_lefttop"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_case_righttop"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_case_leftbottom"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.x, bottomLeft.y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_case_rightbottom"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}

- (void)beginScanning
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描", nil];
        [alert show];
    }
}


#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}
#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


#pragma mark 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = 5;
        CGFloat scanWindowH = self.view.width - kMargin * 2;
        CGFloat scanNetImageViewW = _scanWindow.width;
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 2.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
    }
    
    
    
}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
#pragma mark-> 返回
- (void)disMiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self disMiss];
    } else if (buttonIndex == 1) {
        [_session startRunning];
    }
}



//使用帮助
-(void)qrCodeHelpBtViewOnClick
{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
