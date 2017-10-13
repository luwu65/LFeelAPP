//
//  LHAddCommentView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHAddCommentView.h"
#import "LHPhotoCommentCell.h"
@interface LHAddCommentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>




@end

@implementation LHAddCommentView



- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_cornerRadius];
    self.photoArray = [NSMutableArray new];
    
    [self setUI];
    
    
}

- (void)setPhotoArray:(NSMutableArray *)photoArray {
    NSLog(@"------------%ld", photoArray.count);
    _photoArray = photoArray;

    [self updateLayout];
}


+ (instancetype)creatView {
    return [self creatViewFromNibName:@"LHAddCommentView" atIndex:0];
}

- (void)setUI {
    
    self.commentCollectionView.dataSource = self;
    self.commentCollectionView.delegate = self;
    
    [self.commentCollectionView registerNib:[UINib nibWithNibName:@"LHPhotoCommentCell" bundle:nil] forCellWithReuseIdentifier:@"LHPhotoCommentCell"];
    
    self.commentTextView = [[HBKTextView alloc] initWithFrame:CGRectMake(self.goodsImageView.maxX+10, 10, kScreenWidth-self.goodsImageView.maxX+10, self.goodsImageView.height)];
    self.commentTextView.placeHolder = @"请输入评论...";
    self.commentTextView.layer.borderColor = [UIColor clearColor].CGColor;
    self.commentTextView.layer.borderWidth = 0;
    [self addSubview:self.commentTextView];
    
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn setBackgroundImage:kImage(@"Order_AddImage") forState:(UIControlStateNormal)];
    self.addBtn.frame = CGRectMake(10, 10, (kScreenWidth-kFit(40))/3-20, (kScreenWidth-kFit(40))/3-20);
    [self.addBtn addTarget:self action:@selector(addPhoto) forControlEvents:(UIControlEventTouchUpInside)];
    [self.commentCollectionView addSubview:self.addBtn];
}


- (instancetype)init {
    if (self = [super init]) {
        [self setUI];
    }
    return self;
}

#pragma mark ------------ <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photoArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LHPhotoCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHPhotoCommentCell" forIndexPath:indexPath];
    kWeakSelf(self);
    cell.photoImageView.image = self.photoArray[indexPath.row];
    cell.DeleteBlock = ^{
        kStrongSelf(self);
        [self.photoArray removeObjectAtIndex:indexPath.row];
        [self updateLayout];
        
    };
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-kFit(40))/3, (kScreenWidth-kFit(40))/3);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
        return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
        return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


/**
 更新约束
 */
- (void)updateLayout {
    if (_photoArray.count == 3) {
        self.addBtn.hidden = YES;
    } else {
        self.addBtn.hidden = NO;
    }
    [self.commentCollectionView reloadData];
    self.addBtn.frame = CGRectMake(20+(10+(kScreenWidth-40)/3)*(self.photoArray.count%3), self.commentCollectionView.frame.size.height-(kScreenWidth-40)/3-10,(kScreenWidth-40)/3-20,(kScreenWidth-40)/3-20);
}



/**
 添加照片
 */
- (void)addPhoto {
    if (self.ClickBlock) {
        self.ClickBlock();
    }
}









@end
















