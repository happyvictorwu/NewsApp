//
//  YXNormalTableViewCell.h
//  NewsApp
//
//  Created by Victor Wu on 2019/10/21.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXListItem;

NS_ASSUME_NONNULL_BEGIN

/// 点击删除按钮
@protocol YXNormalTableViewCellDelegate <NSObject>    // 自己实现是一个Delegate，当点击删除按钮的时候去触发这个Delegate
// 告诉Delegate给的是哪个cell和哪个button
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;
@end

/// 新闻列表Cell
@interface YXNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<YXNormalTableViewCellDelegate> delegate;  // 这里是weak类型！！！

/// 根据参数item来渲染Cell
/// @param item 结构化的JSON数据
- (void)layoutTableViewCellWithItem:(YXListItem *)item;

@end

NS_ASSUME_NONNULL_END
