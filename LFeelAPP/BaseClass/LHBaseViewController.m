//
//  LHBaseViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
#import "LHPayResultsViewController.h"
#import "LHCaptchaLoginViewController.h"

@interface LHBaseViewController ()



@end

@implementation LHBaseViewController
//懒加载
- (MBProgressHUD *)HUD {
    if (!_HUD) {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.HUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1];
        self.HUD.contentColor = [UIColor whiteColor];
//        self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
        self.HUD.animationType = MBProgressHUDAnimationFade;
        [self.view addSubview:_HUD];
    }
    return _HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
//显示loading动画
- (void)showProgressHUD {
    [self showProgressHUDWithTitle:nil];
}



//隐藏loading动画
- (void)hideProgressHUD {
    if (self.HUD != nil) {
        //移除并置空
        [self.HUD hideAnimated:YES];
        self.HUD = nil;
    }
}


//显示带有文字的loading
- (void)showProgressHUDWithTitle:(NSString *)title {
    if (title.length == 0) {
        self.HUD.label.text = @"请稍候";
    } else {
        self.HUD.label.text  = title;
    }
    //显示loading
    [self.HUD showAnimated:YES];
}



#pragma mark --------------- 提示框 ------------------
- (void)showAlertViewWithTitle:(NSString *)title {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:sureAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
}


- (void)showAlertViewWithTitle:(NSString *)title yesHandler:(void (^ __nullable)(UIAlertAction *action))yesHandler noHandler:(void (^ __nullable)(UIAlertAction *action))noHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:yesHandler];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:noHandler];
    [alertC addAction:sureAction];
    [alertC addAction:noAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title yes:(NSString *)yes no:(NSString *)no yesHandler:(void (^ __nullable)(UIAlertAction *action))yesHandler noHandler:(void (^ __nullable)(UIAlertAction *action))noHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:(UIAlertControllerStyleAlert)];
    if (yes) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:yes style:(UIAlertActionStyleDefault) handler:yesHandler];
        [alertC addAction:sureAction];
    }
    if (no) {
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:no style:(UIAlertActionStyleCancel) handler:noHandler];
        [alertC addAction:noAction];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)showAlertSheetViewWithTitle:(NSString *_Nullable)title
                              first:(NSString *_Nullable)first
                             second:(NSString *_Nullable)second
                                 no:(NSString *_Nullable)no
                       firstHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))firstHandler
                      secondHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))secondHandler
                          noHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))noHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:(UIAlertControllerStyleActionSheet)];
    if (first) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:first style:(UIAlertActionStyleDefault) handler:firstHandler];
        [alertC addAction:sureAction];
    }
    if (second) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:second style:(UIAlertActionStyleDefault) handler:secondHandler];
        [alertC addAction:sureAction];
    }
    if (no) {
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:no style:(UIAlertActionStyleCancel) handler:noHandler];
        [alertC addAction:noAction];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}

// 开启倒计时效果
-(void)openCountdown:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    __block NSInteger time = 5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        } else {
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark  ------  根据透明度绘制图片
- (UIImage *)drawPngImageWithAlpha:(CGFloat)alpha{
    //    UIColor *color = [UIColor colorWithWhite:1.0 alpha:1.0];
    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    /**位图大小*/
    CGSize size = CGSizeMake(1, 1);
    /**绘制位图*/
    UIGraphicsBeginImageContext(size);
    /**获取当前创建的内容*/
    CGContextRef content = UIGraphicsGetCurrentContext();
    /**充满指定的颜色*/
    CGContextSetFillColorWithColor(content, color.CGColor);
    /**指定充满整个矩形*/
    CGContextFillRect(content, CGRectMake(0, 0, 1, 1));
    /**绘制image*/
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /**结束绘制*/
    UIGraphicsEndImageContext();
    return image;
}


//智齿客服
- (void)openZCServiceWithProduct:(id)productInfo {
    // 配置参数类
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    initInfo.appKey = @"8266c1ca81574caab451099dda19fcc1";
    // 将配置参数传
    [ZCLibClient getZCLibClient].libInitInfo = initInfo;
    initInfo.userId = @"";
    initInfo.phone =  @"";
    initInfo.nickName = @"";
    initInfo.userSex = @"";
    // 定义UI参数类
    ZCKitInfo *uiInfo = [ZCKitInfo new];
    if ([productInfo isKindOfClass:[ZCProductInfo class]]) {
        uiInfo.productInfo = productInfo;
    }
    uiInfo.customBannerColor = [UIColor redColor];
    uiInfo.rightChatColor = [UIColor redColor];
    uiInfo.goodSendBtnColor = [UIColor redColor];
    uiInfo.socketStatusButtonBgColor = [UIColor redColor];
    uiInfo.chatRightLinkColor = [UIColor blackColor];
    [IQKeyboardManager sharedManager].enable = NO;
    // 是否自动提醒
    [[ZCLibClient getZCLibClient] setAutoNotification:YES];
    
    [ZCSobot startZCChatView:uiInfo with:self target:nil pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        if (type == ZCPageBlockGoBack) {
            [IQKeyboardManager sharedManager].enable = YES;
        }
    } messageLinkClick:^(NSString *link) {
        NSLog(@"----点击了这个链接-------------%@---------------------", link);
        
    }];
}

#pragma mark  --------------- 支付方式 --------------------

/*
 返回码 	含义
 9000 	订单支付成功
 8000 	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 4000 	订单支付失败
 5000 	重复请求
 6001 	用户中途取消
 6002 	网络连接出错
 6004 	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
 其它 	其它支付错误
 */
//支付宝支付
- (void)payForAliPay:(NSString *)dataString {
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:dataString fromScheme:@"lfeelios" callback:^(NSDictionary *resultDic) {
        LHPayResultsViewController *payResultVC = [[LHPayResultsViewController alloc] init];
        NSLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] integerValue] == 9000) {
            NSLog(@"支付成功了~~~~~~~~~~~~~哈哈哈哈哈~~~~~~~~~~~~`");
            NSData *jsonData = [resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil];
            NSLog(@"%@", dic);
            payResultVC.resultDic = dic;
        } else if ([resultDic[@"resultStatus"] integerValue] == 6001) {
            NSLog(@"中途取消了, 跳转到支付失败的页面");
            
            
        } else if ([resultDic[@"resultStatus"] integerValue] == 5000) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请勿重复发起订单"];
            });
        }
        payResultVC.payType = 1;
        payResultVC.payResultStr = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
        [self.navigationController pushViewController:payResultVC animated:YES];
    }];
}

//微信支付
- (void)payForWXPay:(NSString *)dataString {
    //微信支付
    NSData *jsonData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"--------->>> %@", dic);
    PayReq *payreq = [[PayReq alloc] init];
    payreq.openID = dic[@"appid"];
    payreq.partnerId = dic[@"partnerid"];
    payreq.prepayId = dic[@"prepayid"];
    payreq.nonceStr = dic[@"noncestr"];
    payreq.timeStamp = [dic[@"timestamp"] intValue];
    payreq.package = dic[@"package"];
    payreq.sign = dic[@"sign"];
    
    [WXApi sendReq:payreq];
}


- (void)CaptchaLogin {
    LHCaptchaLoginViewController *loginVC = [[LHCaptchaLoginViewController alloc] init];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginVC animated:YES completion:nil];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
