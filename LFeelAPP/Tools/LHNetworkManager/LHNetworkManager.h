//
//  LHNetworkManager.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, RequestMethodType) {
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

@interface LHNetworkManager : NSObject







+ (LHNetworkManager *)sharedManager;

/**
 *  GET网络请求
 *
 *  @param url     请求的网址
 *  @param dic     请求需要的参数
 *  @param success 请求成功的回调
 *  @param aError   请求失败的回调
 */
+ (void)requestForGetWithUrl:(NSString *)url
                   parameter:(NSDictionary *)dic
                     success:(void(^)(id reponseObject))success
                     failure:(void(^)(NSError *error))aError;

/**
 *  POST网络请求
 *
 *  @param url     请求的网址
 *  @param dic     请求需要的参数
 *  @param success 请求成功的回调
 *  @param aError   请求失败的回调
 */
+ (void)requestForPostWithUrl:(NSString *)url
                    parameter:(NSDictionary *)dic
                      success:(void(^)(id reponseObject))success
                      failure:(void(^)(NSError *error))aError;


/** 上传单张图片 */
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
         consImage:(UIImage *)consImage
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock;

/** 上传多张图片 */
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
        consImages:(NSArray<UIImage *> *)consImages
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock;








+ (void)PostWithUrl:(NSString *)url
          parameter:(NSDictionary *)dic
            success:(void(^)(id reponseObject))success
            failure:(void(^)(NSError *error))aError;













@end
