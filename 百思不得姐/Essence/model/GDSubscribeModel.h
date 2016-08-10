//
//  GDSubscribeModel.h
//  百思不得姐
//
//  Created by 高冠东 on 8/5/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDbaseCell.h"

@interface GDSubscribeModel : GDbaseCell
@property (nonatomic, nonnull, strong) NSString *name;
@property (nonatomic, nonnull, strong) NSString *ID;
@property (nonatomic, nonnull, strong) NSString *imageUrl;
@property (nonatomic, nonnull, strong) NSString *subNumber;
@end
