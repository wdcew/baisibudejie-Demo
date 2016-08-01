//
//  GDMeViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDMeViewController.h"
#import "GDSquareButton.h"
#import "GDSettingViewController.h"
@interface GDMeViewController ()
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong)GDFooterView *footerView;
@end

@interface GDMeViewController(networking)
- (void)adGet;
@end


@implementation GDMeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNagationItem];
    [self setupTableView];
    [self adGet];
}
- (void)setUpNagationItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickSettingButton:) forControlEvents:UIControlEventTouchDown];
    [button sizeToFit];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupTableView
{
    
    self.view.backgroundColor = GDColor(206, 206, 206);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.footerView = [[GDFooterView alloc] init];
    self.tableView.tableFooterView = self.footerView;
    
    UINib *nib = [UINib nibWithNibName:@"GDTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}

//方法一：
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//}
#pragma mark target action method
- (void)clickSettingButton:(UIButton *)sender
{
    [self.tableView.mj_header endRefreshing];
//    GDSettingViewController *vc = [[GDSettingViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark load data method


#pragma mark TableviewDatasource Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section ==1) {
        cell.imagView.image = [UIImage imageNamed:@"comment-bar-keyboard"];
    }
    
    cell.label.text = @"test";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma maek UItableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return GDcellMargin;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return GDcellMargin;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
@end


#pragma mark Netwroking method
@implementation GDMeViewController (networking)

//方式 get 请求，获取 ADuview相关的 josn
- (void)adGet
{
    self.modelArray = [[NSMutableArray alloc] init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramDict = @{@"a":@"square",@"c":@"topic"};
    
    [manager GET:@"http://api.budejie.com/api/api_open.php"
      parameters:paramDict
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             GDSavePlist(responseObject);
             NSDictionary *array = responseObject[@"square_list"];
             for (NSDictionary *dict in array) {
                 GDADModel *model = [[GDADModel alloc] init];
                 [model yy_modelSetWithJSON:dict];
                 [self.modelArray addObject:model];
             }
             
             //判断是否获取正确的 modelArray
             if (self.modelArray.count) {
                 self.footerView.modelArray = self.modelArray;
                 [self.footerView setNeedsLayout];
                 
//                 [self.footerView.buttonArray enumerateObjectsUsingBlock:^(GDSquareButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                     [obj addTarget:self action:@selector(clickSquare:) forControlEvents:UIControlEventTouchDown];
//                 }];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             GDNSLog(@"get请求错误%@",error);
    }];
}

@end