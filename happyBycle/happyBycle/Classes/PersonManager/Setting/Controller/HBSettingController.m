//
//  HBSettingController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBSettingController.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "XBSettingCell.h"
@interface HBSettingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *userGuideTableView;


@property (nonatomic, strong) NSMutableArray *sectionArray;



@end

@implementation HBSettingController
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
    item1.funcName = @"常用地址";
    item1.executeCode = ^{

    };
    // item1.img = [UIImage imageNamed:@"icon-list01"];
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"清理缓存";
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item2.executeCode = ^{
      
    };
    
    
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"关于我们";
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    item3.executeCode = ^{
        
    };
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 1;
    section1.itemArray = @[item1,item2,item3];
    
    
    
    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"用户协议";
    item5.executeCode = ^{
        
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"押金说明";
    item6.executeCode = ^{
        
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"充值协议";
    item7.executeCode = ^{
        
    };
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
   
    
 
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 5;
    section2.itemArray = @[item5,item6,item7];
    
    [self.sectionArray addObject:section1];
    [self.sectionArray addObject:section2];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
     self.navigationItem.title=@"设置";
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) return 0;
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) return nil;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIButton *loginOutBt=[[UIButton alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width-20, 60)];
    loginOutBt.backgroundColor=[UIColor redColor];
    loginOutBt.titleLabel.font=[UIFont systemFontOfSize:14];
    [loginOutBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginOutBt setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBt addTarget:self action:@selector(loginOutOnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginOutBt];
    return view;
}

-(void)loginOutOnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
