//
//  NSString+GDStringExtension.m
//  百思不得姐
//
//  Created by 高冠东 on 7/25/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "NSString+GDStringExtension.h"

@implementation NSString (GDStringExtension)


/**
 *  获取当前Path的内容大小，无论path是文件还是目录，都能正确获取。当path不存在是会报错。
 */
- (NSUInteger)FullPathSize
{
    NSUInteger totalSize = 0.0;
    NSFileManager *manager = [NSFileManager defaultManager];
    //不存在当前路径
    NSAssert([manager fileExistsAtPath:self], @"Non-existent path:%@",self);
    
    NSDictionary *dict = [manager attributesOfItemAtPath:self error:nil];
    if ([dict[NSFileType] isEqualToString:NSFileTypeDirectory]) { //该path 为一个目录
        
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *shortPath in enumerator) {
            NSString *path = [self stringByAppendingPathComponent:shortPath];
            NSDictionary *dict = [manager attributesOfItemAtPath:path error:nil];
            totalSize += [dict[NSFileSize] longValue];
        }
    } else {  //该path 为一个文件
        NSDictionary *dict = [manager attributesOfItemAtPath:self error:nil];
        totalSize += [dict[NSFileSize] longValue];
    }
    return totalSize;
}
@end
