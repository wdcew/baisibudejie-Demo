//
//  GDVideoCell.m
//  百思不得姐
//
//  Created by 高冠东 on 8/7/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDMediaCell.h"
#import "GDMediaView.h"

@interface GDMediaCell ()
@property (nonatomic, weak) GDMediaView *mediaView;
@end

@implementation GDMediaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        GDMediaView *mediaView = [GDMediaView viewFromNib];
        [self.contentView addSubview:mediaView];
        self.mediaView = mediaView;
        //只会执行一次的constraints
        [self resetCustomConstraints];
    }
    
    return self;
}

- (void)configurationForItem:(GDTopic *)item
{
    [super configurationForItem:item];
    [self.mediaView configurateFoItem:item];
}

- (void)resetCustomConstraints
{
    
//    [self.markLabelConstraint uninstall];
    
    //新添加的 View 的 COnstraints,cell自动适应高度 要依赖于这些约束
    [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(self.iconView);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(1);
    }];

    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mediaView.mas_bottom);
    }];
}
@end
