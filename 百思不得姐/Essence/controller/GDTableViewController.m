//
//  GDTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTableViewController.h"

@implementation GDTableViewController

-(void)viewDidLoad
{
    self.view.backgroundColor = GDColor(206, 206, 206);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarInset + 30, 0, tabBarInset, 0);
    
//    UINib *nib = [UINib nibWithNibName:@"GDTableViewCell" bundle:[NSBundle mainBundle]];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

#pragma mark TableviewDatasource Delegate
@end
