//
//  UIView+GDViewExtension.h
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GDViewExtension)


// 为了不跟其他框架中的 Extension 的 property 冲突，建议在前缀名
@property (nonatomic, assign) CGFloat GD_height;
@property (nonatomic, assign) CGFloat GD_width;
@property (nonatomic, assign) CGFloat GD_x;
@property (nonatomic, assign) CGFloat GD_y;
@property (nonatomic, assign) CGFloat GD_centerX;
@property (nonatomic, assign) CGFloat GD_centerY;
@end
