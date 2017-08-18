//
//  LHChooseTypeView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/17.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHChooseTypeView.h"
#import "LHTagView.h"

@interface LHChooseTypeView ()

@property (nonatomic, strong) NSMutableArray *selectArray;

@property (nonatomic, copy) NSString *sizeStr;
@property (nonatomic, copy) NSString *colorStr;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, copy) NSString *styleStr;




@end


@implementation LHChooseTypeView

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 5; i++) {
            LHDevider *devider = [[LHDevider alloc] initWithFrame:CGRectMake(0, i*kFit(40) + kFit(40), kScreenWidth, 0.5)];
            [self addSubview:devider];
        }
        @weakify(self);
        LHTagView *sizeTagView = [[LHTagView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFit(40)) TxtArray:kClothesSize];
        sizeTagView.contentView.tag = kChooseClothesTag + 100;
        sizeTagView.ClickTagBlock = ^(NSInteger index) {
            @strongify(self);
            self.sizeStr = kClothesSize[index];
//            NSLog(@"%@ --->%ld -----> %@", kClothesSize[index], index, self.selectArray);
        };
        [self addSubview:sizeTagView];
        
        NSArray *colorArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
        LHTagView *colorTagView = [[LHTagView alloc] initWithFrame:CGRectMake(0, kFit(40), kScreenWidth, kFit(40)) ColorArray:colorArray];
        colorTagView.contentView.tag = kChooseClothesTag + 200;
        colorTagView.ClickTagBlock = ^(NSInteger index) {
            @strongify(self);
            self.colorStr = colorArray[index];
//            NSLog(@"%@ --->%ld -----> %@", colorArray[index], index, self.selectArray);
        };
        [self addSubview:colorTagView];
        
        LHTagView *typeTagView = [[LHTagView alloc] initWithFrame:CGRectMake(0, kFit(40)*2, kScreenWidth, kFit(40)) TxtArray:kClothtsType];
        typeTagView.contentView.tag = kChooseClothesTag + 300;
        typeTagView.ClickTagBlock = ^(NSInteger index) {
            @strongify(self);
            self.typeStr = kClothtsType[index];
//            NSLog(@"%@ --->%ld -----> %@", kClothtsType[index], index, self.selectArray);
        };
        
        [self addSubview:typeTagView];
        
        LHTagView *styleTagView = [[LHTagView alloc] initWithFrame:CGRectMake(0, kFit(40)*3, kScreenWidth, kFit(40)) TxtArray:kClothesStyle];
        styleTagView.contentView.tag = kChooseClothesTag + 400;
        styleTagView.ClickTagBlock = ^(NSInteger index) {
            @strongify(self);
            self.styleStr = kClothesStyle[index];
//            NSLog(@"%@ --->%ld -----> %@", kClothesStyle[index], index, self.selectArray);
        };
        [self addSubview:styleTagView];
        
        UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        submitBtn.frame = CGRectMake(0, kFit(40)*4, kScreenWidth, kFit(40));
        [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [submitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        submitBtn.backgroundColor = kColor(245, 245, 245);
        [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:submitBtn];
        
        
    }
    return self;
}



- (void)submitBtnAction {
    if (self.sizeStr) {
        if (![self.selectArray containsObject:self.sizeStr]) {
            [self.selectArray addObject:self.sizeStr];
        }
    }
    if (self.colorStr) {
        if (![self.selectArray containsObject:self.colorStr]) {
             [self.selectArray addObject:self.colorStr];
        }
    }
    if (self.typeStr) {
        if (![self.selectArray containsObject:self.typeStr]) {
            [self.selectArray addObject:self.typeStr];
        }
        
    }
    if (self.styleStr) {
        if (![self.selectArray containsObject:self.styleStr]) {
            [self.selectArray addObject:self.styleStr];
        }
    }
    NSLog(@"------%@", self.selectArray);
    if (self.ClickSubmitBlock) {
        self.ClickSubmitBlock(self.selectArray);
    }
}




@end
