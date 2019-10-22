//
//  ViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/14.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "ViewController.h"
#import "YXNormalTableViewCell.h"
#import "YXDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

// MARK: - UITableViewDelegate代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  // 设置每个row的高度，即TableView的间距高度
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  // 通过indexPath来告诉tableView用户点的其中第几个行。每一个行中有cell(展示)
    YXDetailViewController *controller = [[YXDetailViewController alloc] init];
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
}

// UITableViewDelegate父Delegate UIScrollViewDelegate的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll - 用户正在使用手势拖拽");
}

// MARK: - UITableViewDataSource代理方法
// 返回整个tableview有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// cell长成什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];  // 使用复用回收机制，在tableview的回收池中能不能找到这个相同id的cell（相同id的样式是一样的）

    if (!cell) {  // 若没有cell,创建一个新的cell。
        cell = [[YXNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }

    [cell layoutTableViewCell];

    return cell;
}

@end
