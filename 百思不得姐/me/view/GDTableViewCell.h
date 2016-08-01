//
//  GDTableViewCell.h
//  百思不得姐
//
//  Created by 高冠东 on 7/19/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imagView;
@property (nonatomic, strong) UILabel *label;
- (void)imageWithUrlStr:(NSString *)str;
//- (void)configureForitem:(id)item;
@end
