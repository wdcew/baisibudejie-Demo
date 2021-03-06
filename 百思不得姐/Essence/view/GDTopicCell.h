//
//  GDTopicCell.h
//  百思不得姐
//
//  Created by 高冠东 on 8/2/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDbaseCell.h"
#import "GDTopic.h"

@interface GDTopicCell : GDbaseCell
/*头像*/
@property(nonatomic, weak) UIImageView *iconView;
/*内容*/
@property(nonatomic, weak) UILabel *contentLabel;
/*用户名*/
@property(nonatomic, weak) UILabel *nameLabel;
/*时间*/
@property(nonatomic, weak) UILabel *timeLabel;
/*更多按钮*/
@property(nonatomic, weak) UIButton *moreButton;

/*最热评论lable*/
@property(nonatomic, weak) UILabel *topcmtLabel;
/*赞*/
@property(nonatomic, weak) UIButton *praiseButton;
/*踩*/
@property(nonatomic, weak) UIButton *hateButton;
/*转发*/
@property(nonatomic, weak) UIButton *repostButton;
/*评论*/
@property(nonatomic, weak) UIButton *commentButton;


/*该属性交给子类去设置，针对子类添加的 SubView，调整constrains，以便达到cell的自动适应*/
@property (nonatomic, weak) UILabel *markLabel;
@property(nonatomic, weak) MASConstraint *markLabelConstraint;
@end
