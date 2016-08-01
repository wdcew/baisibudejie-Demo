//
//  GDArrayDataSource.h
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GDArrayDataSource : NSObject <UITableViewDataSource>

typedef void (^executeBlock)(id cell,id item);
@property(nonatomic,strong) executeBlock block;

- (instancetype)initWithItmes:(NSMutableArray *)items executeBlock:(executeBlock)block ReuseIdentifier:(NSString *)identifier;
- (id)itemAtIndex:(NSUInteger)index;

@end
