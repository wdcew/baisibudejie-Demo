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
typedef NSString* (^CellTypePick)(NSMutableArray *items, NSIndexPath *indexPath);
@property(nonatomic, copy) executeBlock block;
@property(nonatomic, copy) CellTypePick pickCell;
@property (nonatomic, strong)NSString *identifier;

- (instancetype)initWithItmes:(NSMutableArray *)items executeBlock:(executeBlock)block ReuseIdentifier:(CellTypePick)identifier;
- (id)itemAtIndex:(NSUInteger)index;

@end
