//
//  GDTableViewController.h
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDTableViewController.h"

#import "GDRefreshNormalHeader.h"
#import "GDRefreshBackFooter.h"

#import "GDTopicCell.h"
#import "GDPictureCell.h"
#import "GDMediaCell.h"
#import "GDTopic.h"
#import "GDArrayDataSource.h"

#define textType    29
#define pictureType 10
#define videoType   41
#define voiceType   31
#define allType     1
@interface GDTableViewController : UITableViewController

@property (nonatomic, strong)NSMutableArray<GDTopic *> *topics;
@property (nonatomic, strong)GDArrayDataSource *ArrayDataSource;
@property (nonatomic, strong)AFHTTPSessionManager *sessionManager;
//get请求的参数
@property (nonatomic, strong)NSDictionary *urlParameters;
//第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容
@property (nonatomic, strong)NSString *maxid;
//存储不同 类型cell的identifier
@property (nonatomic, strong)NSArray<NSString *> *cellTypes;

- (void)loadNewTopics;
- (void)loadMoreTopics;
@end
