//
//  HBMyRedPaperController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMyRedPaperController.h"

#import "HBRedPaperDetailController.h"
#import "HBRedPaperQuestionController.h"
#import "HBRedPaperStategyController.h"
@interface HBMyRedPaperController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabelDes;

@property (weak, nonatomic) IBOutlet UIButton *redpaperBt;
@property (weak, nonatomic) IBOutlet UIButton *outMonetyBt;

@property (weak, nonatomic) IBOutlet UIButton *questionBt;

@end

@implementation HBMyRedPaperController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的红包";
    
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont systemFontOfSize:14];
    [bt setTitle:@"红包明细" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(redpaperDetailBtViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    
    self.navigationItem.rightBarButtonItem =leftBar;
}



#pragma -mark- 问题
//红包明细
-(void)redpaperDetailBtViewOnClick{
    HBRedPaperDetailController *detailVc=[[HBRedPaperDetailController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}
//攻略
- (IBAction)redpaperBtOnClick:(UIButton *)sender {
    HBRedPaperStategyController *stategyVc=[[HBRedPaperStategyController alloc] init];
    [self.navigationController pushViewController:stategyVc animated:YES];
}
//提现
- (IBAction)outMoneyBtOnClick:(UIButton *)sender {
   // HBRedPaperDetailController *detailVc=[[HBRedPaperDetailController alloc] init];
   // [self.navigationController pushViewController:detailVc animated:YES];
}
//问题
- (IBAction)questionBtOnClick:(UIButton *)sender {
    HBRedPaperQuestionController *questionVc=[[HBRedPaperQuestionController alloc] init];
    [self.navigationController pushViewController:questionVc animated:YES];
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
