//
//  GDHTTPManager.m
//  百思不得姐
//
//  Created by 高冠东 on 8/8/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDHTTPManager.h"
static GDHTTPManager *shareManager;

@implementation GDHTTPManager

+ (GDHTTPManager *)shareManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[GDHTTPManager alloc] initPraivate];
    });
    return shareManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [super allocWithZone:zone];
    });
    return shareManager;
}

- (instancetype)initPraivate
{
    self = [super initWithBaseURL:nil sessionConfiguration:nil];
    
    if (self) {
        //该类的一些自定义方法
    }
    return self;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    @throw [NSException exceptionWithName:@"singleton" reason:@"use + [GDHTTPManager ShareManager]" userInfo:nil];
    
    return nil;
}

@end

