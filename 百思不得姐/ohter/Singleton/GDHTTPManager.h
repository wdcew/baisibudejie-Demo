//
//  GDHTTPManager.h
//  百思不得姐
//
//  Created by 高冠东 on 8/8/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@interface GDHTTPManager : AFHTTPSessionManager

+ (GDHTTPManager *)shareManger;
@end
