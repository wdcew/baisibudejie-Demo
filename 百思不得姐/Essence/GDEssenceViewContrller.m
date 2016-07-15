//
//  GDEssenceViewContrller.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDEssenceViewContrller.h"

@implementation GDEssenceViewContrller

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    imagView.image = [UIImage imageNamed:@"MainTitle"];
//    [imagView sizeToFit];
    self.navigationItem.titleView = imagView;
   
    UIBarButtonItem *righItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"] style:UIBarButtonItemStyleDone target:self action:@selector(click:)];
    self.navigationItem.rightBarButtonItem = righItem;
    
}

- (void)click:(id)sender
{
    
    GDBaseViewController *vc = [[GDBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.view.backgroundColor = [UIColor redColor];
}

@end
