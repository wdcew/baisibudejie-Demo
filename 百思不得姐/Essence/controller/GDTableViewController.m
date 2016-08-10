//
//  GDTableViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTableViewController.h"

@implementation GDTableViewController


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
        _sessionManager = [GDHTTPManager shareManger];
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
//    [self.tableView.mj_header beginRefreshing];
    //添加上拉控件 （用于获取更多数据）
    self.tableView.mj_footer = [GDRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)setupTableView
{
    self.view.backgroundColor = GDColor(206, 206, 206);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarInset + 30, 0, tabBarInset, 0);
    
    //文本 Cell
    [self.tableView registerClass:[GDTopicCell class] forCellReuseIdentifier:@"textCell"];
    //图片 cell
    [self.tableView registerClass:[GDPictureCell class] forCellReuseIdentifier:@"pictureCell"];
    //媒体（音频，视频）cell
    [self.tableView registerClass:[GDMediaCell class] forCellReuseIdentifier:@"mediaCell"];
    //存储各个 cell identifier 的数组
    NSArray *CellTypes = @[@"textCell",@"pictureCell",@"mediaCell"];
    self.cellTypes = CellTypes;
    
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //fd框架是否打印log
    self.tableView.fd_debugLogEnabled = YES;
    // SDImageCache设置
    [SDImageCache sharedImageCache].maxMemoryCountLimit = 5;
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
    
    [self.sessionManager GET:url
     parameters:self.urlParameters
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            GDSavePlist(responseObject);
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
                GDNSLog(@"%@:%@",NSStringFromSelector(_cmd),error);
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
    
    [self.sessionManager GET:url
     parameters:self.urlParameters
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //存储本get请求数据中的maxid
            self.maxid = responseObject[@"info"][@"maxid"];
            //字典数据->模型（下拉加载最新数据）
                //将下一页的model对象添加到已存在的model对象之后
            [self.topics addObjectsFromArray:[NSArray yy_modelArrayWithClass:[GDTopic class] json:responseObject[@"list"]]];
            [self setupDataSource];
            [self.tableView.mj_footer endRefreshing];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //taskDelagte method - URLSession:task:didCompleteWithError: 中会调用该block;
            if (error.code == -999) { //NSURLErrorCancelled task cancel 引起的 error
                //上拉操作因为的网络请求被取消，结束footer刷新
                [self.tableView.mj_footer endRefreshing];
            } else { //其他网络错误
                GDNSLog(@"%@:%@",NSStringFromSelector(_cmd),error);
            }
        }];
}

#pragma mark UItableView DataSource
- (void)setupDataSource
{
    //不存在,创建
    if (!self.ArrayDataSource) {
        GDArrayDataSource *dataSource = [[GDArrayDataSource alloc]
                                         initWithItmes:self.topics
                                         executeBlock:^(GDTopicCell *cell, GDTopic *item) {
                                             [cell configurationForItem:item];
                                         }
                                         ReuseIdentifier:^NSString *(NSMutableArray<GDTopic *> *items, NSIndexPath *indexPath) {
                                             NSString *identifier;
                                             //判断需要复用哪种类型 的cell;
                                             if (items[indexPath.row].subjectType == textType) {
                                                 identifier = self.cellTypes[0];
                                             } else if (items[indexPath.row].subjectType == pictureType) {
                                                 identifier = self.cellTypes[1];
                                             } else if (items[indexPath.row].subjectType == videoType || self. topics[indexPath.row].subjectType == voiceType) {
                                                 identifier = self.cellTypes[2];
                                             }
                                             //返回需要复用cell 的标示符；
                                             return identifier;
                                         }];
        
        self.ArrayDataSource = dataSource;
        self.tableView.dataSource = self.ArrayDataSource;
    }
//    更新tableView
    [self.tableView reloadData];
}

#pragma mark UItableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier;
    //判断需要复用哪种类型 的cell;
    if (self.topics[indexPath.row].subjectType == textType) {
        identifier = self.cellTypes[0];
    } else if (self.topics[indexPath.row].subjectType == pictureType) {
        identifier = self.cellTypes[1];
    } else if (self.topics[indexPath.row].subjectType == videoType || self. topics[indexPath.row].subjectType == voiceType) {
        identifier = self.cellTypes[2];
    }
    self.ArrayDataSource.identifier = identifier;
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(id cell) {
        GDTopic *model = [self.ArrayDataSource itemAtIndex:indexPath.row];
        [cell configurationForItem:model];
    }];
    
    //因为覆写了 cell 的  setFrame method，减少height，以便分隔 Cell,这里做补偿（很重要）
    return height + 10;
//
////    //测试用代码
//    GDTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pictureCell"];
//    //model
//    GDTopic *model = [self.ArrayDataSource itemAtIndex:indexPath.row];
//    [cell configurationForItem:model];
//    
//    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    //保证用于计算高度的cell，与一般的cell配置一致。
//    [cell prepareForReuse];
//    [cell setNeedsUpdateConstraints];
//    [cell layoutIfNeeded];
//    
//    //如果 cell有自动换行的label， 则需要确定 cellContenView 宽度,或则在cell内部 手动设置其preferredMaxLayoutWidth
////        GDLogRect(tableView.frame);
////        GDLogRect(cell.frame);
////        GDLogRect(cell.contentView.frame);
//        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:tableView.frame.size.width]; [cell.contentView addConstraint:widthFenceConstraint];
//        
//    
////    根据子视图的constrans 自动算出尺寸。
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGFloat height1 = size.height;
//    printf("%ld:%f\n",(long)indexPath.row,height1);
////    计算完后保存，避免多次重复计算
//    [self saveCellHeight:height1 forIndexPath:indexPath];
//
//    
//    return height1;
}

//- (void)saveCellHeight:(NSUInteger)height forIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
@end
