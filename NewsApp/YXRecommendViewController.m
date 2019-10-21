//
//  YXRecommendViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/21.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXRecommendViewController.h"

@interface YXRecommendViewController ()

@end

@implementation YXRecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"like"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"like_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;   // scrollView属性：设置水平滚动条不显示
    
    NSArray *colorArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor lightGrayColor], [UIColor grayColor]];
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            view.backgroundColor = [colorArray objectAtIndex:i];
            view;
        })];
    }
    scrollView.pagingEnabled = YES;   // scrollView属性：滑动超过半个屏幕就有翻页效果
    
    [self.view addSubview:scrollView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
