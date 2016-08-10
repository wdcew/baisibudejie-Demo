//
//  GDPhotosManager.h
//  百思不得姐
//
//  Created by 高冠东 on 8/9/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GDPhotosManager : NSObject

typedef void(^Completion)(BOOL success, NSError * _Nullable error);

+ (nonnull instancetype)SharePhotosManger;

- (BOOL)authorizationStatusAuthorizecd;

- (void)saveImage:(nullable UIImage *)image completion:(nullable void(^)(BOOL success, NSError * _Nullable error))block;

- (void)addImages:(NSArray <UIImage *> * _Nonnull)images ToAssetCollectionsWithTitle:(NSString *_Nullable )str Completion:(_Nonnull Completion)block automic:(BOOL)allow;
@end
