//
//  LHURLHeader.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#ifndef LHURLHeader_h
#define LHURLHeader_h


#pragma mark  -----------------------  URL  -------------------------
//请求头
//#define kUrlHeader              @"http://lfeeltest.ngrok.cc/lfeel/" //本地测试环境
//#define kUrlHeader            @"http://47.92.149.182:8020/lfeel/" //服务器环境
#define kUrlHeader            @"http://120.76.215.11:8021/lfeel/" //服务器环境

//token
#define kToken                  @"e895482e-7662-4aa1-bdc7-a6fb3e806ccd"

//验证码登录
#define kVerifyLoginURL            @"vipmanagement/verifylogin"
//登录
#define kLoginURL                  @"vipmanagement/login"
//获取验证码
#define kGetVerifyURL              @"vipmanagement/getverifycode"

//注册
#define kRegistURL                 @"vipmanagement/create"

//验证码登录
#define kVerifyLogin               @"vipmanagement/verifylogin"

//忘记密码
#define kForgetPassword            @"vipmanagement/forgetpassword"


//--------------首页接口
//轮播
#define kCycleViewUrl           @"product/shuff"

//主题
#define kThemeURl               @"product/theme"

//主题下推荐三款的商品
#define kGoodsUrl               @"product/theme/products"




























#endif /* LHURLHeader_h */
