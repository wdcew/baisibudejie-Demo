//
//  GDBrowsePictureController.m
//  百思不得姐
//
//  Created by 高冠东 on 8/8/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDBrowsePictureController.h"

#import "GDPhotosManager.h"

@interface GDBrowsePictureController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
//@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *contentView;

@end

@implementation GDBrowsePictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置 HUD
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [self configContentView];
    [self configScrollView];
    [self resizeSubview];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark configurate method
- (void)configScrollView
{
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.maximumZoomScale = 2.5;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.scrollsToTop = NO;
}

- (void)configContentView
{
    
    _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 0, 0)];
    _contentView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_contentView];
    
    _contentView.image = _image;
}

- (void)resizeSubview
{
    NSLog(@"%@",NSStringFromCGSize(_image.size));
    CGFloat height;
    CGFloat width = _scrollView.GD_width;
    if (_image.size.height / _image.size.width > _scrollView.GD_height / _scrollView.GD_width) {
        height = _image.size.height < _scrollView.GD_height ? _image.size.height : _image.size.height * _scrollView.GD_width / _image.size.width;
        
    } else {
        height = _image.size.width < _scrollView.GD_width ? _image.size.height : _scrollView.GD_width * _image.size.height / _image.size.width;
    }
    
    _contentView.GD_height = height;
    _contentView.GD_width  = width;
    //必须在确定宽高后 执行
    if (height < _scrollView.GD_height) {
        _contentView.GD_centerY = _scrollView.GD_height / 2;
    }
    _contentView.GD_centerX = _scrollView.GD_width / 2;
    
    _scrollView.contentSize = CGSizeMake(width, height);
}


#pragma mark action method
- (IBAction)savePicture:(id)sender {
    GDPhotosManager *manager = [GDPhotosManager SharePhotosManger];
    
    if ([manager authorizationStatusAuthorizecd]) {
//       PHObjectPlaceholder *placeholder = [manager saveImage:_image completion:^(BOOL success, NSError * _Nullable error) {
//        }];
        //保存图片，并将图片放入相应 Title 的 AssetCollection 中
        [manager addImages:@[_image] ToAssetCollectionsWithTitle:@"5" Completion:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                [SVProgressHUD setMinimumDismissTimeInterval:1.5];
                [SVProgressHUD  showErrorWithStatus:@"图片保存失败"];
                GDNSLog(@"%@:%@",NSStringFromSelector(_cmd), error);
            }
            [SVProgressHUD setMinimumDismissTimeInterval:1.5];
            [SVProgressHUD  showSuccessWithStatus:@"图片保存成功"];
        } automic:YES];
    }
}

- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark scrollView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    //适时调节View的center,以保证缩放后，View 一直在屏幕中央。
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    _contentView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
    return _contentView;
}

@end
