//
//  GDNewViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDNewViewController.h"
#import "GDLoginRegisterViewController.h"
@implementation GDNewViewController

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (IBAction)clickSignIn:(id)sender {
    
    GDLoginRegisterViewController *vc = [[GDLoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
