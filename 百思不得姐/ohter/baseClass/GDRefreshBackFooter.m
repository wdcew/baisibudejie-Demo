//
//  GDRefreshBackFooter.m
//  百思不得姐
//
//  Created by 高冠东 on 8/1/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDRefreshBackFooter.h"

@implementation GDRefreshBackFooter

/** 初始化 */
- (void)prepare
{
    [super prepare];
    //改变title
    [self setTitle:@"自定义上拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"自定义松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"自定义正在刷新" forState:MJRefreshStateRefreshing];
    // 改变 title 颜色
    [self.stateLabel setTextColor:[UIColor orangeColor]];
    //改变拉拽的百分比
    self.pullingPercent = 2;
    self.automaticallyChangeAlpha = YES;
}

/** 摆放子控件frame */
- (void)placeSubviews
{
    [super placeSubviews];
    
}

@end
