//
//  MDManager.m
//  VKu
//
//  Created by jens on 16/5/26.
//  Copyright © 2016年 黄冰珂. All rights reserved.
//

#import "MDManager.h"
// 1. 导入库文件
#import <CommonCrypto/CommonDigest.h>

@implementation MDManager
+(NSString *)md5withStr:(NSString *)str
{
    // 获取c字符串
    const char *cStr = [str UTF8String];
    
    // 创建字符数组来接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    // 计算MD5的值
    // 第一个参数: C字符串
    // 第二个参数: 字符串的长度
    // 第三个参数: 数组的首地址, 用来接收加密后的值
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    // 获取摘要值
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultStr appendFormat:@"%02X", result[i]];
    }
//    NSLog(@"%@", resultStr);
    return resultStr;
   
}



@end
