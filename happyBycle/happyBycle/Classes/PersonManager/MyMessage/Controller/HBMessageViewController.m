//
//  HBMessageViewController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/18.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMessageViewController.h"
#import "HBMessageViewCell.h"
#import "HBMessageDetailController.h"
@interface HBMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *messageTableView;

@end

@implementation HBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        self.navigationItem.title=@"我的消息";
    [self setInitView];
}


-(void)setInitView
{
    UITableView *messageTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width   , [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    messageTableView.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];

    messageTableView.dataSource=self;
    messageTableView.delegate=self;
    messageTableView.rowHeight=195;
    messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTableView.separatorStyle = NO;
   
    [self.view addSubview:messageTableView];
    self.messageTableView=messageTableView;
    
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
    HBMessageViewCell *cell=[HBMessageViewCell cellWithTableView:tableView];
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBMessageDetailController *messageDetailVc=[[HBMessageDetailController alloc] init];
    [self.navigationController pushViewController:messageDetailVc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
