//
//  GDSettingCell.m
//  百思不得姐
//
//  Created by 高冠东 on 7/25/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDSettingCell.h"

@implementation GDSettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CacheCell];
    }
    return self;
}

//将cell 配置为 CacheCell;
- (GDSettingCell *)CacheCell
{
        //1.设置 label
    self.label.text = self.title;
    //2.设置 indicatorView
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView startAnimating];
    self.accessoryView = indicatorView;
    //3.停止该cell 的 interactive
    self.userInteractionEnabled = NO;
    
    GDSettingCell  __weak __block *weakSelf = self; //表明dispatch 中block对，该实例的引用为若引用。
    //4.计算缓存大小(耗时操作，在子线程中执行
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //                            GDSettingCell *strongSelf = weakSelf;// 在执行block时，为强引用，确保self 不被释放。（此block 中不需要）
        //if (strongSelf)
        unsigned long totalSize = 0;
        NSString *str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fullPath = [str stringByAppendingPathComponent:@"1/1"];
        //2.自己定义的diskCache（耗时最多的操作）
        totalSize += fullPath.FullPathSize;
        //2.1使用 sdWebImage 产生的DiskCache(耗时最多的操作）
        SDWebImageManager *webImageManager = [ SDWebImageManager sharedManager];
        totalSize += [webImageManager.imageCache getSize];
        
        if (weakSelf) { //判断在获取 fullpathSize之后，相应的 cell是否被释放（即退出含有 显示缓存的ViewController),不存在，则不需要在执行以下代码，以便提高性能
            //2.2对Size 进行容量转换
            //pow(10,9)，10的9次方
            if (totalSize > pow(10, 9)) { //size>1GB
                _title = [NSString stringWithFormat:@"当前缓存：%0.2f GB",totalSize / pow(10, 9)];
            } else if (totalSize > pow(10, 6)) { // size > 1MB
                _title = [NSString stringWithFormat:@"当前缓存：%0.2f MB",totalSize / pow(10, 6)];
            } else { //size < 1 MB 时
                _title = [NSString stringWithFormat:@"当前缓存：%0.3f KB",totalSize / pow(10, 3)];
            }
            
            //3.在主线程中刷新 UI 界面
            dispatch_async(dispatch_get_main_queue(), ^{
                //允许该cell进行交互
                weakSelf.userInteractionEnabled = YES;
                //刷新 labelText
                weakSelf.label.text = _title;
                //情况指示器
                weakSelf.accessoryView = nil;
                //显示 默认的 accessoryType
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            });
        }
    });
    return self;
    
}

@end
