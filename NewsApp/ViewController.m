//
//  ViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/14.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "ViewController.h"

@interface TestView : UIView

@end

@implementation TestView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}

- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

@end

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

// MARK: - UITableViewDelegate代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  // 设置每个row的高度，即TableView的间距高度
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  // 通过indexPath来告诉tableView用户点的其中第几个行。每一个行中有cell(展示)
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];  // 不设置颜色跳转y界面的时候会卡顿
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
}

// MARK: - UITableViewDataSource代理方法
// 返回整个tableview有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// cell长成什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];  // 使用复用回收机制，在tableview的回收池中能不能找到这个相同id的cell（相同id的样式是一样的）

    if (!cell) {  // 若没有cell,创建一个新的cell。
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }

    // 若系统回收池取到了，就用回收的cell展示就行
    // 系统提供样式的属性
    cell.textLabel.text = [NSString stringWithFormat:@"主标题 - %@", @(indexPath.row)];  // 只有一个Section？ 指定row就可以了
    cell.detailTextLabel.text = @"副标题";
    cell.imageView.image = [UIImage imageNamed:@"video"];
    return cell;
}

@end
