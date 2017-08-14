//
//  LHGoodsCommentHeaderFooterView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/7/28.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHGoodsCommentHeaderFooterView.h"

@implementation LHGoodsCommentHeaderView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth, 40)];
        self.titleLabel.font = kFont(17*kRatio);
        [self addSubview:_titleLabel];
        
        
    }
    return self;
}



@end



//-----------------------------------------------------------------------------------------------------------------------


@implementation LHGoodsCommentFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.allCommentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.allCommentBtn setTitle:@"查看全部评论" forState:(UIControlStateNormal)];
        [self.allCommentBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        self.allCommentBtn.layer.cornerRadius = 2;
        self.allCommentBtn.layer.masksToBounds = YES;
        self.allCommentBtn.layer.borderWidth = 1;
        self.allCommentBtn.titleLabel.font = kFont(kFit(13));
        self.allCommentBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.allCommentBtn.frame = CGRectMake((kScreenWidth-150)/2, 20, 150, 30);
        [self.allCommentBtn addTarget:self action:@selector(allBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.allCommentBtn];
//        [self.allCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(kFit(150));
//            make.height.mas_equalTo(kFit(40));
//            make.centerY.mas_equalTo(self.mas_centerY);
//            make.centerX.mas_equalTo(self.mas_centerX);
//        }];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 15)];
        lineView.backgroundColor = kColor(245, 245, 245);
        [self addSubview:lineView];
        
    }
    return self;
}
- (void)clickAllBtn:(ClickAllBtnBlock)block {
    self.clickAllBtn = block;
}

- (void)allBtnAction {
    if (self.clickAllBtn) {
        self.clickAllBtn();
    }
}



@end



