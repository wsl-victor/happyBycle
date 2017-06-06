//
//  HBHomeViewController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/18.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBHomeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "HBPersonManagerController.h"
#import "HBSearchViewController.h"
#import "HBMessageViewController.h"
#import "HMSegmentedControl.h"

#import "HBMyRedPaperController.h"
#import "CustomServiceAlert.h"
#import "HBQRCodeController.h"


#import "HBCarBadLockedController.h"
#import "HBCarBadViewController.h"
#import "HBCarIllegallyParkController.h"
#import "HBCarOtherQuestionController.h"
#import "HBADDetailViewController.h"
@interface HBHomeViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl3;

@property (nonatomic, strong) UIButton *topBannerBt;
@end

@implementation HBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AMapView];
    [self topCategoryView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}



-(void)topCategoryView
{
    HMSegmentedControl *segmentedControl3 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部单车", @"Mobike", @"Mobike Lite", @"Mobike", @"Mobike Lite"]];
    [segmentedControl3 setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
    [segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %ld (via block)", (long)index);
    }];
    segmentedControl3.type=HMSegmentedControlTypeText;
    segmentedControl3.selectionIndicatorHeight = 0.0f;
    segmentedControl3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_black"]];//[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1];
    segmentedControl3.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    segmentedControl3.selectionIndicatorColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_black"]]; //[UIColor blueColor];//[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1];
    segmentedControl3.selectionIndicatorBoxColor = [UIColor redColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    segmentedControl3.selectionIndicatorBoxOpacity = 1.0;
    segmentedControl3.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl3.selectedSegmentIndex = HMSegmentedControlNoSegment;
    segmentedControl3.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl3.shouldAnimateUserSelection = YES;
    //segmentedControl3.segment //HMSegmentedControlSegmentWidthStyle
    segmentedControl3.segmentEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    segmentedControl3.tag = 2;
    [self.view addSubview:segmentedControl3];
    [segmentedControl3 setSelectedSegmentIndex:0];
    self.segmentedControl3=segmentedControl3;
    
    
    UIButton *topBannerBt=[[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(segmentedControl3.frame)+10, [UIScreen mainScreen].bounds.size.width-20, 55)];
    topBannerBt.titleLabel.font=[UIFont systemFontOfSize:16];
    [topBannerBt setBackgroundImage:[UIImage imageNamed:@"topup_banner"] forState:UIControlStateNormal];
    [topBannerBt setBackgroundImage:[UIImage imageNamed:@"topup_banner"] forState:UIControlStateHighlighted];
    [self.view addSubview:topBannerBt];
    [topBannerBt addTarget:self action:@selector(topBannerBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBannerBt setImage:[UIImage imageNamed:@"seviceScan"] forState:UIControlStateNormal];
   
    topBannerBt.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 25);
    topBannerBt.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    NSString * aStr = @"”骑“雪碧英雄车，赢王者荣耀皮肤";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(aStr.length-6,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]range:NSMakeRange(aStr.length-6,6)];

    [topBannerBt setAttributedTitle:str forState:UIControlStateNormal];

}


