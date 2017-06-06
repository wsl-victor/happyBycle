//
//  HBPersonManagerController.m
//  happyBycle
//
//  Created by victor on 2017/5/18.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBPersonManagerController.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "XBSettingCell.h"
#import "HBPersonHeaderView.h"


//我的钱包
#import "HBMyMoneyController.h"
//我的优惠
#import "HBMyCouponController.h"
//我的行程
#import "HBMyRouteController.h"
//我的消息
#import "HBMessageViewController.h"
//邀请好友
#import "HBInviteFridendsController.h"
//用户指南
#import "HBUserGuideController.h"
//设置
#import "HBSettingController.h"

@interface HBPersonManagerController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *personManagerView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation HBPersonManagerController
- (NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}




-(void)setSectionData
{
    //************************************section1
    XBSettingItemModel *item1 = [[XBSettingItemModel alloc]init];
    item1.funcName = @"我的钱包";
    item1.executeCode = ^{
        HBMyMoneyController *moneyVc=[[HBMyMoneyController alloc] init];
        [self.navigationController pushViewController:moneyVc animated:YES];
    };
    // item1.img = [UIImage imageNamed:@"icon-list01"];
    item1.detailText = @"2.6";
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"我的优惠";
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item2.executeCode = ^{
        HBMyCouponController *moneyVc=[[HBMyCouponController alloc] init];
        [self.navigationController pushViewController:moneyVc animated:YES];
    };
    
    
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"我的行程";
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item3.executeCode = ^{
        HBMyRouteController *moneyVc=[[HBMyRouteController alloc] init];
        [self.navigationController pushViewController:moneyVc animated:YES];
    };
    
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 1;
    section1.itemArray = @[item1,item2,item3];
    
    

    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"我的消息";
    item5.executeCode = ^{
        HBMessageViewController *messageVc=[[HBMessageViewController alloc] init];
        [self.navigationController pushViewController:messageVc animated:YES];
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"邀请好友";
    item6.executeCode = ^{
        HBInviteFridendsController *inviteFriendVc=[[HBInviteFridendsController alloc] init];
        [self.navigationController pushViewController:inviteFriendVc animated:YES];
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"用户指南";
    item7.executeCode = ^{
        HBUserGuideController *moneyVc=[[HBUserGuideController alloc] init];
        [self.navigationController pushViewController:moneyVc animated:YES];
    };
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item8 = [[XBSettingItemModel alloc]init];
    item8.funcName = @"设置";
    item8.executeCode = ^{
        HBSettingController *moneyVc=[[HBSettingController alloc] init];
        [self.navigationController pushViewController:moneyVc animated:YES];
    };
    item8.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 5;
    section2.itemArray = @[item5,item6,item7,item8];
    
    [self.sectionArray addObject:section1];
    [self.sectionArray addObject:section2];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人中心";
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    [self setSectionData];
    [self setTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}




-(void)setTableView
{
    self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"HBPersonHeaderView" owner:nil options:nil] firstObject];
    
    UITableView *personManagerView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    personManagerView.backgroundColor=[UIColor clearColor];
    personManagerView.separatorStyle = UITableViewCellSeparatorStyleNone;

    personManagerView.dataSource=self;
    personManagerView.delegate=self;
    
    [self.view addSubview:personManagerView ];
    [personManagerView beginUpdates];
    [personManagerView setTableHeaderView:self.headerView];// 关键是这句话
    [personManagerView endUpdates];

    self.personManagerView=personManagerView;
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200 )];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.image = [UIImage imageNamed:@"common_bgbg"];
    self.headImageView = headImageView;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backGroundView addSubview:headImageView];
    
    personManagerView.backgroundView = backGroundView;
    
}

#pragma mark - 设置滚动放大和缩小
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 向下滚动offsetY值变为负值，越来越小，向上滚动offsetY值是正值，越来越大
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect tempF = self.headImageView.frame;
    // 如果offsetY大于0，说明是向上滚动，缩小
    if (offsetY > 0) {
        tempF.origin.y = -offsetY;
        self.headImageView.frame = tempF;
      //  [self.navigationController.navigationBar changeNavAlphaWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:1.0]];
        self.navigationItem.title=@"个人中心";
    }else{
        // 如果offsetY小于0，让headImageView的Y值等于0，headImageView的高度要放大
        tempF.size.height = 200 - offsetY;
        tempF.origin.y = 0;
        self.headImageView.frame = tempF;
       // [self.navigationController.navigationBar changeNavAlphaWithColor:[UIColor colorWithRed:0.0 green:1.0 blue:0 alpha:1.0]];
        self.navigationItem.title=@"摩拜单车";
        
    }
    
}



#pragma -mark- UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return  self.sectionArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"setting";
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    XBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XBSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = itemModel;
    return cell;

}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
    
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
