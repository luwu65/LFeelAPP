//
//  LHPhotoGroupView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/9.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPhotoGroupView.h"


@interface LHPhotoGroupView ()

@property (nonatomic, strong) NSArray *imageViewsArray;

@property (nonatomic, assign) CGFloat width;


@end

@implementation LHPhotoGroupView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width {
    if (self = [super init]) {
        NSAssert(width>0, @"请设置图片容器的宽度");
        self.width = width;
    }
    return self;
}

- (void)setup {
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = kRandomColor;
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)tapImageView:(UITapGestureRecognizer *)sender {
    
    NSLog(@"点击了");
    
}



- (void)setPicUrlArray:(NSArray *)picUrlArray {
    _picUrlArray = picUrlArray;
    for (long i = _picUrlArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    if (_picUrlArray.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        return;
    }
    CGFloat itemW = [self itemWidthForPicPathArray:_picUrlArray];
    CGFloat itemH = itemW;
    
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picUrlArray];
    CGFloat margin = 5;
    for (int i = 0; i < _picUrlArray.count; i++) {
        NSURL *obj = _picUrlArray[i];
        long columnIndex = i % perRowItemCount;
        long rowIndex = i / perRowItemCount;
        
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:obj placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image.size.width < itemW || image.size.height < itemW) {
                imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex*(itemH + margin), itemW, itemH);
    }
    int columnCount = ceilf(_picUrlArray.count *1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
}


- (CGFloat)itemWidthForPicPathArray:(NSArray *)array {
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat itemW = (self.width - 10) / 3;
        return itemW;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array {
    if (array.count < 3) {
        return array.count;
    } else if (array.count == 4) {
        return 2;
    } else {
        return 3;
    }
}















@end
