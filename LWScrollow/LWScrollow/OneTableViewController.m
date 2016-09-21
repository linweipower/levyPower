//
//  OneTableViewController.m
//  尝试嵌套多层scrollview
//
//  Created by 1 on 16/3/24.
//  Copyright © 2016年 com.power.linwei. All rights reserved.
//

#import "OneTableViewController.h"

@interface OneTableViewController ()

@end

@implementation OneTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
    self.tableView.scrollEnabled = NO;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"one";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

@end
