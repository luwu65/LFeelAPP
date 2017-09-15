//
//  LHHomeTableViewCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/13.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHHomeTableViewCell.h"
#import "LHBuyNewCollectionViewCell.h"
@interface LHHomeTableViewCell ()



@end

@implementation LHHomeTableViewCell
- (NSMutableArray *)themeArray {
    if (!_themeArray) {
        self.themeArray = [NSMutableArray array];
    }
    return _themeArray;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getThemeDataArray:(NSMutableArray *)array {
    self.themeArray = array;
    self.specialCollectionView.dataSource = self;
    self.specialCollectionView.delegate = self;
    [self.specialCollectionView reloadData];
}


//顾客须知
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier newCustomerWithCollectionFrame:(CGRect)collectionRect {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUIWithCellFrame:collectionRect collecitonViewName:@"buyNewCollectionView"];
    }
    return self;
}

//专题
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier recommendSpecialWithCollectionFrame:(CGRect)collectionRect {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUIWithCellFrame:collectionRect collecitonViewName:@"specialCollectionView"];
        

    }
    return self;
}

//商品
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier goodsCollectionFrame:(CGRect)collectionRect {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.homeTitleView = [[LHHomeTitleView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50*kRatio) chinese:@"" chineseFont:16*kRatio english:@"" englishFont:14*kRatio];
        [self addSubview:self.homeTitleView];
        self.goodsScrollView = [[UIScrollView alloc] init];
        self.goodsImageView.backgroundColor = kColor(245, 245, 245);
        self.goodsScrollView.contentSize = CGSizeMake((kScreenWidth + 65), (kScreenWidth+45)*4/9);
        self.goodsScrollView.userInteractionEnabled = NO;
        [self.contentView addGestureRecognizer:self.goodsScrollView.panGestureRecognizer];
        [self addSubview:self.goodsScrollView];
        [self.goodsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self).offset(kRatio*50);
            make.bottom.equalTo(self).offset(0);
        }];
        
        for (int i = 0; i < 3; i++) {
            self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(kScreenWidth+45)/3 + (i + 1)*5, 0, (kScreenWidth + 45)/3, (kScreenWidth+45)*4/9)];
            self.goodsImageView.tag = kHomeTag + 100 + i;
            self.goodsScrollView.delegate = self;
            [self.goodsScrollView addSubview:self.goodsImageView];
            self.goodsImageView.userInteractionEnabled = YES;
            
            self.brandBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [self.brandBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [self.brandBtn setBackgroundImage:kImage(@"Home_brand_bgView") forState:(UIControlStateNormal)];
            [self.brandBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            self.brandBtn.titleLabel.font = kFont(15);
            self.brandBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -10, 0);
            self.brandBtn.tag = kHomeTag + 200 + i;
            [self.goodsImageView addSubview:self.brandBtn];
            [self.brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.goodsImageView).offset(0);
                make.right.equalTo(self.goodsImageView).offset(0);
                make.bottom.equalTo(self.goodsImageView).offset(0);
                make.height.mas_equalTo(25*kRatio);
            }];
            
        }
    }
    return self;
}

