//
//  GDTableViewCell.m
//  百思不得姐
//
//  Created by 高冠东 on 7/19/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTableViewCell.h"
@interface GDTableViewCell ()

@end

@implementation GDTableViewCell


- (UIImageView *)imagView
{
    if (!_imagView) {
        _imagView = [[UIImageView alloc] init];
        _imagView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imagView];
        [_imagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(5);
            make.bottom.mas_equalTo(self.contentView).offset(- 5);
            make.left.mas_equalTo(self.contentView).offset(5);
            make.width.equalTo(_imagView.mas_height);
        }];
    }
    return _imagView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.contentMode = UIViewContentModeCenter;
        
        [self.contentView  addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.width.equalTo(self.contentView.mas_height);
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
    return _label;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}
-(void)updateConstraints
{
    
    if (_imagView && _label) {
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(self.contentView.GD_height + 10);
        }];
    } else {
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
        }];
    }
    [super updateConstraints];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
