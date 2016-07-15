//
//  GDTabBar.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTabBar.h"
@interface GDTabBar()
@property (nonatomic,weak) UIButton *publishButton;

@end
@implementation GDTabBar

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

//添加PublishButton

-(UIButton *)publishButton
{
    
    // lazy load
    if (!_publishButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = [UIColor blueColor];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview: button];
        
        _publishButton = button;
    }
    return _publishButton;
    
}

//如果需要对 tabbarItem进行高度自定义，可以创建这个子类
- (void)layoutSubviews
{
    //必须调用父类的该方法
    [super layoutSubviews];
    
    int buttonCount = 0;
    for (UIView *button in self.subviews) {
        
//        if ([button isKindOfClass:[UIControl class]]){
        if ([button class] == NSClassFromString(@"UITabBarButton")) {
            buttonCount += 1;
            
            //设置各个button的宽高
            button.GD_width =  self.GD_width / 5;
            if (buttonCount == 3) {
                //设置pulishButton的宽高
                self.publishButton.frame = button.frame;
            }
        }
        
    }
}
@end
