//
//  HBMyRouteQuestionController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/26.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMyRouteQuestionController.h"
#import "HBMyRouteQuestionCell.h"
#import "HBMyRouteQuestionDetailController.h"
@interface HBMyRouteQuestionController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *routeQuestionTableView;

@end



@implementation HBMyRouteQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    self.navigationItem.title=@"客户服务";
    [self setInitView];
    
}

-(void)setInitView
{
    UITableView *routeQuestionTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width   , [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStyleGrouped];

    routeQuestionTableView.dataSource=self;
    routeQuestionTableView.delegate=self;
    routeQuestionTableView.rowHeight=60;
    routeQuestionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    routeQuestionTableView.separatorStyle = NO;
    
    [self.view addSubview:routeQuestionTableView];
    self.routeQuestionTableView=routeQuestionTableView;
    
}

#pragma -mark-

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBMyRouteQuestionCell *cell=[HBMyRouteQuestionCell cellWithTableView:tableView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    label.textColor=[UIColor lightGrayColor];
    label.font=[UIFont systemFontOfSize:12];
    label.text=@"       您对哪段行程有问题?";
    return label;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBMyRouteQuestionDetailController *routeQDvc=[[HBMyRouteQuestionDetailController alloc] init];
    [self.navigationController pushViewController:routeQDvc animated:YES];
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
