//
//  YXDetailViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/22.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXDetailViewController.h"
#import <WebKit/WebKit.h>

@interface YXDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;
@end

@implementation YXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 80)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bilibili.com"]]];
}

// MARK: - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {  // 是否加载请求
    decisionHandler(WKNavigationActionPolicyAllow);  // 允许加载
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {  // 加载成功
    NSLog(@"didFinishNavigation");
}

@end
