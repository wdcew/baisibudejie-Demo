//
//  GDTopicCell.m
//  百思不得姐
//
//  Created by 高冠东 on 8/2/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTopicCell.h"

#define margin 10
@interface GDTopicCell ()
@end

@implementation GDTopicCell
#pragma mark override method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addCustomView];
        [self TopViewConstraints];
        [self bottomViewConstraints];
    }
    return self;
}

- (void)configurationForItem:(GDTopic *)item
{
    self.nameLabel.text = item.name;
    [self translateDateForLabel:self.timeLabel WithObject:item.passtime];
    self.contentLabel.text = item.text;
    [self ImageForView:self.iconView WithUrlStr:item.profile_image];
    
    if (![item.top_cmt count]) { //没有最热评论，隐藏
        self.topcmtLabel.hidden = YES;
        self.markLabel.hidden = YES;
        //将其 text赋值为nil,这样label 的高度会变为0！（重要）
        self.markLabel.text = nil;
        self.topcmtLabel.text = nil;
    } else { //含有最热评论，显示topLabel
        self.topcmtLabel.text = item.top_cmt[0].content;
        self.markLabel.text = @"最热评论";
        self.markLabel.hidden = NO;
        self.topcmtLabel.hidden = NO;
        
    }
}
/*
 *  @param frame 该 frame的 height会被 减去 GDcellMargin;
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height = frame.size.height - 10;
    [super setFrame:frame];
}


#pragma mark
- (void)addCustomView
{
    /*添加顶部 View*/
      /*icon*/
    UIImageView *icon = [[UIImageView alloc] init];
    [self.contentView addSubview:icon];
    self.iconView = icon;
      /*用户名label*/
    UILabel *name = [[UILabel alloc] init];
    
    name.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:name];
    self.nameLabel = name;
      /*时间label*/
    UILabel *time = [[UILabel alloc] init];
    time.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:time];
    self.timeLabel = time;
      /*内容label*/
    UILabel *content = [[UILabel alloc] init];
    content.numberOfLines = 0;
//    content.preferredMaxLayoutWidth = 200;
    content.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:content];
    self.contentLabel = content;
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"cellmorebtnclick"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:moreButton];
    self.moreButton = moreButton;
    
    
    /*添加底部 View*/
    
        //最热评论 Label
    UILabel *marklabel = [[UILabel alloc] init];
    marklabel.text =@"最热评论";
    marklabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:marklabel];
    self.markLabel = marklabel;
    
        //最热评论ContentLabel
    UILabel *topCmtView = [[UILabel alloc] init];
    topCmtView.font = [UIFont systemFontOfSize:11];
    topCmtView.numberOfLines = 0;
    [self.contentView addSubview:topCmtView];
    self.topcmtLabel = topCmtView;
    
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
        [self.contentView addSubview:button];
    }
    
//    /*添加分割线 view*/
        //content 与 button的分割线
    UIImageView *separateView = [[UIImageView alloc] init];
    separateView.image = [UIImage imageNamed:@"cell-content-line"];
    [self.contentView addSubview:separateView];
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentButton.mas_top);
        make.left.right.mas_equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
        //在各个 Button 中添加分割线，并且创建 create constraint
    [array enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *separateView = [[UIImageView alloc] init];
        separateView.image = [UIImage imageNamed:@"cell-button-line"];
        [self.contentView addSubview:separateView];
        [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(obj.mas_right);
            make.top.equalTo(obj.mas_top);
            make.width.equalTo(@1.5);
            make.height.equalTo(obj.mas_height);
        }];
    }];
}

- (void)TopViewConstraints
{
    //定位x,y坐标
        // !cell自动适应高度所需 Constraint
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(margin);
        make.left.equalTo(self.contentView.mas_left).offset(margin);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
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
        make.right.equalTo(self.contentView.mas_right).offset(- margin);
        make.top.equalTo(self.iconView.mas_top);
        make.width.height.mas_equalTo(35);
        make.height.equalTo(self.moreButton);
    }];
    
        // !cell自动适应高度所需 Constraint
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self.contentView.mas_left).offset(margin);
        make.right.equalTo(self.contentView.mas_right).offset(- margin);
        //换行label 不能对其bottom进行约束
    }];
    
}

- (void)bottomViewConstraints
{
    
//    最热评论taglabel constrains
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        // !cell自动适应高度所需 Constraint
        self.markLabelConstraint = make.top.equalTo(self.contentLabel.mas_bottom).priorityLow();
    }];
    
//    最热评论contentlabel constrains
    [self.topcmtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.markLabel.mas_bottom);
        make.left.mas_equalTo(self.iconView);
        make.right.mas_equalTo(self.moreButton);
        //换行label,不能对其bottom进行约束
    }];
    
    //button Constrains
    NSArray *array = @[self.praiseButton,self.hateButton,self.commentButton,self.repostButton];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    
        // !cell自动适应高度所需 Constraint
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topcmtLabel.mas_bottom).offset(1);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    
}

- (void)updateConstraints
{
//    UIWindow *win = [[UIApplication sharedApplication] keyWindow];

    [super updateConstraints];
}


@end
