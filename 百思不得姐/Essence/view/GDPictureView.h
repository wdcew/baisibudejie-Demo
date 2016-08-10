//
//  GDPictureView.h
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTopic.h"

@interface GDPictureView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *contentView;
- (void)configurateFoItem:(id)model;

@end
