//
//  GDTopicCell.m
//  百思不得姐
//
//  Created by 高冠东 on 8/2/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTopicCell.h"
#import "GDTopic.h"

#define margin 10
@interface GDTopicCell ()
@property (nonatomic, weak) UILabel *markLabel;
@end

@implementation GDTopicCell
#pragma mark override method
- (void)configurationForItem:(GDTopic *)item
{
    self.nameLabel.text = item.name;
    [self translateDateForLabel:self.timeLabel WithObject:item.passtime];
    self.contentLabel.text = item.text;
    [self ImageForView:self.iconView WithUrlStr:item.profile_image];
    
    if (![item.top_cmt count]) { //没有最热评论，隐藏
        self.topcmtLabel.hidden = YES;
        self.markLabel.hidden = YES;
    } else { //含有最热评论，显示topLabel
        self.markLabel.hidden = NO;
        self.topcmtLabel.hidden = NO;
        self.topcmtLabel.text = item.top_cmt[0].content;
    }
}

/**
 *  重写该method的 是为了将cell的 height 减去 margin以达到cell之间有 分隔距离 。
 *
 *  @param frame 该 frame的 height会被 减去 GDcellMargin;
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height = frame.size.height - GDcellMargin;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addCustomView];
        [self TopViewConstraints];
        [self bottomViewconstraints];
    }
    return self;
}

#pragma mark
- (void)addCustomView
{
    /*添加顶部 View*/
      /*icon*/
    UIImageView *icon = [[UIImageView alloc] init];
    [self addSubview:icon];
    self.iconView = icon;
      /*用户名label*/
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont systemFontOfSize:13];
    [self addSubview:name];
    self.nameLabel = name;
      /*时间label*/
    UILabel *time = [[UILabel alloc] init];
    time.font = [UIFont systemFontOfSize:11];
    [self addSubview:time];
    self.timeLabel = time;
      /*内容label*/
    UILabel *content = [[UILabel alloc] init];
    content.numberOfLines = 0;
    content.font = [UIFont systemFontOfSize:13];
    [self addSubview:content];
    self.contentLabel = content;
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"cellmorebtnclick"] forState:UIControlStateHighlighted];
    [self addSubview:moreButton];
    self.moreButton = moreButton;
    
    
    /*添加底部 View*/
        //最热评论ContentLabel
    UILabel *topCmtView = [[UILabel alloc] init];
    topCmtView.font = [UIFont systemFontOfSize:11];
    topCmtView.numberOfLines = 0;
    [self addSubview:topCmtView];
    self.topcmtLabel = topCmtView;
    
        //最热评论 Label
    UILabel *marklabel = [[UILabel alloc] init];
    marklabel.text =@"最热评论";
    marklabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:marklabel];
    self.markLabel = marklabel;
    [marklabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topCmtView.mas_left);
        make.bottom.equalTo(topCmtView.mas_top);
    
    }];
    
    
        //赞button
    UIButton *praise = [UIButton buttonWithType:UIButtonTypeCustom];
    [praise setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [praise setTitle:@"顶" forState:UIControlStateNormal];
    self.praiseButton = praise;
        //踩button
    UIButton *hate = [UIButton buttonWithType:UIButtonTypeCustom];
    [hate setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    [hate setTitle:@"踩" forState:UIControlStateNormal];
    self.hateButton = hate;
        //转发
    UIButton *repost = [UIButton buttonWithType:UIButtonTypeCustom];
    [repost setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [repost setTitle:@"分享" forState:UIControlStateNormal];
    self.repostButton = repost;
        //评论
    UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [comment setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [comment setTitle:@"评论" forState:UIControlStateNormal];
    self.commentButton = comment;
        //共同设置
    NSArray *array = @[self.praiseButton,self.hateButton,self.commentButton,self.repostButton];
    for (UIButton *button in array) {
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    /*添加分割线 view*/
        //content 与 button的分割线
    UIImageView *separateView = [[UIImageView alloc] init];
    separateView.image = [UIImage imageNamed:@"cell-content-line"];
    [self addSubview:separateView];
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentButton.mas_top);
        make.left.right.mas_equalTo(self);
        make.height.equalTo(@1);
    }];
        //在各个 Button 中添加分割线，并且创建 create constraint
    [array enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *separateView = [[UIImageView alloc] init];
        separateView.image = [UIImage imageNamed:@"cell-button-line"];
        [self addSubview:separateView];
        [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(obj.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(@1.5);
            make.height.equalTo(obj.mas_height);
        }];
    }];
}

- (void)TopViewConstraints
{
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(margin);
        make.left.equalTo(self.mas_left).offset(margin);
        make.width.mas_equalTo(35);
        make.height.equalTo(self.iconView.mas_width);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.iconView.mas_bottom);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- margin);
        make.top.equalTo(self.mas_top).offset(margin);
        make.width.height.mas_equalTo(35);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self.iconView.mas_left);
        make.right.equalTo(self.moreButton.mas_right);
    }];
}

- (void)bottomViewconstraints
{
    //button Constrains
    NSArray *array = @[self.praiseButton,self.hateButton,self.commentButton,self.repostButton];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    //最热评论label constrains
    [self.topcmtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(margin);
        make.right.mas_equalTo(self).offset(- margin);
        make.bottom.equalTo(self.praiseButton.mas_top);
    }];
}

- (void)updateConstraints
{
//    UIWindow *win = [[UIApplication sharedApplication] keyWindow];

    [super updateConstraints];
}

@end
