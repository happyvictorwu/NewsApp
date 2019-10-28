//
//  YXListLoader.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/28.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXListLoader.h"

@implementation YXListLoader

- (void)loadListData {
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];

    NSLog(@"");
}

@end
