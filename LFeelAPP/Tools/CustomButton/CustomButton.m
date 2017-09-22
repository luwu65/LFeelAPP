//
//  CustomButton.m
//  LehuiHomePageDemo
//
//  Created by 黄冰珂 on 2017/5/8.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton





- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
                    imageName:(NSString *)imageName
              titleLabelFrame:(CGRect)titleLabelFrame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(CGFloat)titleFont {
    if (self = [super initWithFrame:frame]) {
        _titleImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        _titleImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_titleImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        titleLabel.text = title;
        titleLabel.font = kFont(titleFont);
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(((kScreenWidth/4)-30*kRatio)/2, 10, 30*kRatio, 30*kRatio);
        [self addSubview:imageView];

        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 10+30*kRatio, frame.size.width, 20*kRatio);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12*kRatio];
        [self addSubview:label];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        imageView.center = CGPointMake(frame.origin.x, frame.origin.y-10);
        imageView.frame = CGRectMake(0, 0, 30, 30);
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.center = CGPointMake(frame.origin.x, frame.origin.y+5);
        label.frame = CGRectMake(0, 0, frame.size.width, 20);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
        
    }
    return self;
}




- (instancetype)initWithVipBtnFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.timeLabel = [[UILabel alloc] init];
//        self.timeLabel.text = timeStr;
        self.timeLabel.font = kFont(15);
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.height.mas_offset(25);
            make.width.mas_equalTo(150);
        }];
        
        self.mouthMoneyLabel = [[UILabel alloc] init];
//        self.mouthMoneyLabel.text = [NSString stringWithFormat:@"分期: ￥%ld/月", (long)[rmbStr integerValue]];;
        self.mouthMoneyLabel.textColor = [UIColor lightGrayColor];
        self.mouthMoneyLabel.font = kFont(15);
        [self addSubview:self.mouthMoneyLabel];
        [self.mouthMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(150);
        }];
        
        self.chooseImageView = [[UIImageView alloc] init];
        self.chooseImageView.image = [UIImage imageNamed:@"MyBox_click_default"];
        [self addSubview:self.chooseImageView];
        [self.chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        
        self.allMoneyLabel = [[UILabel alloc] init];
//        self.allMoneyLabel.text = [NSString stringWithFormat:@"￥%ld", [rmbStr integerValue]*[timeStr integerValue]];
        self.allMoneyLabel.font = kFont(15);
        self.allMoneyLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.allMoneyLabel];
        [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.chooseImageView.mas_left).offset(-10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(100);
        }];
        
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.x < self.titleLabel.x) {
        
        self.titleLabel.x = self.imageView.x;
        
        self.imageView.x = self.titleLabel.maxX + 5;
    }
    
    
    
}


@end
