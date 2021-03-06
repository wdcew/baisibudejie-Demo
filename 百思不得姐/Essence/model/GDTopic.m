//
//  GDTopic.m
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTopic.h"
@implementation GDTopic

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
{
    return @{@"subjectType":@"type",
             @"midContentH":@"height",
             @"midContentW":@"width",
             @"smallImage":@"image0",
             @"midImage":@"image2",
             @"bigImage":@"image1"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"top_cmt":[GDCommentModel class]};
}

@end
