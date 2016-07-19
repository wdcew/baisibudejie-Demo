//
//  GDNavigationController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDNavigationController.h"
#import "GDBaseViewController.h"
@interface GDNavigationController() <UIGestureRecognizerDelegate>
@end

@implementation GDNavigationController
#pragma mark gestureDelegate
//gesture Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count >1) {//rootViewcontroller 不允许 pop手势交互
        return YES;
    }
    
    return NO;
}

#pragma mark override method
- (void)viewDidLoad
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    UIImage *image = [UIImage imageNamed:@"navigationButtonReturn"];
    //image 使用原始渲染，以便被系统自动渲染为浅蓝色
   image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UINavigationBar appearance] setBackIndicatorImage:image];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
}

/**
 * 在该方法中，自定义Navigationbar中的backBUtton的样式
 */
- (void)pushViewController:(GDBaseViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];

    UIBarButtonItem *backTitle = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSDictionary *normalAttr =@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]};
    [backTitle setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    NSDictionary *selectedAttr =@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    [backTitle setTitleTextAttributes:selectedAttr forState:UIControlStateHighlighted];
    
    viewController.navigationItem.backBarButtonItem = backTitle;
    if (self.childViewControllers.count > 1) {//判断当前controller 是否为rootController
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:viewController action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateSelected];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [backButton sizeToFit];
        
        //调节backButton的位置。
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        UIBarButtonItem *LeftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = LeftItem;
    }
}


@end
