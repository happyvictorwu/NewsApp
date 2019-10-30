//
//  YXDeleteCellView.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/22.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXDeleteCellView.h"

@interface YXDeleteCellView ()

@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, strong, readwrite) UIButton *deleteButton;
@property (nonatomic, copy, readwrite) dispatch_block_t deleteBlock;  // why copy

@end

@implementation YXDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            [_backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
                tapGesture;
            })];
            _backgroundView;
        })];

        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];  // At the beginning the width and height of botton is 0 and then do animation
            [_deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
    }
    return self;
}

- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock {
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);  // origin position
    _deleteBlock = [clickBlock copy];  // just like save the copy of code. when it can called anywhere

    UIWindow *keyWindow = [self findKeyWindow];  // [[UIApplication sharedApplication].keyWindow addSubview:self];  // iOS13废弃了.keyWindow属性
    if (!keyWindow) {
        NSLog(@"victor - no found keyWindow");
        return;
    }
    [keyWindow addSubview:self];

//    //Assume deleteButton size is 0 * 0 at the beginning. from left-top to middle of screen. the speed is the same.
//    [UIView animateWithDuration:1.f animations:^{
//        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200) / 2, (self.bounds.size.height - 200) / 2, 200, 200);
//    }];

    // Assume deleteButton size is 0 * 0 at the beginning.from left-top to middle. the options:UIViewAnimationOptionCurveEaseInOut that would be quick first and slowly gradually.
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200) / 2, (self.bounds.size.height - 200) / 2, 200, 200);
    } completion:^(BOOL finished) {
        NSLog(@"");  // finish animation and do something
    }];
}

- (void)dismissDeleteView {
    [self removeFromSuperview];
}

- (void)_clickButton {
    if (_deleteBlock) {
        _deleteBlock();  // do the block when send to here
    }
    [self removeFromSuperview];
}

# warning Victor - the method should be global sharing to all method
// iOS 13 is deprecated keyWindow, so use this method to find the keyWindows
- (UIWindow *)findKeyWindow {
    UIWindow *foundWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    return foundWindow;
}

@end
