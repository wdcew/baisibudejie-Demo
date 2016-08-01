//
//  GDFooterView.m
//  百思不得姐
//
//  Created by 高冠东 on 7/19/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
#define  TotalColumn 4
#import "GDFooterView.h"
#import "GDWebViewController.h"

@implementation GDFooterView

//- (NSMutableArray *)buttonArray
//{
//    if (!_buttonArray) {
//        _buttonArray = [NSMutableArray array];
//    }
//    return _buttonArray;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

 -(void)layoutSubviews
{
    [super layoutSubviews];
    
    int currentRow;
    int currentColumn;
    float buttonH ,buttonW;
    
    buttonW = self.superview.GD_width / TotalColumn;
    buttonH = buttonW;
    
    for (int i = 0; i< self.modelArray.count; i++) {
        GDSquareButton *button = [GDSquareButton buttonWithType:UIButtonTypeCustom];
        currentRow = i / TotalColumn;
        currentColumn = i % TotalColumn;
        
        float x = currentColumn * buttonW;
        float Y = currentRow * buttonH;
        button.frame = CGRectMake(x, Y, buttonW, buttonH);
        [self addSubview:button];
        
        //给相应 Button 的 model 赋值
            //该 Button的set方法被重写为自动下载图片
        button.model = self.modelArray[i];
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        
    }
    //根据BUtton 的数量，修改footerView 的height
    self.GD_height = self.modelArray.count /TotalColumn *buttonH;
    
    //更新 tableview 的 ContentSize
    UITableView *tableView = (UITableView *)self.superview;
        //必须要重新赋值，这样使用reloadData才会有效果。
    tableView.tableFooterView = self;
    [tableView reloadData];
}

- (void)clickButton:(GDSquareButton *)sender
{
    NSString *url = sender.model.url;
    if ([url hasPrefix:@"http"]) {
        //1.获取tabbarController
       UITabBarController *tabVc= (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        //2.获取当前的 navigationCOntroller
        UINavigationController *nagVC = tabVc.selectedViewController;
       //3.创建 webView相应的 Controller;
        GDWebViewController *webVC = [[GDWebViewController alloc] init];
        webVC.url = url;
        
        //4.present modal controller
        webVC.hidesBottomBarWhenPushed = YES;
        [nagVC pushViewController:webVC animated:YES];
        
    }else if ([url hasPrefix:@"mod"]) {
        GDNSLog(@"跳转到其他界面");
        if ([url hasSuffix:@"check"]) {
            GDNSLog(@"跳转到[审帖]界面");
        } else if ([url hasSuffix:@"RankingList"]) {
            GDNSLog(@"跳转到[排行榜]界面");
        }
        
    } else {
        GDNSLog(@"url解析错误：%@",url);
    }
}

@end
