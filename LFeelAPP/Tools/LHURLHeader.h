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
#define kUrlHeader              @"http://lfeeltest.ngrok.cc/lfeel/" //本地测试环境
//#define kUrlHeader            @"http://47.92.149.182:8020/lfeel/" //服务器环境
//#define kUrlHeader            @"http://120.76.215.11:8021/lfeel/" //服务器环境

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

//主题下推荐三款的商品 首页加limit限制3件, 左滑右滑不做限制, 全部显示出来
#define kGoodsUrl               @"product/theme/products"



// -------------- 新品购买
//type 0 --> 购买的商品; 1 --> 租赁的商品

//商品列表
#define kNewGoodsListUrl        @"product/getList"

//商品类别 左边TableView
#define kCategoryListUrl        @"category/getchildren"

//某一类别下的子标题  比如男装下的 上衣 裤子
#define kCategoryDetailListUrl  @"category/getchildren"

//添加收藏
#define kCollectionGoodsUrl     @"collection/add"

//删除收藏
#define kUncollectionGoodsUrl   @"collection/delete"

//收藏列表
#define kCollectionListUrl      @"collection/getList"

//添加地址
#define kAddAddressUrl          @"addr/add"









#endif /* LHURLHeader_h */
