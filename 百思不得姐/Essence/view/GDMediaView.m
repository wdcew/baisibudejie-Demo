//
//
//  Created by 高冠东 on 8/7/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDMediaView.h"
#define videoType 41
#define voiceType 31
#define margin 10
@interface GDMediaView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UIImageView *statusView;

@end

@implementation GDMediaView
- (void)awakeFromNib
{
    self.contentView.contentMode = UIViewContentModeScaleToFill;
    self.contentView.clipsToBounds = YES;
    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)configurateFoItem:(GDTopic *)model
{
        //1.获取真实图片高度
    CGFloat height = model.midContentH.floatValue;
    CGFloat width = model.midContentW.floatValue;
            //屏幕尺寸
    CGFloat maxHeight = [[UIScreen mainScreen]bounds].size.height;
    CGFloat maxWidth = [[UIScreen mainScreen]bounds].size.width;
    if (model.subjectType ==  videoType) {
        self.contentView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat scale = height / width;
           //设置视频时， contentview的宽高
        if (width > maxWidth && maxHeight / maxWidth > scale) {
            height = (maxWidth -2 * margin) * scale;
            width = (maxWidth - 2 * margin);
        } else { //height > maxheight / 2
            scale = 16.0 / 9;
            height = maxWidth / scale;
            width = (maxWidth - 2 * margin);
        }
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%.2ld",model.videotime.integerValue / 60, model.videotime.integerValue % 60];
        self.statusView.image = [UIImage imageNamed:@"video-play"];
    } else if (model.subjectType == voiceType) {
           //设置音频 contentVIew的宽高
        if (width >= maxWidth - 2 * margin) {
        CGFloat scale = height / width;
            height = (maxWidth -2 * margin) * scale;
        }
        
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%2ld",model.voicetime.integerValue / 60, model.voicetime.integerValue % 60];
        self.statusView.image = [UIImage imageNamed:@"playButtonPlay"];
    }
    
    self.playCount.text = model.playcount.integerValue < 10000 ? [NSString stringWithFormat:@"%@次播放量",model.playcount] : [NSString stringWithFormat:@"%ld.%.1ld万次播放量",model.playcount.integerValue / 10000,model.playcount.integerValue % 1000];
    //2.下载视频(音频)的预览图
    [self.contentView sd_setImageWithURL:[NSURL URLWithString:model.smallImage]];
    
    //3.通过约束 确定该 View 的宽高 (该代码会重复执行);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
}

@end
