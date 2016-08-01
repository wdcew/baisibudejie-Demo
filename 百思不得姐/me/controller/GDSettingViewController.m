//
//  GDSettingViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/22/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
static NSString *const cacheKey = @"cacheCell";
static NSString *const normalKey = @"normalCell";


#import "GDSettingViewController.h"

@interface GDSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong)NSArray *cellTypeKeys;
@property (nonatomic, weak)UILabel *titleLabel;
@end

@implementation GDSettingViewController
#pragma  mark lazy load method

- (NSArray *)cellTypeKeys
{
    if (!_cellTypeKeys) {
        _cellTypeKeys = @[cacheKey,normalKey];
    }
    return _cellTypeKeys;
}

#pragma mark setUp method
- (void)loadView{
    [super loadView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)viewDidLoad
{
    self.tableView.backgroundColor = GDColor(206, 206, 206);
    [self setTableView];
}

- (void)setTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"GDTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[GDSettingCell class] forCellReuseIdentifier:@"cacheCell"];
    
}

#pragma mark custom method
//- (unsigned long)getDiskCacheSize:(NSString *)fullPath
//{
//    unsigned long totalSize = 0.0;
//    //获取 fullPath大小
//    totalSize = fullPath.FullPathSize;
//    //获取 使用SDwebImage框架下的 diskCache
//    SDWebImageManager *webImageManager = [ SDWebImageManager sharedManager];
//    totalSize += [webImageManager.imageCache getSize];
//    
//    return totalSize;
//}

/**
 *  清除Disk cache directory中的文件夹
 *
 *  @param  folderName 要清除的文件夹名称
 *  @param completion 完成后执行的操作
 */
- (void)clearDiskCacheWithPath:(NSString *)folderName Completion:(void (^)())completion
{
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullPath = [str stringByAppendingPathComponent: folderName];
    
    //删除文件为耗时操作，在子线程执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
#warning 测试需要延迟；
        [NSThread sleepForTimeInterval:5];
        //删除自身创建的 temp 文件夹
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //重新建立一个空的文件夹
        [manager removeItemAtPath:fullPath error:nil];
        [manager createDirectoryAtPath:fullPath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
        
        //删除 SDwebImage框架 自身创建的cache
        SDWebImageManager *webImageManager = [ SDWebImageManager sharedManager];
        [webImageManager.imageCache clearDiskOnCompletion:^{
            //完成后需要执行的操作
            completion();
        }];
        
    });
}

#pragma mark setup cellTyep method
- (GDSettingCell *)cacheCellAtIndexPath:(NSIndexPath *)indexPath
{
    GDSettingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cacheCell" forIndexPath:indexPath];
    self.titleLabel = cell.label;
    return cell;
}

- (GDTableViewCell *)normalCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    GDTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark TableviewDatasource Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.cellTypeKeys[indexPath.section];
    UITableViewCell *cell;
    if ([key isEqualToString:cacheKey]) {
        cell = [self cacheCellAtIndexPath:indexPath];
    } else {
        cell = [self normalCellAtIndexPath:indexPath];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma maek UItableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.cellTypeKeys[indexPath.section];
    if ([key isEqualToString:cacheKey]) {
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showWithStatus:@"正在清除缓存"];
        
        [self clearDiskCacheWithPath:@"1/1" Completion:^{
            self.titleLabel.text = @"缓存0 KB";
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [SVProgressHUD dismiss];
        }];
    }
}

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
