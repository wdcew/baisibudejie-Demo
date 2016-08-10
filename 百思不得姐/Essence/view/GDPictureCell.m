//
//  GDPictureCell.m
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDPictureCell.h"
#import "GDPictureView.h"
@interface GDPictureCell ()
@property (nullable, weak, nonatomic) GDPictureView *pictureView;
@end

@implementation GDPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        GDPictureView *pictureView = [GDPictureView viewFromNib];
        [self.contentView addSubview:pictureView];
        
        self.pictureView = pictureView;
        //只会执行一次的constraints
        [self resetCustomConstraints];
    }
    
    return self;
}

- (void)configurationForItem:(GDTopic *)item
{
    [super configurationForItem:item];
    [self.pictureView configurateFoItem:item];
}

- (void)resetCustomConstraints
{
    
//    [self.markLabelConstraint uninstall];
    
    //新添加的 View 的 COnstraints,cell自动适应高度 要依赖于这些约束
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(1);
    }];

    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureView.mas_bottom);
    }];
}

@end
