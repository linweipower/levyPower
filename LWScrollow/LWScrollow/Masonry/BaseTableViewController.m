//
//  BaseTableViewController.m
//  尝试嵌套多层scrollview
//
//  Created by 1 on 16/3/29.
//  Copyright © 2016年 com.power.linwei. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
 
    self.view.backgroundColor = [UIColor greenColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        self.tableView.scrollEnabled = NO;
    }
}

@end
