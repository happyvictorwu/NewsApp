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

- (void)loadListDataWithFinishBlock:(YXListLoaderFinishBlock)finishBlock {
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        NSError *jsonError;
        // 把NSdata(JSON文件的二进制流)转换成Dictionary
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

# warning Unsafe - jsonObj may not dictionary (result and data is the same), objectforkey may not a dictionary
        NSArray *dataArray = [(NSDictionary *)[(NSDictionary *)jsonObj objectForKey:@"result"] objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {   // warning: - Unsafe info也有可能不是NSDictionary
            YXListItem *listItem = [[YXListItem alloc] init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }

        //???: 以后弄懂为什么要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
                           if (finishBlock) {
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];

    [dataTask resume];

    [self _getSandBoxPath];
}

- (void)_getSandBoxPath {
    __unused NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"");
}

@end
