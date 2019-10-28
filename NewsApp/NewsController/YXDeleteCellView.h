//
//  YXDeleteCellView.h
//  NewsApp
//
//  Created by Victor Wu on 2019/10/22.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Delete View on the screen (a floating layer)
@interface YXDeleteCellView : UIView

/// Appear animated floating layer when click deleteCell.
/// @param point the position of click.
/// @param clickBlock callback: when finish click, and do sonething.
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
