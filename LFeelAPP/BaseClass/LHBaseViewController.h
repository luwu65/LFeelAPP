//
//  LHBaseViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LHBaseViewController : UIViewController





//显示loading动画
- (void)showProgressHUD;


//隐藏loading动画
- (void)hideProgressHUD;


//显示带有文字的loading
- (void)showProgressHUDWithTitle:(NSString *_Nullable)title;






//提示框
- (void)showAlertViewWithTitle:(NSString *_Nullable)title;


//带点击事件的提示框
- (void)showAlertViewWithTitle:(NSString *_Nullable)title
                    yesHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))yesHandler
                     noHandler:(void (^ __nullable)(UIAlertAction * _Nullable action))noHandler;



// 开启倒计时效果
-(void)openCountdown:(UIButton *_Nullable)sender;



#pragma mark  ------  根据透明度绘制图片
- (UIImage *_Nullable)drawPngImageWithAlpha:(CGFloat)alpha;



//进入客服界面
- (void)openZCServiceWithProduct:(id _Nullable )productInfo;


















@end
