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
@property (nonatomic, strong, readwrite) UIProgressView *progressView;  // 添加一个进度条
@end

@implementation YXDetailViewController

- (void)dealloc {
    // 在观察者self自己销毁的时候要移除监听
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 80)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];

    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 20)];
        self.progressView;
    })];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bilibili.com"]]];

    // webView添加一个观察者（self）监听webView的estimatedProgress属性的新变化
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// MARK: - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {  // 是否加载请求
    decisionHandler(WKNavigationActionPolicyAllow);  // 允许加载
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {  // 加载成功
    NSLog(@"didFinishNavigation");
}

// 监听webView的回调
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
    NSLog(@"");
}

@end
