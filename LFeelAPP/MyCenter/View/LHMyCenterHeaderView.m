//
//  LHMyCenterHeaderView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/16.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHMyCenterHeaderView.h"

#define kIconHeight  100

@implementation LHMyCenterHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bgImageView = [[UIImageView alloc] initWithFrame:frame];
//        self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.bgImageView.clipsToBounds=YES;
        self.bgImageView.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        
        _nameButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_nameButton addTarget:self action:@selector(myCenterAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_nameButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _nameButton.titleLabel.font = kFont(kFit(13));
        [self.bgImageView addSubview:_nameButton];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kFit(100));
            make.bottom.equalTo(self.bgImageView.mas_bottom);
            make.height.mas_equalTo(kFit(40));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        _iconImageView = [[UIImageView alloc] init] ;
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.backgroundColor = [UIColor whiteColor];
        [self.bgImageView addSubview:_iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_nameButton.mas_top);
            make.width.equalTo(_nameButton.mas_width);
            make.height.equalTo(_nameButton.mas_width);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = kIconHeight*kRatio/2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myCenterAction)];
        [_iconImageView addGestureRecognizer:tap];
        
        
    }
    return self;
}

- (void)myCenterAction {
    if (self.clickIconBlock) {
        self.clickIconBlock();
    }
}

- (void)clickIconBlock:(ClickIconBlock)block {
    self.clickIconBlock = block;
}
















@end
