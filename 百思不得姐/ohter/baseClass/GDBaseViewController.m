//
//  GDBaseViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDBaseViewController.h"

@implementation GDBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setupBackBarButtonItem];
    
}
- (void)setupBackBarButtonItem
{
    
    if (self.navigationController.childViewControllers.count > 1 ) {//判断当前controller 是否为rootController
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateSelected];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [backButton sizeToFit];
        
        //调节backButton的位置。
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        UIBarButtonItem *LeftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = LeftItem;
    }
}
- (void)popAction:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickBack:(UIViewController *)sender {
    
    [sender.navigationController popViewControllerAnimated:YES];
    
}

@end
