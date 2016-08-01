//
//  GDRefreshNormalHeader.m
//  百思不得姐
//
//  Created by 高冠东 on 7/31/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDRefreshNormalHeader.h"

@implementation GDRefreshNormalHeader

///** 初始化 */
//- (void)prepare NS_REQUIRES_SUPER;
///** 摆放子控件frame */
//- (void)placeSubviews NS_REQUIRES_SUPER;
- (void)prepare
{
    [super prepare];//必须调用父类方法 (NS_REQUIRES_SUPER)
    //修改 label state
    [self setAutomaticallyChangeAlpha:YES];
    [self setTitle:@"自定义下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"自定义松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"自定义正在刷新" forState:MJRefreshStateRefreshing];
    
    //修改 颜色
    [self.stateLabel setTextColor:[UIColor orangeColor]];
    
    //修改 timelabel
    [self.lastUpdatedTimeLabel setTextColor:[UIColor redColor]];
    
    
}

///** 摆放子控件frame */
- (void)placeSubviews
{
    [super placeSubviews];
    //可以添加图片到 headerView
}
@end
