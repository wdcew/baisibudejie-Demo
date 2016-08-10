//
//  GDPhotosManager.m
//  百思不得姐
//
//  Created by 高冠东 on 8/9/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDPhotosManager.h"
@interface GDPhotosManager ()
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@end

static GDPhotosManager *_shareManger;
@implementation GDPhotosManager
- (ALAssetsLibrary *)assetLibrary
{
    if (!_assetLibrary)_assetLibrary = [[ALAssetsLibrary alloc] init];
    return _assetLibrary;
}

+ (instancetype)SharePhotosManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManger = [[GDPhotosManager alloc] init];
    });
    return _shareManger;
}

- (BOOL)authorizationStatusAuthorizecd
{
    if (iOS(8)) {
        
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) return YES;
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            }];
        }
    } else {
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized)return YES;
    }
    
    return NO;
}


- (void)addImages:(NSArray <UIImage *> * _Nonnull)images ToAssetCollectionsWithTitle:(NSString *_Nullable )str Completion:(_Nonnull Completion)block automic:(BOOL)allow
{
    if (iOS(10)) {
        PHAssetCollection *assetColleciton;
        NSError *error;
        NSMutableArray *placeholders = [NSMutableArray array];;
        //1.将 Image 保存到 photo 之中
        for (UIImage * image in images) {
            NSData *data = UIImageJPEGRepresentation(image, 1);
            PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
            options.shouldMoveFile = YES;
            
            PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
            [photoLibrary performChangesAndWait:^{
                PHAssetCreationRequest *creatAssetRequest = [PHAssetCreationRequest creationRequestForAsset];
                [placeholders addObject: creatAssetRequest.placeholderForCreatedAsset];
                [creatAssetRequest addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
            } error:&error];
            //存储照片错误，立即返回;
            if (error) {
                block(NO,error);
                return;
            }
        }
        
        //2.寻找对应 Title 的 assetcollection
        PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        for (PHAssetCollection *collection in result) {
            if([collection.localizedTitle isEqualToString:str]) assetColleciton = collection;
        }
        if (assetColleciton) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetCollectionChangeRequest *request;
                request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetColleciton];
                //3.将图片放入对应的collection
                [request addAssets:placeholders];
            } completionHandler:^(BOOL success, NSError * _Nullable error) { block(success, error); }];
            
        } else {
            //不存在asset collection时， 允许根据titles创建相应的collection
            if (allow) {
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    PHAssetCollectionChangeRequest *request;
                    request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:str];
                    [request addAssets:placeholders];
                } completionHandler:^(BOOL success, NSError * _Nullable error) { block(success, error);}];
            }
            else {NSAssert(allow != NO,@"without assetCollection,please check collection title");}
        }
    } else { //IOS8 以前
        //iOS8 之前，allow 必须传入 YES
        if (allow == NO) {NSAssert(allow != NO,@"without assetCollection,please check collection title");};
        __weak GDPhotosManager *weakSelf = self;
        
        //1.addAssetsGroupAlbumWithName 建立相应的group(若已存在，resultBlock的 group 为nil)
        [weakSelf.assetLibrary addAssetsGroupAlbumWithName:str resultBlock:^(ALAssetsGroup *group) {
            //2.寻找对应 Title 的  group
            [weakSelf.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                ALAssetsGroup *targetGroup = nil;
                int flag = 0;
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:str]) {
                    targetGroup = group;
                    *stop = YES;
                    flag = 0;
                }
                
                if (targetGroup) {//1.1 找到对应的Group
                    for (UIImage *image in images) {
                        //3.将image 写入 photo,并且引入对应的Group
                        [weakSelf.assetLibrary writeImageToSavedPhotosAlbum:image.CGImage
                                                                orientation:ALAssetOrientationUp
                                                            completionBlock:^(NSURL *assetURL, NSError *error) {
                                                                [weakSelf.assetLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                                                                    [targetGroup addAsset:asset];
                                                                } failureBlock:^(NSError *error) {
                                                                    GDNSLog(@"assetForURL method error");
                                                                    block(NO,error);
                                                                }];
                                                                if (!error) block(YES,error);
                                                            }];
                    }
                }
            } failureBlock:^(NSError *error) {
                GDNSLog(@"enumrater method failure:%@",error);
                block(NO,error);
            }];
        } failureBlock:^(NSError *error) { GDNSLog(@"addAsetGroupAlbumWithName methodfilure:%@",error);}];
    }
}

- (void)saveImage:(UIImage *)image completion:(void(^)(BOOL success, NSError * _Nullable error))block
{
    __block PHObjectPlaceholder *placeholder;
    if (iOS(9)) {//ios8使用此方法保存图片会报错
        NSData *data = UIImageJPEGRepresentation(image, 1);
        
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        options.shouldMoveFile = YES;
        
        PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        [photoLibrary performChanges:^{
            //所有的Change Request 必须在此block中执行
            //2.将 Image加入相册（roll Album）中
            PHAssetCreationRequest *creatAssetRequest = [PHAssetCreationRequest creationRequestForAsset];
            placeholder = creatAssetRequest.placeholderForCreatedAsset;
            [creatAssetRequest addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            //block 的代码会在主队列中同步执行（防止将该 method 写入子线程时，无法在刷新界面等情况）
            dispatch_sync(dispatch_get_main_queue(), ^{ block(success, error);});
        }];
    } else {
        [self.assetLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) block(NO,error);
            else block(YES,error);
        }];
    }
}

@end
