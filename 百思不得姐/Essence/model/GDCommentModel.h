//
//  GDCommentModel.h
//  百思不得姐
//
//  Created by 高冠东 on 8/3/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDUserModel.h"

@interface GDCommentModel : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) GDUserModel *user;

@end
