//
//  GDVoiceTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDVoiceTableViewController.h"

@implementation GDVoiceTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadNewTopics
{
    self.urlParameters = @{@"a":@"list", @"c":@"data",@"type":@voiceType};
    
    [super loadNewTopics];
}

- (void)loadMoreTopics
{
    
    self.urlParameters = self.maxid != nil ? @{@"a":@"list", @"c":@"data",@"type":@voiceType,@"maxid":self.maxid}: @{@"a":@"list", @"c":@"data",@"type":@voiceType};
    
    [super loadMoreTopics];
}

@end
