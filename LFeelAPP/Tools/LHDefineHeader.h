//
//  LHDefineHeader.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#ifndef LHDefineHeader_h
#define LHDefineHeader_h

//#define kVersion

//屏幕的宽度
#define kScreenWidth            [[UIScreen mainScreen] bounds].size.width

//屏幕的高度
#define kScreenHeight           [[UIScreen mainScreen] bounds].size.height

//NavigationBar和TabBar的高度
#define kNBarTBarHeight  113

//打包和结算的高度
#define kAllBarHeight  40

//导航栏高度
#define kNavBarHeight  64

//tabBar高度
#define kTabBarHeight  49


//比例 以iPhone6 为基准
#define kRatio kScreenWidth/375

//按比例适配
#define kFit(num)       kRatio * (num)

//打印api
#define KMyLog(...) NSLog(__VA_ARGS__)

//随机颜色
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1]

//自定义颜色
#define kColor(r, g, b)         [UIColor colorWithRed:(r)/256.0 green:(g)/256.0 blue:(b)/256.0 alpha:1.0]

#define RGBColor2(r, g, b, a)   [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

//十六进制数 转UIColor
#define kColorFromRGBHexi(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kHexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

//主题颜色
//#define kThemeColor   [UIColor colorWithRed:10/256.0 green:130/256.0 blue:207/256.0 alpha:1.0]

#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

//将其他类型转换为字符串
#define kSTR(string)                    [NSString stringWithFormat:@"%@", string]

#define kUserDefaults                   [NSUserDefaults standardUserDefaults]
#define ShareApplicationDelegate        [[UIApplication sharedApplication] delegate]
#define IOS_FSystenVersion              ([[[UIDevice currentDevice] systemVersion] floatValue])

//字号
#define kFont(size)                [UIFont systemFontOfSize:size]
#define kURL(urlStr)               [NSURL URLWithString:urlStr]
#define kImage(image)              [UIImage imageNamed:image]



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




#define kHomeTag          1000



//--------------首页接口
//轮播
#define kCycleViewUrl           @"product/shuff"

//主题
#define kThemeURl               @"product/theme"

//主题下推荐三款的商品
#define kGoodsUrl               @"product/theme/products"


#pragma mark  --------------  Other --------------------

#define kShoesSize           @[@"34", @"34.5", @"35", @"35.5", @"36", @"36.5", @"37", @"37.5", @"38", @"38.5", @"39", @"39.5", @"40", @"40.5", @"41", @"41.5", @"42", @"42.5", @"43", @"43.5", @"44", @"44.5", @"45", @"45.5", @"46"]

#define kClothesSize          @[@"XS", @"S", @"M", @"L", @"XL", @"XXL"]





#endif /* LHDefineHeader_h */
