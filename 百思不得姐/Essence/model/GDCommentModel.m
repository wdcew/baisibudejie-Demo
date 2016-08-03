//
//  GDCommentModel.m
//  百思不得姐
//
//  Created by 高冠东 on 8/3/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDCommentModel.h"

@implementation GDCommentModel

- (NSString *)content
{
    NSString *mixContent = [NSString stringWithFormat:@"%@:%@",self.user.username,_content];
    return mixContent;
}

@end
