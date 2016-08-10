//
//  GDTextTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTextTableViewController.h"

@implementation GDTextTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadNewTopics
{
    self.urlParameters = @{@"a":@"list", @"c":@"data",@"type":@textType};
    
    [super loadNewTopics];
}

- (void)loadMoreTopics
{
    
    self.urlParameters = self.maxid != nil ? @{@"a":@"list", @"c":@"data",@"type":@textType,@"maxid":self.maxid}: @{@"a":@"list", @"c":@"data",@"type":@textType};
    
    [super loadMoreTopics];
}
@end
