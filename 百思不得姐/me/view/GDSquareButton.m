//
//  GDSquareButton.m
//  百思不得姐
//
//  Created by 高冠东 on 7/21/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDSquareButton.h"

@implementation GDSquareButton

- (void)setModel:(GDADModel *)model
{
    _model = model;
//    下载BUtton 相应的广告图片和标题
    NSURL *url = [NSURL URLWithString:self.model.icon];
     
    [self sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRetryFailed  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            GDNSLog(@"webImageError:%@",error);
        };
    }];
    
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    [self setTitle:self.model.name forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
@end
