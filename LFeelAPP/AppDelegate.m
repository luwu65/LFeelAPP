//
//  AppDelegate.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "AppDelegate.h"
#import "LHTabBarViewController.h"
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate ()<UNUserNotificationCenterDelegate, UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LHTabBarViewController *tabBarVC = [[LHTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [IQKeyboardManager sharedManager].enable = YES;
    
    
//    [self ZCServiceApplication:application];
    
    return YES;
}


- (void)ZCServiceApplication:(UIApplication *)application {
    //  初始化智齿客服，会建立长连接通道，监听服务端消息（建议启动应用时调用，没有发起过咨询不会浪费资源，至少转一次人工才有效果）
    [[ZCLibClient getZCLibClient] initZCIMCaht];
    // ReceivedMessageBlock 未读消息数， obj 当前消息  unRead 未读消息数
    [ZCLibClient getZCLibClient].receivedBlock=^(id obj,int unRead){
        NSLog(@"****************************未读消息数量：%d,%@",unRead,obj);
    };
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) { NSLog(@"%@", settings); }]; } else {
                    // 点击不允许
                    NSLog(@"注册失败");
                }
            
            if (!error) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }else{
        [self registerPush:application];
    }
    
    // 获取APPKEY
    NSString *APPKEY = @"8266c1ca81574caab451099dda19fcc1";
    [[ZCLibClient getZCLibClient].libInitInfo setAppKey:APPKEY];
    [[ZCLibClient getZCLibClient] setIsDebugMode:NO];
    [ZCSobot setShowDebug:NO];
}

-(void)registerPush:(UIApplication *)application{
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert |UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    //    NSLog(@"---Token--%@", pToken);
    // 注册token
    [[ZCLibClient getZCLibClient] setToken:pToken];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    //    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    //功能：可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionAlert);
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    //
    //    NSLog(@"userInfo == %@\n%@",userInfo,message);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    //    NSLog(@"Regist fail%@",error);
}
//点击推送消息后回调
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    //    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
