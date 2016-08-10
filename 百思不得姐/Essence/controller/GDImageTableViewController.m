//
//  GDImageTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDImageTableViewController.h"

@implementation GDImageTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadNewTopics
{
    self.urlParameters = @{@"a":@"list", @"c":@"data",@"type":@pictureType};
    
    [super loadNewTopics];
}

- (void)loadMoreTopics
{
    
    self.urlParameters = self.maxid != nil ? @{@"a":@"list", @"c":@"data",@"type":@pictureType,@"maxid":self.maxid}: @{@"a":@"list", @"c":@"data",@"type":@pictureType};
    
    [super loadMoreTopics];
}
@end
