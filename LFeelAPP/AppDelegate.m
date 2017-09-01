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

@property (nonatomic, copy) NSString *connect;


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
    [self setUmengShare];
    self.connect = @"Connect";
    [self KVONetworkChange];
    return YES;
}

#pragma mark --------------- 友盟------------------
- (void)setUmengShare {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58307cfa82b63559950012b3"];
    
    /*
     设置微信的appKey和appSecret
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx49ee5406f2ae4192" appSecret:@"1b064bf13ad7abe92ca4833b969ee2dd" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106089815"/*设置QQ平台的appID*/  appSecret:@"Iv8uHHcFXDUIhYG7" redirectURL:@"http://redirect_url=open.weibo.com/apps/1970404034/privilege/oauth"];
    
    /*
     设置新浪的appKey和appSecret
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1970404034"  appSecret:@"44e236b1717ca5a1d13a62a6bd0edf7e" redirectURL:@"http://redirect_url=open.weibo.com/apps/1970404034/privilege/oauth"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
#pragma mark ------------- 监测网络状态 -------------

/*
 * 实时监控网络状态
 */
- (void)KVONetworkChange {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            self.connect = @"noConnect";
            [self showAlertView];
            return ;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            if ([self.connect isEqualToString: @"isConnect"]) {
                [MBProgressHUD showSuccess:@"网络连接成功"];
            }
        }
    }];
    //监控网络状态，开启监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark --提示框
- (void)showAlertView {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"呜呜~没有网络了" message:@"ಥ_ಥ" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"重试一下" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.connect = @"isConnect";
        [self KVONetworkChange];
    }];
    [alertC addAction:sureAction];
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    [alertWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
}

#pragma mark ------------ 智齿客服 ---------------
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
