//
//  GDCustomButton.m
//  百思不得姐
//
//  Created by 高冠东 on 7/15/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDCustomButton.h"
@interface GDCustomButton ()

@end

@implementation GDCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    //对 label 与 imageView进行一些 配置
    self.clipsToBounds = NO;
    self.titleLabel.clipsToBounds = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
}

- (void)layoutSubviews
{
    int margin = 5;
    [super layoutSubviews];
    //label 根据Text 自动调整自身大小
//    [self.titleLabel sizeToFit];
    if (self.imageView.image != nil) { //该button存在image
        self.imageView.frame = CGRectMake(0, margin, self.GD_width, self.GD_height * 2 / 3);
        
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(self.GD_width / 2, self.GD_height * 5/6);
//        self.titleLabel.frame = CGRectMake(0, self.imageView.GD_height, self.GD_width, self.GD_height  / 3);
    } else{ //若不存在 image
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(self.GD_width / 2, self.GD_height / 2);
    }
//不建议使用constraint 对button 内部的 image 和label 进行布局。
    
    
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.width.equalTo(self.mas_width);
//        make.height.equalTo(self.mas_height).multipliedBy(2.0/ 3);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.mas_left);
//        make.width.equalTo(self.mas_width);
//        make.height.equalTo(self.mas_height).multipliedBy(1.0/ 3);
//    }];
}
@end
