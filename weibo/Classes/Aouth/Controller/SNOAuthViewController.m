//
//  SNOAuthViewController.m
//  weibo
//
//  Created by admin on 16/2/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SNOAuthViewController.h"
#import "MBProgressHUD+MJ.h"

#import "SNAccount.h"
#import "SNAccountTool.h"
#import "SNControllerTool.h"
#import "SNHttpTool.h"

@interface SNOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SNOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    
    
    // https://api.weibo.com/oauth2/authorize?client_id=2258354537&redirect_uri=www.hao123.com
    //    code=2530de6ce96bc15974cca957bfef92ad
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", SNAppkey, SNRedirectURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

// 每当发送一个请求之前都会调用这个方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = request.URL.absoluteString;
    
//    SNLog(@"%@", url);
    
    NSString *str = [NSString stringWithFormat:@"%@/?code=", SNRedirectURL];
    NSRange range = [url rangeOfString:str];
//    range.location = 0;
//    range.length > 0;
    if (range.location != NSNotFound) {
        
        int from = (int)range.location + (int)range.length;
        
        NSString *code = [url substringFromIndex:from];
//        SNLog(@"%@", code);
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    
    params[@"client_id"] = SNAppkey;
    params[@"client_secret"] = SNAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = SNRedirectURL;
    
    
    [SNHttpTool post:url params:params success:^(id resposnseObj) {
        SNAccount *account = [SNAccount accountWithDic:resposnseObj];
        // 存储账号模型
        [SNAccountTool save:account];
        
        [SNControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        ;
    }];

}


@end
