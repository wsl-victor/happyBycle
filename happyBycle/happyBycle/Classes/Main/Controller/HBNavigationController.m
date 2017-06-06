//
//  HBNavigationController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/18.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()

@end

@implementation HBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


+ (void)initialize
{
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置导航栏背景
   
    [appearance setBackgroundImage:[UIImage imageNamed:@"common_black"] forBarMetrics:UIBarMetricsDefault];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //UITextAttributeTextColor
    textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs];
    
    
   // [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //UITextAttributeTextColor
    highTextAttrs[NSForegroundColorAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    [appearance setBackgroundImage:[UIImage imageNamed:@"common_black"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *bt=[[UIButton alloc] init];
        [bt setBackgroundImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        bt.size = bt.currentBackgroundImage.size;
        [bt setContentMode:UIViewContentModeLeft];
        [bt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -15;
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItems =[NSArray arrayWithObjects:negativeSpacer,rightBar,nil];
        
    }
    [super pushViewController:viewController animated:animated];
}

#pragma -mark-  导航栏左右方法
- (void)back
{
    [self popViewControllerAnimated:YES];
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
