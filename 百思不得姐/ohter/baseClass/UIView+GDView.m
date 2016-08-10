//
//  UIView+GDView.m
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "UIView+GDView.h"

@implementation UIView (GDView)

+ (instancetype)viewFromNib
{
     UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
    NSAssert(view != nil, @"%@,can't crate View,please check whether exist correspond nib",NSStringFromClass(self));
    return view;
}

@end
