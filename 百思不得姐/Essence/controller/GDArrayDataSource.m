//
//  GDArrayDataSource.m
//  百思不得姐
//
//  Created by 高冠东 on 7/28/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDArrayDataSource.h"
@interface GDArrayDataSource ()
@property (nonatomic, strong)NSMutableArray *items;
@property (nonatomic, strong)NSString *identifier;
@end

@implementation GDArrayDataSource


- (instancetype)initWithItmes:(NSMutableArray *)items executeBlock:(executeBlock)block ReuseIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        self.items = items;
        self.block = block;
        self.identifier = identifier;
    }
    return self;
    
}

- (id)itemAtIndex:(NSUInteger)index;
{
    return self.items[index];
}

#pragma mark TableviewDatasource Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
    if (cell) {
        id item = self.items[indexPath.section];
        self.block(cell,item);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
