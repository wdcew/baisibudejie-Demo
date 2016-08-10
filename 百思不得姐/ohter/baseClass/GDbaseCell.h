//
//  GDbaseCell.h
//  百思不得姐
//
//  Created by 高冠东 on 8/2/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDbaseCell.h"
@interface GDbaseCell : UITableViewCell

- (void)ImageForView:(UIImageView *)imageView WithUrlStr:(NSString *)urlStr;
- (void)translateDateForLabel:(UILabel *)label WithObject:(id)obj;

- (void)configurationForItem:(id)item; //交给子类去覆写
@end
