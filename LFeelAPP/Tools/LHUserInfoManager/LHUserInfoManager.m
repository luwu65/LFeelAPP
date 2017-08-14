//
//  LHUserInfoManager.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/19.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoManager.h"

#define KEY   @"USERINFO"

static LHUserInfoModel *shareManager = nil;

@implementation LHUserInfoManager





//保存用户信息
+ (void)saveUserInfoWithModel:(LHUserInfoModel *)entity {
    //NSUserDefaults 继承于NSObject, 单例设计模式, 存储信息采用键值对的形式
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    //将实体归档成data数据
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:entity];
    [userD setObject:data forKey:KEY];
    //同步数据  NSUserDefaults 不是立即写入, 写完之后需要同步一下
    [userD synchronize];
    
    
}



//清空用户信息
+ (void)cleanUserInfo {
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    //
    [userD removeObjectForKey:KEY];
    //
    [userD synchronize];
    
    shareManager = nil;
    
}

//获取用户信息
+ (LHUserInfoModel *)getUserInfo {
    //如果之前取过就不在取直接返回, 否则从沙盒中去查找
    if (!shareManager) {
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        //取出来用户信息
        NSData *data = [userD objectForKey:KEY];
        //如果data存在, 反归档
        if (data) {
            shareManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else {
            shareManager = nil;
        }
    }
    return shareManager;
}

//判断用户是否登录
+ (BOOL)isLoad {
    LHUserInfoModel *model = [self getUserInfo];
    if (!model) {
        return NO;
    }
    return YES;
}






+ (void)removeUseDefaultsForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

///  保存对象到userDefaults
+ (void)saveUseDefaultsOjbect:(id)obj forKey:(NSString *)key {
    
    [self removeUseDefaultsForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

///  从userDefaults获取对象
+ (id)getUseDefaultsOjbectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}















@end
