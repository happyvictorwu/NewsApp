//
//  YXNewsViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/14.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXNewsViewController.h"
#import "YXNormalTableViewCell.h"
#import "YXDetailViewController.h"
#import "YXDeleteCellView.h"
#import "YXListLoader.h"
#import "YXListItem.h"

@interface YXNewsViewController ()<UITableViewDataSource, UITableViewDelegate, YXNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray;  // irregular
@property (nonatomic, strong, readwrite) YXListLoader *listLoader;
@end

@implementation YXNewsViewController

// MARK: - life cycle
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

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    self.listLoader = [[YXListLoader alloc] init];
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<YXListItem *> *_Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        NSLog(@"");
    }];
}

// MARK: - UITableViewDelegate
// 设置每个row的高度，即TableView的间距高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// 通过indexPath来告诉tableView用户点的其中第几个行。每一个行中有cell(展示)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YXListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    YXDetailViewController *controller = [[YXDetailViewController alloc] initWithUrlString:item.articleUrl];
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
    return _dataArray.count;
}

// cell长成什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用复用回收机制，在tableview的回收池中能不能找到这个相同id的cell（相同id的样式是一样的）
    YXNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];

    if (!cell) {  // 若没有cell,创建一个新的cell。
        cell = [[YXNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }

    // row与数组的编号是对应的，从第0到第n-1
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];

    return cell;
}

// MARK: - 实现自定义的YXNormalTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//    NSLog(@"代理方法 - 点击了删除按钮");
//    YXDeleteCellView *deleteView = [[YXDeleteCellView alloc] initWithFrame:self.view.bounds];
//
//    // convert relative position to absolute position of screen
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    __weak typeof(self) wself = self;
//    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//        __strong typeof(wself) strongSelf = wself;
//
//        // Because of independent of array elements, so any element can be deleted. the most important thing is number.
//        [strongSelf.dataArray removeLastObject];
//
//        // System offer the method to delete the specific cell from the UITableView
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
}

@end
