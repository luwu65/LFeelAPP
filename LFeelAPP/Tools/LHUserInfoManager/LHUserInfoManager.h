//
//  LHUserInfoManager.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHUserInfoModel.h"

@interface LHUserInfoManager : NSObject


//保存用户信息
+ (void)saveUserInfoWithModel:(LHUserInfoModel *)entity;



//清空用户信息
+ (void)cleanUserInfo;

//获取用户信息
+ (LHUserInfoModel *)getUserInfo;

//判断用户是否登录
+ (BOOL)isLoad;




#pragma mark - UserDefault
///  移除userDefaults key对应的object
+ (void)removeUseDefaultsForKey:(NSString *)key;

///  保存对象到userDefaults
+ (void)saveUseDefaultsOjbect:(id)obj forKey:(NSString *)key;

///  从userDefaults获取对象
+ (id)getUseDefaultsOjbectForKey:(NSString *)key;














@end
