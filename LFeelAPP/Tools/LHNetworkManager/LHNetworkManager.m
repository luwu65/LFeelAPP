//
//  LHNetworkManager.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHNetworkManager.h"



#define ContentType @"application/json"

@implementation LHNetworkManager


+ (LHNetworkManager *)sharedManager{
    static LHNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHNetworkManager
                    alloc]init];
    });
    return manager;
}

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
                     failure:(void(^)(NSError *error))aError{
    /**创建一个网络请求管理对象*/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:kToken forHTTPHeaderField:@"token"];
    /**设置可接受的数据类型*/
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    
    url = [NSString stringWithFormat:@"%@%@", kUrlHeader, url];
    if (![url hasSuffix:@"?"]) {
        url = [url stringByAppendingString:@"?"];
    }
#if DEBUG
    _printParameter(dic, url);
#endif
    /**开始网络请求*/
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将请求成功返回的结果会调回去
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //回调请求失败的错误信息
        aError(error);
    }];
}

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
                      failure:(void(^)(NSError *error))aError{
    //创建网络请求类管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置可接受的数据类型
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"charset=utf-8", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    url = [NSString stringWithFormat:@"%@%@", kUrlHeader, url];
    if (![url hasSuffix:@"?"]) {
        url = [url stringByAppendingString:@"?"];
    }
#if DEBUG
    _printParameter(dic, url);
#endif
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功结果的回调
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败结果的回调
        aError(error);
    }];
}






// 上传单张图片
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
         consImage:(UIImage *)consImage
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",nil];
    url = [NSString stringWithFormat:@"%@%@", kUrlHeader, url];
    if (![url hasSuffix:@"?"]) {
        url = [url stringByAppendingString:@"?"];
    }
#if DEBUG
    _printParameter(parameters, url);
#endif
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (consImage) {
            /**
             //判断图片是不是png格式的文件
             if (UIImagePNGRepresentation(image)) {
             //返回为png图像。
             data = UIImagePNGRepresentation(image);
             }else {
             //返回为JPEG图像。
             data = UIImageJPEGRepresentation(image, 1.0);
             }
             */
            //1.转成NSData类型
            NSData *data = UIImagePNGRepresentation(consImage);
            //2.加时间
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            //转成文件格式
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"image"  fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        KMyLog(@"------------------------%f", 1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}




// 上传多张图片
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
        consImages:(NSArray<UIImage *> *)consImages
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    url = [NSString stringWithFormat:@"%@%@", kUrlHeader, url];
    if (![url hasSuffix:@"?"]) {
        url = [url stringByAppendingString:@"?"];
    }
#if DEBUG
    _printParameter(parameters, url);
#endif
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (consImages) {
            for (int i = 0; i < consImages.count; i++) {
                //1.转成NSData类型
                NSData *imageData = UIImageJPEGRepresentation(consImages[i], 1);
                //2.加时间
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                //转成文件格式
                NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str, i];
                [formData appendPartWithFileData:imageData name:@"file"  fileName:fileName mimeType:@"png"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        
    }];
}





+ (void)PostWithUrl:(NSString *)url
          parameter:(NSDictionary *)dic
            success:(void(^)(id reponseObject))success
            failure:(void(^)(NSError *error))aError{
    url = [NSString stringWithFormat:@"%@%@", kUrlHeader, url];
    if (![url hasSuffix:@"?"]) {
        url = [url stringByAppendingString:@"?"];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            NSLog(@"1111111111%@", dic);
            success(dic);
            
        } else {
//            NSLog(@"2222222222%@", [error localizedDescription]);
            aError(error);
        }
        
    }];
    [dataTask resume];
}








static void _printParameter(NSDictionary * p, NSString * urlString) {
    NSString * string = [NSString stringWithFormat:@"请求参数：\n%@\nURL: ", p];
    NSString * u = [NSString stringWithFormat:@"%@", urlString];
    NSMutableString * str = [NSMutableString string];
    [str appendString:string];
    [str appendString:u];
    [p enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"%@=%@&", key, obj];
    }];
    
    if ([str hasSuffix:@"&"]) {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    u = [NSString stringWithFormat:@"🎈%s 第 %d 行📍\n%@\n\n", __func__, __LINE__, str];
    printf("%s", u.UTF8String);
}












@end