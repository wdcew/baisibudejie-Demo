//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDWholeTableViewController.h"
@interface GDWholeTableViewController ()

@property (nonatomic, strong)NSMutableArray<GDTopic *> *topics;
@property (nonatomic, strong)GDArrayDataSource *dataSource;
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;

//第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容
@property (nonatomic, strong)NSString *maxid;
@end

@implementation GDWholeTableViewController

#pragma mark lazy load
- (NSMutableArray<GDTopic *> *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

#pragma mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
}

#pragma mark setup mtohd
- (void)setupRefresh
{
    //添加下拉控件（用于获取最新数据）
    self.tableView.mj_header = [GDRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    //添加上拉控件 （用于获取更多数据）
    self.tableView.mj_footer = [GDRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)setupTableView
{
    [self.tableView registerClass:[GDTopicCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorInset = UIEdgeInsetsMake(5, 0, 5, 0);
    self.tableView.delegate = self;
}


#pragma mark HTTP Request method
/**
 *  获取最新数据，并且之前相关的数据被删除
 */
- (void)loadNewTopics
{
    //取消之前所有在 session中的所有task（主要应用在 下拉（或上拉）后，之前上拉（或下拉）操作所产出的上拉网络请求，应当立即取消，因为已经不需要 上拉请求的网络数据以及获得数据后的后续操作了）
    [[self.sessionManager tasks] makeObjectsPerformSelector:@selector(cancel)];
    
    //不推荐，不仅会使task取消，还会使session 无效后，不能再使用。
//    [self.sessionManager.session invalidateAndCancel];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSDictionary *paraDict = @{@"a":@"list", @"c":@"data"};
    
    [self.sessionManager GET:url
     parameters:paraDict
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //存储本次数据的maxid
            self.maxid = responseObject[@"info"][@"maxid"];
            //字典数据->模型（下拉加载最新数据）
                //.清空之前的数据
             [self.topics removeAllObjects];
            [self.topics addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GDTopic class] json:responseObject[@"list"]]];
            [self setupDataSource];
            [self.tableView.mj_header endRefreshing];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //taskDelagte method - URLSession:task:didCompleteWithError: 中会调用该block;
            if (error.code == -999) { //NSURLErrorCancelled task cancel 引起的 error
                //下拉操作因为的网络请求被取消，结束hearder刷新
                [self.tableView.mj_header endRefreshing];
            } else { //其他网络错误
                GDNSLog(@"LoadNewTopicsGetError:%@",error);
            }
        }];
}

/**
 *  加载下一页数据的 的 get请求
 */
- (void)loadMoreTopics
{
    //取消之前所有在 session中的所有task（主要应用在 下拉（或上拉）后，之前上拉（或下拉）操作所产出的上拉网络请求，应当立即取消，因为已经不需要 上拉请求的网络数据以及获得数据后的后续操作了）
    [[self.sessionManager tasks] makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSDictionary *paraDict = @{@"a":@"list", @"c":@"data",@"maxid":self.maxid};
    
    [self.sessionManager GET:url
     parameters:paraDict
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //存储本get请求数据中的maxid
            self.maxid = responseObject[@"info"][@"maxid"];
            //字典数据->模型（下拉加载最新数据）
                //将下一页的model对象添加到已存在的model对象之后
            [self.topics addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GDTopic class] json:responseObject[@"list"]]];
            [[NSArray yy_modelArrayWithClass:[GDTopic class] json:responseObject[@"list"]] enumerateObjectsUsingBlock:^(GDTopic  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.top_cmt count]) {
                    GDNSLog(@"%ld",idx);
                    GDSavePlist(responseObject);
                }
            }];
            [self setupDataSource];
            [self.tableView.mj_footer endRefreshing];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //taskDelagte method - URLSession:task:didCompleteWithError: 中会调用该block;
            if (error.code == -999) { //NSURLErrorCancelled task cancel 引起的 error
                //上拉操作因为的网络请求被取消，结束footer刷新
                [self.tableView.mj_footer endRefreshing];
            } else { //其他网络错误
                GDNSLog(@"LoadNewTopicsGetError:%@",error);
            }
        }];
}

#pragma mark UItableView DataSource
- (void)setupDataSource
{
    GDArrayDataSource *dataSource = [[GDArrayDataSource alloc]
                                     initWithItmes:self.topics
                                     executeBlock:^(GDTopicCell *cell, GDTopic *item) {
                                         [cell configurationForItem:item];
                                     }
                                     ReuseIdentifier:@"cell"];
    self.dataSource = dataSource;
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

#pragma mark UItableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
