//
//  YXNormalTableViewCell.h
//  NewsApp
//
//  Created by Victor Wu on 2019/10/21.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 自己实现是一个Delegate，当点击删除按钮的时候去触发这个Delegate
@protocol YXNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;  // 告诉Delegate给的是哪个cell和哪个button

@end

@interface YXNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<YXNormalTableViewCellDelegate> delegate;  // 这里是weak类型！！！

- (void)layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
