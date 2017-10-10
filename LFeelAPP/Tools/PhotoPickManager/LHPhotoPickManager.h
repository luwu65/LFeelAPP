//
//  LHPhotoPickManager.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHPhotoPickManager : NSObject


/**
 创建单例类
 */
+ (instancetype)sharedManager;

/**
 保存图片到相片胶卷
 */
- (void)saveImage:(UIImage *)image toPhotoRoll:(void(^)())successSave fail:(void(^)())failBlock;

/**
 保存图片到自定义相册
 */
- (void)saveImage:(UIImage *)image toPhotosName:(NSString *) name success:(void (^)())successSave fail:(void (^)())failBlock;

/**
 选择单张图片
 */
- (void)getImageInView:(UIViewController *)vc successBlock:(void(^)(UIImage *image))successBlock;

/**
 选择多张图片   0为不限张数
 */
- (void)getImagesInView:(UIViewController *)vc maxCount:(NSInteger)maxCount successBlock:(void(^)(NSMutableArray<UIImage *> *images))successBlock;









@end
