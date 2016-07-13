//  百思不得姐
//
//  Created by 高冠东 on 7/12/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTabbarController.h"
#import "PrefixHeader.pch"
#import "GDTabBar.h"

@interface GDTabbarController ()
@end

@implementation GDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    /****添加ViewController***/
    [self setupViewcontroller];
    /****添加自定义的TabBar与 Item的相关属性***/
    [self setupTabBarAndItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    /****在 UITabBar 添加一个BUtton****/
    //方法一，还有方法二 自定义一个babbar
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    button.frame = CGRectMake(self.tabBar.bounds.size.width * 2 / 5, 0,self.tabBar.bounds.size.width / 5, self.tabBar.bounds.size.height);
////    button.backgroundColor = [UIColor blueColor];
//    [self.tabBar addSubview:button];
//    
//    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
}

#pragma mark init method
- (void)setupTabBarAndItem
{
    
    //使用 appearance 统一对 所有Itme 的相关property 进行配置
    UITabBarItem *item = [UITabBarItem appearance];
    NSDictionary *normalAttr =@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]};
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    NSDictionary *selectedAttr =@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    
    /****添加自定义的TabBar***/
//        通过KVC 可以进行赋值
    [self setValue:[[GDTabBar alloc]init] forKey:@"tabBar"];
}

- (void)setupViewcontroller
{
    
    UIViewController *vc1 =[[UIViewController alloc] init];
    UIImage *selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [self setViewController:vc1 TabBarItemTitle:@"精华" Image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:selectedImage];
    
    UIViewController *vc3 =[[UIViewController alloc] init];
    UIImage *selectedImage3 = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [self setViewController:vc3 TabBarItemTitle:@"朋友" Image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:selectedImage3];
    
    UIViewController *vc4 =[[UIViewController alloc] init];
    UIImage *selectedImage4 = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [self setViewController:vc4 TabBarItemTitle:@"我的" Image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:selectedImage4];
    
    UIViewController *vc2 =[[UIViewController alloc] init];
    UIImage *selectedImage2 = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [self setViewController:vc2 TabBarItemTitle:@"最新" Image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:selectedImage2];
    
    UIViewController *empty = [[UIViewController alloc] init];
    
    [self setViewControllers:@[vc1,vc2,empty,vc3,vc4] animated:YES];
}

/**
 *  设置ViewController 中的tabBarItem属性
 *
 *  @param vc        ViewController
 *  @param str      TabBarItem 的 title
 *  @param image    图片
 *  @param selimage 被选中时的图片
 */
- (void)setViewController:(UIViewController *)vc TabBarItemTitle:(NSString *)str Image:(UIImage *)image selectedImage:(UIImage *)selimage
{
    vc.tabBarItem.title = str;
    
    //setupImage 的渲染模式我oringinal，以免系统自动渲染为蓝色（UIbutton,以及 tabbarItem均有此问题，在被选中时，被渲染为蓝色）
        //但是如果添加了setSelectedImage 就不会有这样的情况发生
//    UIImage *img = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setImage:image];
    [vc.tabBarItem setSelectedImage:selimage];
}



#pragma mark memoryManage

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
