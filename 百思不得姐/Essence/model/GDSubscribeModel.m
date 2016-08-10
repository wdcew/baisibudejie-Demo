//
//  GDSubscribeModel.m
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDSubscribeModel.h"

@implementation GDSubscribeModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
{
    return @{@"name": @"theme_name",
             @"ID": @"theme_id",
             @"imageUrl": @"image_list",
             @"subNumber": @"sub_number",
             };
}

@end
