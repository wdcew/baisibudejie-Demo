//
//  GDPictureView.m
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDPictureView.h"
#import "GDBrowsePictureController.h"
#define margin 10
@interface GDPictureView ()<UIScrollViewDelegate,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fullPictureButton;
@property (weak, nonatomic) IBOutlet DACircularProgressView *progress;
@property (weak, nonatomic) IBOutlet UIImageView *gifTag;
@property (weak, nonatomic) GDTopic *model;
@property (weak, nonatomic) UIImage *fullPicture;
@end

@implementation GDPictureView

- (void)awakeFromNib
{
//    self.autoresizingMask = NO;
    self.progress.progressTintColor = GDColor(206,206, 206);
    self.progress.roundedCorners = YES;
}
#pragma mark target action method

//查看完成图片
- (IBAction)lookFullPicture:(id)sender {
    
//    //添加modalViewController
//        //1.或当前 View 所在的 controller
    UIViewController *tabBarC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *nav = [(UITabBarController *)tabBarC selectedViewController];
    UIViewController *vc = [(UINavigationController *)nav topViewController];
    
    GDBrowsePictureController *presentedVC = [[GDBrowsePictureController alloc] init];
    presentedVC.image = _contentView.image;
    [vc presentViewController:presentedVC animated:YES completion:^{
        
    }];
}

#pragma mark configurate method
- (void)configurateFoItem:(GDTopic *)model
{
    
    self.contentView.contentMode = UIViewContentModeScaleAspectFill;
    self.contentView.clipsToBounds = YES;
    
    //显示progress
    self.progress.hidden = NO;
    //默认隐藏
    self.fullPictureButton.hidden = NO;
    
    self.model = model;
    
    //根据当前网络状态，加载不同大小图片
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus  status = manager.networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN ) {//普通网络状态（4g 或是4）
        
    } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {//wifi状态
        
    } else if (status == AFNetworkReachabilityStatusNotReachable) { //无法连接网络状态
        //模拟器下默认为此状态
    }
    //直接加载中等图片
        //1.获取图片高度
    CGFloat height = model.midContentH.floatValue;
    CGFloat width = model.midContentW.floatValue;
            //大于屏幕 1/ 4进行限制
    CGFloat maxHeight = [[UIScreen mainScreen]bounds].size.height / 2.0;
    CGFloat maxWidth = [[UIScreen mainScreen]bounds].size.width - 2 * margin;
    
    if (height > maxHeight) height = maxHeight;
    
    width = width >=maxWidth?maxWidth: width;
       //2.通过约束 确定该 View 的宽高 (该代码会重复执行);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height).priorityHigh();
        make.width.mas_equalTo(width);
    }];
      //3.加载图片
    NSString *urlStr = model.bigImage;
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.contentView sd_setImageWithURL:url
                        placeholderImage:nil
                                 options:SDWebImageRetryFailed
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    self.progress.hidden = NO;
                                    self.progress.progress = (CGFloat)receivedSize / expectedSize;
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   GDNSLog(@"%f",image.size.height);
                                   _fullPicture = image;
//                                   [UIImageJPEGRepresentation(image, 1) writeToFile:@"/Users/gaoguandong/Desktop/1.jpg" atomically:YES];
                                   //是否隐藏放大按键
                                   if (image.size.height > maxHeight) self.fullPictureButton.hidden = NO;
                                   //隐藏 progressView
                                   self.progress.hidden = YES;
                               }];
     //4.根据图片类型隐藏 gifTag
    if ([urlStr.pathExtension isEqualToString:@"gif"]) {
        
        self.gifTag.hidden = NO;
    } else {
        
        self.gifTag.hidden = YES;
    }
}


@end
