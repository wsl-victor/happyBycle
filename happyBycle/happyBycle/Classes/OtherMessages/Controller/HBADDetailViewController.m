//
//  HBADDetailViewController.m
//  happyBycle
//
//  Created by Stephen on 2017/6/2.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBADDetailViewController.h"
#import <WebKit/WebKit.h>

@interface HBADDetailViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *wkWebView;


@end

@implementation HBADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"摩拜单车";
    WKWebView *wkWebView=[[WKWebView alloc] initWithFrame:self.view.bounds];
    wkWebView.navigationDelegate=self;
    wkWebView.UIDelegate=self;
    [self.view addSubview:wkWebView];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mobike.com/cn/about"]];
    [wkWebView loadRequest:request];
    
}

#pragma -mark-  WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);

}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma -mark-  WKUIDelegate


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
