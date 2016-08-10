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
}
- (void)loadNewTopics
{
    self.urlParameters = @{@"a":@"list", @"c":@"data",@"type":@videoType};
    
    [super loadNewTopics];
}

- (void)loadMoreTopics
{
    
    self.urlParameters = self.maxid != nil ? @{@"a":@"list", @"c":@"data",@"type":@videoType,@"maxid":self.maxid}: @{@"a":@"list", @"c":@"data",@"type":@videoType};
    
    [super loadMoreTopics];
}

@end
