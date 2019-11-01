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
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    // fileManager是一个单例。 用于创建文件、删除文件、查询文件、移动和复制等等。根据用户给出的路径操作
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"YXData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];  // 创建一个文件夹根据dataPath

    // 创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];      // 使用utf8编码字符串，变成一个二进制文件。计算机是以二进制存储的
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];      // 在给定路径创建文件，内容contents为listData(字符abc)

    // 查询文件
    __unused BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];  // 判断listDataPath是否存在

    // 删除
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }

    NSLog(@"");

    // -------- NSFileHandle

    // 单例。 读/写/截断/刷新/追加数据等等。常用于追加数据。 以下对listDataPath的这个文件创造了一个NSFileHandle对其进行操作
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];

    // 对文件数据追加操作
    [fileHandler seekToEndOfFile];  // 把offset调到文件末尾，因为要在文件末尾追加数据
    [fileHandler writeData:[@"--append: def" dataUsingEncoding:NSUTF8StringEncoding]];  // 使用utf8编码字符串写在offset后面

    [fileHandler synchronizeFile];  // 刷新文件 对实时要求高就刷新
    [fileHandler closeFile];  // 关闭文件操作。不关系统结束才关，但是最好每次使用完就关

    NSLog(@"");
}

@end
