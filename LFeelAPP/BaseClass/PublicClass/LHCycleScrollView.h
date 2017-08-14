//
//  LHCycleScrollView.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickCycleViewBlock)(NSInteger index);
//首页轮播
@interface LHHomeCycleView : UIView<SDCycleScrollViewDelegate>

/*
 专业搭配师
 */
@property (nonatomic, strong) UIButton *professMatchBtn;

/*
 不限次换穿
 */
@property (nonatomic, strong) UIButton *exchangeWearBtn;

/*
 五星级清洗
 */
@property (nonatomic, strong) UIButton *cleanBtn;

//轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleView;


/**
 轮播图
 @param frame 整体的大小
 @param imageFrame 轮播图的大小
 @param placeholderImage 轮播图占位图
 @param buttonTitleArray button的标题
 @param buttonImageArray button的图片
 */
- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame placeholderImage:(NSString *)placeholderImage buttonTitle:(NSArray *)buttonTitleArray buttonImage:(NSArray *)buttonImageArray;



@property (nonatomic, copy) ClickCycleViewBlock clickCycleBlock;


- (void)clickCycleBlock:(ClickCycleViewBlock)clickCycleBlock;


@end







#pragma mark  -------------------   商品详情轮播  --------------------------
//商品详情轮播
@interface LHRentGoodsDetailCycleView : UIView<SDCycleScrollViewDelegate>

/**
 ------------------  租赁 --------------------
 商品详情轮播图
 @param frame 整体的大小
 @param imageFrame 轮播图的大小
 */
- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
             placeHolderImage:(UIImage *)placeHolderImage;


//轮播图
@property (nonatomic, strong) SDCycleScrollView *rentCycleView;

//标题
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) ClickCycleViewBlock clickCycleBlock;

/*
 传入size的数组, 显示衣服的size
 */
@property (nonatomic, strong) NSMutableArray *sizeArray;

- (void)clickCycleBlock:(ClickCycleViewBlock)clickCycleBlock;



@end















