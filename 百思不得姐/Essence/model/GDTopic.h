//
//  GDTopic.h
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
//返回值字段	字段类型	字段说明
//maxid	string	最大的帖子id
//maxid	int	帖子的总数
//page	int	默认情况下，就是一页20个帖子情况下的最大页数
//maxtime	string	每次加载下一页的时候，需要传入上一页返回参数中对应的此内容，例如：1434112682
//weixin_url	string	当分享到微信中的url链接
//love	string	收藏量
//is_gif	string	是否是gif动画
//playfcount	string	真实的播放次数？
//theme_id	int	0
//mid	int	0
//created_at	string	系统审核通过后创建帖子的时间
//videotime	string	如果含有视频则该参数为视频的长度
//cai	string	踩的人数
//type	int	帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
//theme_id	string	标签的id,如：微视频的id为55
//theme_name	string	帖子的所属分类的标签名字
//theme_type	int	一般为1
//profile_image	string	头像的图片url地址
//voicelength	string	如果为音频则为音频的时长
//screen_name	string	发帖人的昵称
//passtime	string	帖子通过的时间和created_at的参数时间一致
//playcount	string	播放次数
//voiceuri	string	如果为音频，则为音频的播放地址
//cdn_img	string	视频加载时候的静态显示的图片地址
//from	string	9
//hate	string	踩的数量
//id	int	帖子id
//text	string	帖子的内容
//tag	string	帖子的标签备注
//height	string	图片或视频等其他的内容的高度
//repost	string	转发的数量
//original_pid	string	空
//image1	string	显示在页面中的视频图片的url
//favourite	string	帖子的收藏量
//url	string	空
//voicetime	string	如果为音频类帖子，则返回值为音频的时长
//image0	string	显示在页面中的视频图片的url
//videouri	string	视频播放的url地址
//image_small	string	显示在页面中的视频图片的url
//bookmark	string	帖子的收藏量
//user_id	string	发帖人的id
//name	string	发帖人的昵称
//sina_v	int	是否是新浪会员
//width	string	视频或图片类型帖子的宽度
//theme_name	string	空
//comment	string	帖子的被评论数量
//jie_v	int	是否是百思不得姐的认证用户
//status	string	帖子的状态（例：4）
#import <UIKit/UIKit.h>
#import "GDCommentModel.h"

@interface GDTopic : UITableViewController
@property (nonatomic, strong) NSString *name; //发帖的人名字
@property (nonatomic, strong) NSString *profile_image; //发帖人的头像
@property (nonatomic, strong) NSString *text;  //发帖的内容
@property (nonatomic, strong) NSString *passtime; //发帖审核通过的时间
@property (nonatomic, strong) NSString * comment; //评论的数量
@property (nonatomic, strong) NSString *ding; //顶的数量
@property (nonatomic, strong) NSString *repost; //转发的数量
@property (nonatomic, strong) NSString *hate; //踩的数量

@property (nonatomic, strong) NSArray<GDCommentModel *> *top_cmt; //最热评论

@property (nonatomic)         int      subjectType;// model的类型，图片还是视频
@property (nonatomic, strong) NSString *midContentH; //中间内容高度（图片，视频，声音等等）
@property (nonatomic, strong) NSString *midContentW;//中间内容宽度

@property (nonatomic, strong) NSString *smallImage; //中间内容（小图，根据网络状态决定 不同大小类型的图片）
@property (nonatomic, strong) NSString *midImage; //中间内容（中等图
@property (nonatomic, strong) NSString *bigImage; //中间内容（大图）
@property (nonatomic, strong) NSString *playcount; //视频（音频）播放次数
@property (nonatomic, strong) NSString *videotime; //视频 时间；
@property (nonatomic, strong) NSString *voicetime; //音频 时间；

@end
