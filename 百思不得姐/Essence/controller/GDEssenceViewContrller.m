//
//  GDEssenceViewContrller.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDEssenceViewContrller.h"
#define ViewCount 5

@interface GDEssenceViewContrller () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
/*标题栏*/
@property (nonatomic, weak)GDTitleView *titleView;
/*socrollView*/
@property (nonatomic, weak)UIScrollView *scrollView;
/*对应 tableView 的 Controller*/
@property (nonatomic, strong) NSMutableArray<UITableViewController *> *childControllers;
@end
@implementation GDEssenceViewContrller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setupScrollView];
    [self setupNavgationItem];
    [self setupTitleView];
    
    //初始化为默认点击“全部”button
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.titleView performSelector:@selector(adjustIndicatorView:) withObject:@(0)];
        [self lazyLoadVCWithIndex];
    });
}

#pragma mark

#pragma  mark setup method
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    // 不允许自动调整scrollView的内边距(很重要，不然添加的tableView可以无法识别手势）
    self.automaticallyAdjustsScrollViewInsets = NO;
    //即将 contentSize 与其 subVIewsCount 相除，以达到分页移动的效果
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.GD_width * ViewCount, self.view.GD_height);
    scrollView.directionalLockEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    NSMutableArray *childControllers = [NSMutableArray array];
    self.childControllers = childControllers;
    GDWholeTableViewController *vc1 = [[GDWholeTableViewController alloc] init];
    [childControllers addObject:vc1];
    
    GDVideoTableViewController *vc2 = [[GDVideoTableViewController alloc] init];
    [childControllers addObject:vc2];
    
    GDVoiceTableViewController *vc3 = [[GDVoiceTableViewController alloc] init];
    [childControllers addObject:vc3];
    
    GDImageTableViewController *vc4 = [[GDImageTableViewController alloc] init];
    [childControllers addObject:vc4];
    
    GDTextTableViewController *vc5 = [[GDTextTableViewController alloc] init];
    [childControllers addObject:vc5];
}

- (void)setupTitleView
{
    GDTitleView *view = [[GDTitleView alloc] initWithFrame:CGRectMake(0, 64, 350, 30)];
    view.GD_centerX = self.view.GD_centerX;
    [view addTarget:self action:@selector(swapTableView:) forControlEvents:UIControlEventTouchDown];
    self.titleView  = view;
    [self.view addSubview:view];
    
}

- (void)setupNavgationItem
{
    UIImageView *imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //    imagView.image = [UIImage imageNamed:@"MainTitle"];
    //    [imagView sizeToFit];
    self.navigationItem.titleView = imagView;
    UIBarButtonItem *righItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"] style:UIBarButtonItemStyleDone target:self action:@selector(click:)];
    self.navigationItem.rightBarButtonItem = righItem;
}

#pragma mark

#pragma mark target-action method
- (void)swapTableView:(UIButton *)sender
{
    //1.根据点击的button调整indicatorView
    [self.titleView performSelector:@selector(adjustIndicatorView:) withObject:sender];
    
    //2.根据点击的button，调整scrollView要显示的content;
    CGPoint offset = CGPointMake(sender.tag * self.scrollView.GD_width, 0);
        //2.1 该method 会调用delegate的scrollViewDidEndScrollingAnimation
    [self.scrollView setContentOffset:offset animated:YES];
    
    //3.1根据点击的button,对 controller 进行lazy load;
//    [self lazyLoadVCWithIndex:sender.tag];
    
}

- (void)click:(id)sender
{
    GDBaseViewController *vc = [[GDBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.view.backgroundColor = [UIColor redColor];
}

#pragma mark
- (void)lazyLoadVCWithIndex
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.GD_width;
    UITableViewController *vc = self.childControllers[index];
    //如果不存在相应的 VC 的tableView，则进行加载
    if (![self.scrollView.subviews containsObject:vc.tableView]) {
//        vc.tableView.frame = CGRectMake(self.view.GD_width * index, 0, self.view.GD_width, self.view.GD_height);
        vc.tableView.frame = self.scrollView.bounds;
        [self.scrollView addSubview:vc.tableView];
    }
}



#pragma mark scrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

/**
 *  !!!只用调用 setContentOffset/scrollRectVisible:animated: 这两个method，产生动画结束后，才会调用该方法。
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //3.1根据点击的button,对 controller 进行lazy load;
    [self lazyLoadVCWithIndex];
}

/**
 *  人为拖动Scrollview 才会调用该方法（即手势识别）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 2) { //当拖动方向为X轴时，改变scrollView display content
        NSInteger index = scrollView.contentOffset.x / self.scrollView.GD_width;
        //1.修改titleView 相关的label与 indicatorView
        [self.titleView performSelector:@selector(adjustIndicatorView:) withObject:@(index)];
        //1.进行lazy load.
        [self lazyLoadVCWithIndex];
    }
}


@end
