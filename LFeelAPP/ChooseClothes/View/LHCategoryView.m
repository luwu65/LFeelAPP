//
//  LHCategoryView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/21.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHCategoryView.h"
#import "LHBrondCollectionCell.h"


@interface LHCategoryView ()<UICollectionViewDelegate, UICollectionViewDataSource>



@end


@implementation LHCategoryView

- (NSMutableArray *)categoryListArray {
    if (!_categoryListArray) {
        self.categoryListArray = [NSMutableArray new];
    }
    return _categoryListArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
        
    }
    return self;
}



- (void)setUI {
    LHDevider *devider = [[LHDevider alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(15))];
    devider.backgroundColor = kColor(245, 245, 245);
    [self addSubview:devider];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kFit(15), kScreenWidth-20, kFit(25))];
    titleLabel.text = @"热门分类";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = kFont(15);
    [self addSubview:titleLabel];
    //分类列表
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.categoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.categoryCollectionView.dataSource = self;
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.showsHorizontalScrollIndicator = NO;
    self.categoryCollectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.categoryCollectionView];
    [self.categoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(titleLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    [self.categoryCollectionView registerNib:[UINib nibWithNibName:@"LHBrondCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LHBrondCollectionCell"];
    
    
    
}




#pragma mark ------------ UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.categoryListArray.count;
    return 20;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHBrondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHBrondCollectionCell" forIndexPath:indexPath];
//    cell.listModel = self.categoryListArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-30)/5, (kScreenWidth-30)/5*1.2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ClickCategoryBlock) {
        self.ClickCategoryBlock(indexPath.row);
    }
}


































@end
