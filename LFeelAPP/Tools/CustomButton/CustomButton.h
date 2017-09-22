//
//  CustomButton.h
//  LehuiHomePageDemo
//
//  Created by 黄冰珂 on 2017/5/8.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton


@property (nonatomic, strong) UIImageView *titleImageView;




- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
                    imageName:(NSString *)imageName
              titleLabelFrame:(CGRect)titleLabelFrame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(CGFloat)titleFont;
//                bageLabelSize:(CGSize)bageSize;







#pragma mark --------------  上面图片 下面文字的button  ----------------
//本地图片
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title;



//加载网络图片
- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl title:(NSString *)title;





//加入会员button按钮
@property (nonatomic, strong) UIImageView *chooseImageView;//为改变选中状态

- (instancetype)initWithVipBtnFrame:(CGRect)frame;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *allMoneyLabel;
@property (nonatomic, strong) UILabel *mouthMoneyLabel;





@end
