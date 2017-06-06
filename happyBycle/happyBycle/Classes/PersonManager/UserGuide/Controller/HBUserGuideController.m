//
//  HBUserGuideController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBUserGuideController.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "XBSettingCell.h"
#import "HBCarBadLockedController.h"
#import "HBCarBadViewController.h"
#import "HBCarIllegallyParkController.h"
//用户指南
@interface HBUserGuideController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *userGuideTableView;


@property (nonatomic, strong) NSMutableArray *sectionArray;




@end

@implementation HBUserGuideController
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
    item1.funcName = @"开不了锁";
    item1.executeCode = ^{
        HBCarBadLockedController *csVc=[[HBCarBadLockedController alloc] init];
        [self.navigationController pushViewController:csVc animated:YES];
    };
    // item1.img = [UIImage imageNamed:@"icon-list01"];
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"发现车辆故障";
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item2.executeCode = ^{
        HBCarBadViewController *badCarVc=[[HBCarBadViewController alloc] init];
        [self.navigationController pushViewController:badCarVc animated:YES];
    };
    
    
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"押金说明";
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item3.executeCode = ^{
       
    };
    
    

    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"充值说明";
    item5.executeCode = ^{
     
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"举报违停";
    item6.executeCode = ^{
        HBCarIllegallyParkController *parkVc=[[HBCarIllegallyParkController alloc] init];
        [self.navigationController pushViewController:parkVc animated:YES];
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"找不到车";
    item7.executeCode = ^{
      
    };
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 44;
    section1.itemArray = @[item1,item2,item3,item5,item6,item7];
    
    
    
    XBSettingItemModel *item8 = [[XBSettingItemModel alloc]init];
    item8.funcName = @"全部问题";
    item8.executeCode = ^{
   
    };
    item8.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 5;
    section2.itemArray = @[item8];
    
    [self.sectionArray addObject:section1];
    [self.sectionArray addObject:section2];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"用户指南";
    // Do any additional setup after loading the view.
    [self setSectionData];
    [self setTableView];
}



-(void)setTableView
{

    UITableView *userGuideTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    userGuideTableView.backgroundColor=[UIColor clearColor];
    userGuideTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    userGuideTableView.dataSource=self;
    userGuideTableView.delegate=self;
    
    [self.view addSubview:userGuideTableView ];
   
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



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 34)];
        label.textColor=[UIColor lightGrayColor];
        label.font=[UIFont systemFontOfSize:12];
        label.text=@"热点问题";
        [view addSubview:label];
        return view;

    }else{
        return nil;
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
