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

#define kBaseUrl            @"http://192.168.0.110:8081/lfeel/" //本地测试环境
//#define kBaseUrl            @"http://120.76.215.11:8021/lfeel/" //服务器环境

//token
#define kToken                     [LHUserInfoManager getUseDefaultsOjbectForKey:@"token"]

//验证码登录
#define kVerifyLoginURL            @"vipmanagement/verifylogin"
//登录
#define kLoginURL                  @"vipmanagement/login"
//获取验证码
#define kGetVerifyURL              @"vipmanagement/getverifycode"

//注册
#define kRegistURL                 @"vipmanagement/add"

//验证码登录
#define kVerifyLogin               @"vipmanagement/verifylogin"

//忘记密码
#define kForgetPassword            @"vipmanagement/forgetpassword"


//--------------首页接口
//轮播
#define kCycleViewUrl              @"product/shuff"

//主题
#define kThemeURl                  @"product/theme"

//主题下推荐三款的商品 首页加limit限制3件, 左滑右滑不做限制, 全部显示出来
#define kGoodsUrl                  @"product/theme/products"



// -------------- 新品购买
//type 0 --> 购买的商品; 1 --> 租赁的商品

//商品列表
#define kNewGoodsListUrl            @"product/getList"

//商品类别 左边TableView
#define kCategoryListUrl            @"category/getchildren"

//某一类别下的子标题  比如男装下的 上衣 裤子
#define kCategoryDetailListUrl      @"category/getchildren"

//添加收藏
#define kCollectionGoodsUrl         @"collection/add"

//删除收藏
#define kUncollectionGoodsUrl       @"collection/delete"

//收藏列表
#define kCollectionListUrl          @"collection/getList"

//添加地址
#define kAddAddressUrl              @"addr/add"

//修改地址
#define kAddressUpdateUrl           @"addr/update"

//删除地址
#define kAddreessDeleteUrl          @"addr/delete"

//地址列表
#define kAddressListUrl               @"addr/getList"

//加入购物车
#define kAddshoppingCartUrl           @"shoppingcar/addproduct"

//换头像
#define kUploadImageUrl               @"qiniu/upload"

//提交个人信息
#define kUpdateUserInfoUrl            @"vipmanagement/update"

//购物车列表
#define kShopppingCartListUrl         @"shoppingcar/getList"

//删除购物车
#define kDeleteShoppingCartUrl        @"shoppingcar/delete"

//更新购物车
#define kUpdateShoppingCartUrl        @"shoppingcar/update"

//结算中心列表
#define kAccOrderUrl                  @"order/beforeorder"

//提交订单
#define kSubmitOrderUrl               @"order/reservation"

//订单列表
#define kOrderListUrl                 @"order/getList"

//实名认证
#define kCertificationUrl             @"vipmanagement/identity"

//产品详情
#define kGoodsDetailUrl               @"product/findproduct?"

//打包盒子
#define kPackingBoxUrl                @"application/add"

//盒子状态
#define kBoxStatusUrl                 @"application/getStatus"

//盒子确定收货
#define kBoxReceiveGoodsUrl           @"application/update"

//乐百分发送验证码
#define kLeBaiSendCodeUrl             @"order/lbfsmsCode"

//乐百分支付
#define kLebaiPayUrl                  @"order/pay"

//银行卡列表
#define kBankListUrl                  @"bank/getList"


//确认收货
#define kComfirmGoodsUrl              @"order/update"

//评论列表
#define kCommentListUrl               @"comment/getList"

//添加银行卡
#define kAddBankCardUrl               @"bank/add"













#endif /* LHURLHeader_h */
