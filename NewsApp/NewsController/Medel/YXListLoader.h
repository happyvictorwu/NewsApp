//
//  YXListLoader.h
//  NewsApp
//
//  Created by Victor Wu on 2019/10/28.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXListItem;    // 声名使用，声名会用到。在具体使用的时候才引入头文件.h。这样减少不必要的引用。

NS_ASSUME_NONNULL_BEGIN

typedef void (^YXListLoaderFinishBlock)(BOOL success, NSArray<YXListItem *> *dataArray);

/// 列表请求
@interface YXListLoader : UIView

- (void)loadListDataWithFinishBlock:(YXListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
