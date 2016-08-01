//
//  GDTitleView.h
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTitleView : UIView

- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)event;
- (void)adjustIndicatorView:(GDCustomButton *)sender;

@end
