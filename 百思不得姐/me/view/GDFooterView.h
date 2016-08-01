//
//  GDFooterView.h
//  百思不得姐
//
//  Created by 高冠东 on 7/19/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSquareButton.h"
#import "GDADModel.h"

@interface GDFooterView :UIView
@property (nonatomic) NSUInteger squareCount;
//@property (nonatomic, strong) NSMutableArray<GDSquareButton *> *buttonArray;
@property (nonatomic, weak)NSMutableArray<GDADModel *> *modelArray;

@end
