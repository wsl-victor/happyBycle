//
//  HBMessageDetailController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/25.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMessageDetailController.h"

@interface HBMessageDetailController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HBMessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"摩拜单车";
    
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [bt setImage:[UIImage imageNamed:@"share_ios"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"share_ios_down"] forState:UIControlStateHighlighted];
    [bt addTarget:self action:@selector(shareBtViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    
    self.navigationItem.rightBarButtonItem =leftBar;
    // Do any additional setup after loading the view from its nib.
}


-(void)shareBtViewOnClick
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