- (void)setUIWithCellFrame:(CGRect)CollectionRect collecitonViewName:(NSString *)collectionViewName{
    self.homeTitleView = [[LHHomeTitleView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50*kRatio) chinese:@"" chineseFont:16*kRatio english:@"" englishFont:14*kRatio];
    [self addSubview:self.homeTitleView];
    
    if ([collectionViewName isEqualToString:@"buyNewCollectionView"]) {
        UICollectionViewFlowLayout *buyLayout = [[UICollectionViewFlowLayout alloc] init];
        buyLayout.minimumLineSpacing = 5;
        buyLayout.minimumInteritemSpacing = 5;
        buyLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        buyLayout.itemSize = CGSizeMake(kScreenWidth*3/5, kScreenWidth*2/5);
        self.buyNewCollectionView = [[UICollectionView alloc] initWithFrame:CollectionRect collectionViewLayout:buyLayout];
        self.buyNewCollectionView.dataSource = self;
        self.buyNewCollectionView.delegate = self;
        self.buyNewCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.buyNewCollectionView];
        [self.buyNewCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.homeTitleView.mas_bottom).with.offset(0);
            make.left.equalTo(self).with.offset(5);
            make.right.equalTo(self).with.offset(-5);
            make.bottom.equalTo(self).with.offset(0);
        }];
        [self.buyNewCollectionView registerNib:[UINib nibWithNibName:@"LHBuyNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LHBuyNewCollectionViewCell"];
        
    } else if ([collectionViewName isEqualToString:@"specialCollectionView"]) {
        UICollectionViewFlowLayout *sLayout = [[UICollectionViewFlowLayout alloc] init];
        sLayout.minimumLineSpacing = 5;
        sLayout.minimumInteritemSpacing = 5;
        sLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        sLayout.itemSize = CGSizeMake(kScreenWidth*3/5, kScreenWidth*4/5);
        self.specialCollectionView = [[UICollectionView alloc] initWithFrame:CollectionRect collectionViewLayout:sLayout];
        self.specialCollectionView.backgroundColor = [UIColor yellowColor];

        [self addSubview:self.specialCollectionView];
        [self.specialCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.homeTitleView.mas_bottom).with.offset(0);
            make.left.equalTo(self).with.offset(5);
            make.right.equalTo(self).with.offset(-5);
            make.bottom.equalTo(self).with.offset(0);
        }];
        [self.specialCollectionView registerNib:[UINib nibWithNibName:@"LHSpecialCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LHSpecialCollectionViewCell"];
        
    }

    
}

#pragma mark ------- UICollectionViewDelegate --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.buyNewCollectionView) {
        return 4;
    } else {
        return _themeArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.buyNewCollectionView) {
        LHBuyNewCollectionViewCell *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHBuyNewCollectionViewCell" forIndexPath:indexPath];
        aCell.backgroundColor = [UIColor greenColor];
        NSArray *imageArray = @[@"Home_New_01", @"Home_New_02", @"Home_New_03", @"Home_New_04"];
        aCell.buyNewImageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
        return aCell;
    } else {
        LHSpecialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHSpecialCollectionViewCell" forIndexPath:indexPath];
        cell.themeModel = self.themeArray[indexPath.row];
        cell.backgroundColor = [UIColor purpleColor];

        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.buyNewCollectionView) {
        if (self.clickBuyNewBlock) {
            self.clickBuyNewBlock(indexPath);
        }
    } else {
        if (self.clickSpecialBlock) {
            self.clickSpecialBlock(indexPath);
        }
    }
}



- (void)clickSpecialCollectionViewCellBlock:(ClickSpecialCellBlock)clickSpecialBlock {
    self.clickSpecialBlock = clickSpecialBlock;
}

- (void)clickBuyNewCollectionViewCellBlock:(ClickBuyNewCellBlock)clickBuyNewBlock {
    self.clickBuyNewBlock = clickBuyNewBlock;
}



//给cell赋值
- (void)setThemesModel:(LHHomeThemesModel *)themesModel {
//    NSLog(@"-------- >>> %@", themesModel.theme_name_ch);
    if (![themesModel.theme_name_ch isKindOfClass:[NSNull class]]) {
        self.homeTitleView.chineseLabel.text = themesModel.theme_name_ch;
    }
    if (![themesModel.theme_name_en isKindOfClass:[NSNull class]]) {
        self.homeTitleView.englishLael.text = themesModel.theme_name_en;
    }    
}

- (void)setThemeGoodsModel:(LHHomeThemeGoodsModel *)themeGoodsModel {
    int i = 0;
    for (NSDictionary *dic in themeGoodsModel.value) {
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~ >>> %@", dic[@"product_url"]);
        UIButton *btn = (UIButton *)[self viewWithTag:i+1200];
        if (![dic[@"brand_name"] isKindOfClass:[NSNull class]]) {
            [btn setTitle:dic[@"brand_name"] forState:(UIControlStateNormal)];
        }
        UIImageView *imageView = (UIImageView *)[self viewWithTag:1100+i];
        if (![dic[@"product_url"] isKindOfClass: [NSNull class]]) {
//            NSLog(@"--------->>> %@", dic[@"product_url"]);
            [imageView sd_setImageWithURL:kURL(dic[@"product_url"]) placeholderImage:kImage(@"")];
        } else {
            imageView.image = kImage(@"BgImage");
            
        }
        i++;
    }
}










- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
