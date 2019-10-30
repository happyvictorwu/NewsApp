//
//  YXListLoader.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/28.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXListLoader.h"
#import <AFNetworking.h>
#import "YXListItem.h"

@implementation YXListLoader

- (void)loadListData {
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil progress:^(NSProgress *_Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
//        NSLog(@"");
//    }];

    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];  // change to NSdata to Dictionary

# warning jsonObj may not dictionary (result and data is the same), objectforkey may not a dictionary
        NSArray *dataArray = [(NSDictionary *)[(NSDictionary *)jsonObj objectForKey:@"result"] objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            YXListItem *listItem = [[YXListItem alloc] init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }

        NSLog(@"");
    }];

    [dataTask resume];

    NSLog(@"");
}

@end
