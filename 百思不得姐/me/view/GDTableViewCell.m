//
//  GDTableViewCell.m
//  百思不得姐
//
//  Created by 高冠东 on 7/19/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTableViewCell.h"
@interface GDTableViewCell ()

- (void)imageWithUrlStr:(NSString *)str;
@end

@implementation GDTableViewCell

- (void)configureForItem:(id)item
{
    
}

- (void)imageWithUrlStr:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    [self.imagView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            GDNSLog(@"cellWebImageError:%@",error);
        }
    }];
}

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
            make.width.equalTo(self.contentView.mas_width).multipliedBy(0.8);
            make.left.equalTo(self.contentView).offset(10);
        }];
    }
    return _label;
}


-(void)updateConstraints
{
    //如果都该cell 需要imageView与label，采用layout
    if (_imagView && _label) {
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(self.contentView.GD_height + 10);
        }];
    } else {
        //如果都该cell 只需要label，采用layout
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
//      [_label sizeToFit];(可以使用该方法，自动调整width 和  height)
            make.left.equalTo(self.contentView).offset(5);
        }];
    }
    
    [super updateConstraints];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

@end
