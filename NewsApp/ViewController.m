//
//  ViewController.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/14.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(100, 100, 100, 100); // frame是相对于父视图的位置
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    view2.frame = CGRectMake(150, 150, 100, 100);
    
    // view2 在 view的上面，因为是栈结构。 逐渐压栈，显示的是栈顶的View
    [self.view addSubview:view];
    [self.view addSubview:view2];
}


@end
