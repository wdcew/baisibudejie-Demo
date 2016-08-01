//
//  GDWholeTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDWholeTableViewController.h"
@interface GDWholeTableViewController ()

@property (nonatomic, strong)NSMutableArray<GDTopic *> *topics;
@property (nonatomic, strong)GDArrayDataSource *dataSource;
@end

@implementation GDWholeTableViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [GDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupTableView
{
    UINib *nib = [UINib nibWithNibName:@"GDTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
}

- (void)loadNewTopics
{
   AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    
    NSDictionary *paraDict = @{@"a":@"list", @"c":@"data"};
    
    [manger GET:url
     parameters:paraDict
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.topics addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GDTopic class] json:responseObject[@"list"]]];
            [self setupDataSource];
            [self.tableView.mj_header endRefreshing];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            GDNSLog(@"LoadNewTopicsGetError:%@",error);
        }];
}

- (void)setupDataSource
{
    GDArrayDataSource *dataSource = [[GDArrayDataSource alloc]
                                     initWithItmes:self.topics
                                     executeBlock:^(GDTableViewCell *cell, GDTopic *item) {
                                         cell.label.text = item.text;
                                         [cell imageWithUrlStr:item.profile_image];
                                     }
                                     ReuseIdentifier:@"cell"];
    self.dataSource = dataSource;
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

#pragma maek UItableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section  == 0) {
    UITableViewHeaderFooterView * view = [self.tableView headerViewForSection:section];
    view.contentView.backgroundColor = [UIColor redColor];
    }
    return GDcellMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
@end
