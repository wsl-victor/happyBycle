//
//  HBMyRouteController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMyRouteController.h"
#import "HBMyRouteViewCell.h"
#import "HBMyRouteQuestionController.h"
#import "HBMyRouteDetailViewController.h"
@interface HBMyRouteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *routeTableView;

@end

@implementation HBMyRouteController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title=@"我的行程";
    UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont systemFontOfSize:14];
    [bt setTitle:@"需要帮助？" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(routeHelpBtViewOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    
    self.navigationItem.rightBarButtonItem =leftBar;
    [self setInitView];
    // Do any additional setup after loading the view.
}

-(void)setInitView
{
    UITableView *routeTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width   , [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];

    
    routeTableView.dataSource=self;
    routeTableView.delegate=self;
    routeTableView.rowHeight=75;
    routeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    routeTableView.separatorStyle = NO;
    
    [self.view addSubview:routeTableView];
    self.routeTableView=routeTableView;
    
}
//需要帮助
-(void)routeHelpBtViewOnClick
{
    HBMyRouteQuestionController *myRouteQVc=[[HBMyRouteQuestionController alloc] init];
    [self.navigationController pushViewController:myRouteQVc animated:YES];
}


#pragma -mark-

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBMyRouteViewCell *cell=[HBMyRouteViewCell cellWithTableView:tableView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBMyRouteDetailViewController *routeDetailVc=[[HBMyRouteDetailViewController alloc] init];
    [self.navigationController pushViewController:routeDetailVc animated:YES];
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
