//
//  UIView+GDViewExtension.m
//  百思不得姐
//
//  Created by 高冠东 on 7/13/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "UIView+GDViewExtension.h"

@implementation UIView (GDViewExtension)

- (void)setGD_height:(CGFloat)GD_height
{
    CGRect frame = self.frame;
    frame.size.height = GD_height;
    self.frame = frame;
}
- (CGFloat)GD_height
{
    return self.frame.size.height;
}

- (void)setGD_width:(CGFloat)GD_width
{
    CGRect frame = self.frame;
    frame.size.width = GD_width;
    self.frame = frame;
}

- (CGFloat)GD_width
{
    return self.frame.size.width;
}

- (void)setGD_x:(CGFloat)GD_x
{
    CGRect frame = self.frame;
    frame.origin.x = GD_x;
    self.frame = frame;
}

- (CGFloat)GD_x
{
    return self.frame.origin.x;
}

- (void)setGD_y:(CGFloat)GD_y
{
    CGRect frame = self.frame;
    frame.origin.y = GD_y;
    self.frame = frame;
}

- (CGFloat)GD_y
{
    return self.frame.origin.y;
}

@end
