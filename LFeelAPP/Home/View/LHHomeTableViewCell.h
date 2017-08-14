//
//  LHHomeTableViewCell.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHSpecialCollectionViewCell.h"

#import "LHHomeTitleView.h"
#import "LHHomeModel.h"
//#import "LHHomeThemesModel.h"
//#import "LHHomeThemeGoodsModel.h"



typedef void(^ClickSpecialCellBlock)(NSIndexPath *index);

typedef void(^ClickBuyNewCellBlock)(NSIndexPath *index);

@interface LHHomeTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>


/*新手购买须知CollectionView*/
@property (nonatomic, strong) UICollectionView *buyNewCollectionView;

/*专题*/
@property (nonatomic, strong) UICollectionView *specialCollectionView;


//展示中文英文标题
@property (nonatomic, strong) LHHomeTitleView *homeTitleView;

//展示商品控件-----------------------------------------------------
@property (nonatomic, strong) UIScrollView *goodsScrollView;    //
@property (nonatomic, strong) UIImageView *goodsImageView;      //
@property (nonatomic, strong) UIButton *brandBtn;              //
//---------------------------------------------------------------
/*展示collection上数据的数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) ClickBuyNewCellBlock clickBuyNewBlock;

@property (nonatomic, copy) ClickSpecialCellBlock clickSpecialBlock;



- (void)clickBuyNewCollectionViewCellBlock:(ClickBuyNewCellBlock)clickBuyNewBlock;

- (void)clickSpecialCollectionViewCellBlock:(ClickSpecialCellBlock)clickSpecialBlock;

//新手购买
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier newCustomerWithCollectionFrame:(CGRect)collectionRect;

//精选推介
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier recommendSpecialWithCollectionFrame:(CGRect)collectionRect;

//展示商品
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier goodsCollectionFrame:(CGRect)collectionRect;




@property (nonatomic, strong) LHHomeThemesModel *themesModel;
@property (nonatomic, strong) LHHomeThemeGoodsModel *themeGoodsModel;


/*主题数组*/
@property (nonatomic, strong) NSMutableArray *themeArray;

//获取主题上数组
- (void)getThemeDataArray:(NSMutableArray *)array;



@end
