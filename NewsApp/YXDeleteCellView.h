//
//  YXDeleteCellView.h
//  NewsApp
//
//  Created by Victor Wu on 2019/10/22.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXDeleteCellView : UIView

// clickBlock: is callback
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