-(void)AMapView
{
    self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_titleview"]];
    UIButton *bt=[[UIButton alloc] init];
    [bt setBackgroundImage:[UIImage imageNamed:@"navigationbar_list_normal"] forState:UIControlStateNormal];
       [bt setBackgroundImage:[UIImage imageNamed:@"navigationbar_list_hl"] forState:UIControlStateHighlighted];
    bt.size = bt.currentBackgroundImage.size;
    [bt setContentMode:UIViewContentModeLeft];
    [bt addTarget:self action:@selector(leftViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    UIBarButtonItem *leftnegativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    leftnegativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems =[NSArray arrayWithObjects:leftnegativeSpacer,leftBar,nil];;
    
    UIBarButtonItem *item_one=[UIBarButtonItem itemWithImageName:@"search" highImageName:@"search_down" target:self action:@selector(searchViewOnClick)];
     UIBarButtonItem *item_two=[UIBarButtonItem itemWithImageName:@"notification" highImageName:@"notification_down" target:self action:@selector(notificationViewOnClick)];
    UIBarButtonItem *rightnegativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    rightnegativeSpacer.width = -15;
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:leftnegativeSpacer,item_two,item_one,nil];;

    
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.mapType=MAMapTypeStandard;
    mapView.language=MAMapLanguageZhCN;
    mapView.showsCompass=NO;
    mapView.showsScale=NO;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView=mapView;
    
    UIButton *refrenshBt=[[UIButton alloc] init];
    refrenshBt.x=10;
    refrenshBt.y=[UIScreen mainScreen].bounds.size.height-120-64+10;
    [refrenshBt setBackgroundImage:[UIImage imageNamed:@"main_refresh_bg_hl"] forState:UIControlStateNormal];
    [refrenshBt setBackgroundImage:[UIImage imageNamed:@"main_refresh_bg_hl"] forState:UIControlStateHighlighted];
    refrenshBt.size = refrenshBt.currentBackgroundImage.size;
    [refrenshBt addTarget:self action:@selector(refrenshBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refrenshBt];
    
    UIButton *locationBt=[[UIButton alloc] init];
    locationBt.x=10;
    locationBt.y=[UIScreen mainScreen].bounds.size.height-120-64+70;;
    [locationBt setBackgroundImage:[UIImage imageNamed:@"nav_orientation"] forState:UIControlStateNormal];
    [locationBt setBackgroundImage:[UIImage imageNamed:@"nav_orientation"] forState:UIControlStateHighlighted];
    locationBt.size = locationBt.currentBackgroundImage.size;
    [locationBt addTarget:self action:@selector(locationBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBt];
    
    UIButton *couponBt=[[UIButton alloc] init];
    couponBt.x=[UIScreen mainScreen].bounds.size.width-55;
    couponBt.y=[UIScreen mainScreen].bounds.size.height-120-64+10;
    [couponBt setBackgroundImage:[UIImage imageNamed:@"red-p-entrance"] forState:UIControlStateNormal];
    [couponBt setBackgroundImage:[UIImage imageNamed:@"red-p-entrance"] forState:UIControlStateHighlighted];
    couponBt.size = couponBt.currentBackgroundImage.size;
    [couponBt addTarget:self action:@selector(redPaperBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:couponBt];
    
    UIButton *serviceBt=[[UIButton alloc] init];
    serviceBt.x=[UIScreen mainScreen].bounds.size.width-55;
    serviceBt.y=[UIScreen mainScreen].bounds.size.height-120-64+70;
    [serviceBt setBackgroundImage:[UIImage imageNamed:@"main_help_normal"] forState:UIControlStateNormal];
    [serviceBt setBackgroundImage:[UIImage imageNamed:@"main_help_normal"] forState:UIControlStateHighlighted];
    serviceBt.size = serviceBt.currentBackgroundImage.size;
    [serviceBt addTarget:self action:@selector(customServiceBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceBt];
    
    UIButton *QRcodeBt=[[UIButton alloc] init];
    [QRcodeBt setBackgroundImage:[UIImage imageNamed:@"rq_code_icon"] forState:UIControlStateNormal];
    [QRcodeBt setBackgroundImage:[UIImage imageNamed:@"rq_code_icon_highlight"] forState:UIControlStateHighlighted];
    QRcodeBt.size = QRcodeBt.currentBackgroundImage.size;
    QRcodeBt.centerX=self.view.centerX;
    QRcodeBt.centerY=[UIScreen mainScreen].bounds.size.height-64-QRcodeBt.currentBackgroundImage.size.height/2;
    [QRcodeBt setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [QRcodeBt setImage:[UIImage imageNamed:@"seviceScan"] forState:UIControlStateNormal];
    QRcodeBt.titleLabel.font=[UIFont systemFontOfSize:13];
    [QRcodeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [QRcodeBt setTitle:@"扫码开锁" forState:UIControlStateNormal];
    UIImageView *animationIV=QRcodeBt.imageView;
    animationIV.animationImages=[NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"scanAnimation"],
                                 [UIImage imageNamed:@"seviceScan"],
                                 nil ];
    animationIV.animationDuration=0.5;
    animationIV.animationRepeatCount=0;
    [animationIV startAnimating];
    [QRcodeBt addTarget:self action:@selector(QRCodeBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QRcodeBt];
    
    
}



#pragma -mark-  底部按钮区域
-(void)refrenshBtOnClick
{
    NSLog(@"===refrenshBtOnClick====");
}


-(void)locationBtOnClick
{
    //定位服务
}

//我的红包
-(void)redPaperBtOnClick
{
    HBMyRedPaperController *myRedPaperVc=[[HBMyRedPaperController alloc] init];
    [self.navigationController pushViewController:myRedPaperVc animated:YES];
}




//客户服务
-(void)customServiceBtOnClick
{
    CustomServiceAlert *csAlert=[CustomServiceAlert dreamAlertViweWithTitle:@"" oneBtnTitle:@"" oneBlock:^{
        HBCarBadLockedController *csVc=[[HBCarBadLockedController alloc] init];
        [self.navigationController pushViewController:csVc animated:YES];
        
    } twoBtnTitle:@"" twoBlock:^{
        HBCarBadViewController *badCarVc=[[HBCarBadViewController alloc] init];
        [self.navigationController pushViewController:badCarVc animated:YES];
    } threeBtnTitle:@"" threeBlock:^{
        HBCarIllegallyParkController *parkVc=[[HBCarIllegallyParkController alloc] init];
        [self.navigationController pushViewController:parkVc animated:YES];
    } fourBtnTitle:@"" fourBlock:^{
        HBCarOtherQuestionController *carOtherVc=[[HBCarOtherQuestionController alloc] init];
        [self.navigationController pushViewController:carOtherVc animated:YES];
    }];
    [csAlert show];
}

//二维码识别
-(void)QRCodeBtOnClick
{
    HBQRCodeController *qrCodeVc=[[HBQRCodeController alloc] init];
    [self.navigationController pushViewController:qrCodeVc animated:YES];
}


#pragma -mark-  顶部按钮区域
//左侧搜索按钮
-(void)searchViewOnClick
{
    HBSearchViewController *searchVc=[[HBSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}
//左侧通知按钮
-(void)notificationViewOnClick
{
    HBMessageViewController *messageVc=[[HBMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVc animated:YES];
}
//左侧按钮
-(void)leftViewOnClick
{
    HBPersonManagerController *personManagerVc=[[HBPersonManagerController alloc] init ];
    [self.navigationController pushViewController:personManagerVc animated:YES];

}

//广告按钮
-(void)topBannerBtOnClick
{
    
    HBADDetailViewController *addetailVc=[[HBADDetailViewController alloc] init ];
    [self.navigationController pushViewController:addetailVc animated:YES];
}

#pragma -mark-  MAMapViewDelegate
/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}

/**
 * @brief 地图将要发生移动时调用此接口
 * @param mapView 地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{

}

/**
 * @brief 地图移动结束后调用此接口
 * @param mapView 地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{

}

/**
 * @brief 地图将要发生缩放时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
{

}

/**
 * @brief 地图缩放结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{

}

/**
 * @brief 单击地图底图调用此接口
 * @param mapView    地图View
 * @param coordinate 点击位置经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{

}

/**
 * @brief 长按地图底图调用此接口
 * @param mapView    地图View
 * @param coordinate 长按位置经纬度
 */
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{

}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    return nil;
}

/**
 * @brief 当mapView新添加annotation views时调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{

}

/**
 * @brief 当选中一个annotation views时调用此接口
 * @param mapView 地图View
 * @param view 选中的annotationView
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{

}

/**
 * @brief 当取消选中一个annotation views时调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotationView
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{

}

/**
 * @brief 标注view的accessory view(必须继承自UIControl)被点击时调用此接口
 * @param mapView 地图View
 * @param view callout所属的标注view
 * @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{

}

/**
 * @brief 标注view的calloutview整体点击时调用此接口
 * @param mapView 地图的view
 * @param view calloutView所属的annotationView
 */
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{

}

/**
 * @brief 在地图View将要启动定位时调用此接口
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{

}

/**
 * @brief 在地图View停止定位后调用此接口
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{

}

/**
 * @brief 位置或者设备方向更新后调用此接口
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{

}

/**
 * @brief 定位失败后调用此接口
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{

}

/**
 * @brief 当userTrackingMode改变时调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{

}

/**
 * @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 * @param mapView 地图View
 * @param view annotation view
 * @param newState 新状态
 * @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
 
}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    return  nil;
}

/**
 * @brief 当mapView新添加overlay renderer时调用此接口
 * @param mapView 地图View
 * @param renderers 新添加的overlay renderers
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers
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
