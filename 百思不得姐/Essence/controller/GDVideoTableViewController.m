//
//  GDVideoTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDVideoTableViewController.h"

@implementation GDVideoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    [self.tableView.mj_header beginRefreshing];
}

@end
