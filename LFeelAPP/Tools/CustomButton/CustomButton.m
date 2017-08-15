//
//  CustomButton.m
//  LehuiHomePageDemo
//
//  Created by 黄冰珂 on 2017/5/8.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "CustomButton.h"


#define kRedViewTag    1001

@implementation CustomButton





- (instancetype)initWithFrame:(CGRect)frame
                   imageFrame:(CGRect)imageFrame
                    imageName:(NSString *)imageName
              titleLabelFrame:(CGRect)titleLabelFrame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(CGFloat)titleFont {
//                bageLabelSize:(CGSize)bageSize {
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




- (instancetype)initWithFrame:(CGRect)frame time:(NSString *)timeStr rmb:(NSString *)rmbStr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = timeStr;
        timeLabel.font = kFont(15);
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.height.mas_offset(25);
            make.width.mas_equalTo(150);
        }];
        
        UILabel *rmbLabel = [[UILabel alloc] init];
        rmbLabel.text = [NSString stringWithFormat:@"分期: ￥%ld/月", [rmbStr integerValue]];;
        rmbLabel.textColor = [UIColor lightGrayColor];
        rmbLabel.font = kFont(15);
        [self addSubview:rmbLabel];
        [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(timeLabel.mas_bottom).offset(10);
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
        
        UILabel *allRmb = [[UILabel alloc] init];
        allRmb.text = [NSString stringWithFormat:@"￥%ld", [rmbStr integerValue]*[timeStr integerValue]];
        allRmb.font = kFont(15);
        allRmb.textAlignment = NSTextAlignmentRight;
        [self addSubview:allRmb];
        [allRmb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.chooseImageView.mas_left).offset(-10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(100);
        }];
        
        
    }
    return self;
}





@end
