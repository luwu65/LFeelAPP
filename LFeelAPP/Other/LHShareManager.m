//
//  LHShareManager.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/1.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHShareManager.h"

@implementation LHShareManager




+ (void)shareTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url image:(id)image Plantform:(UMSocialPlatformType)type completion:(UMSocialRequestCompletionHandler)completion {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:completion];
}





















@end
