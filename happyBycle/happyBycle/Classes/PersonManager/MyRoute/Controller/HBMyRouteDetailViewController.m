//
//  HBMyRouteDetailViewController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/26.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMyRouteDetailViewController.h"

@interface HBMyRouteDetailViewController ()

@end

@implementation HBMyRouteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"行程详情";
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"share_ios"] forState:UIControlStateNormal];
     [bt setImage:[UIImage imageNamed:@"share_ios_down"] forState:UIControlStateHighlighted];
    [bt addTarget:self action:@selector(shareRouteBtViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    
    self.navigationItem.rightBarButtonItem =leftBar;
    // Do any additional setup after loading the view from its nib.
}


-(void)shareRouteBtViewOnClick
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
