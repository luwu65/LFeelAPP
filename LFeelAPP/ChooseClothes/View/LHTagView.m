//
//  LHTagView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/17.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHTagView.h"


@interface LHTagView ()

/**
 所有的button的长度, 不连间隙
 */
@property (nonatomic, assign) CGFloat AllLength;


/**
 总宽度
 */
@property (nonatomic, assign) CGFloat contentWidth;


/**
 存储上一次点击的button
 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *lastClickArray;

@end


@implementation LHTagView

- (NSMutableArray<UIButton *> *)lastClickArray {
    if (!_lastClickArray) {
        self.lastClickArray = [NSMutableArray new];
    }
    return _lastClickArray;
}

- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    if (contentWidth < kScreenWidth) {
        self.tagScrollView.contentSize = CGSizeMake(kScreenWidth, self.frame.size.height);
        self.contentView.size = CGSizeMake(kScreenWidth, self.frame.size.height);
    } else {
        self.tagScrollView.contentSize = CGSizeMake(contentWidth, self.frame.size.height);
        self.contentView.size = CGSizeMake(contentWidth, self.frame.size.height);
    }
}

- (instancetype)initWithFrame:(CGRect)frame TxtArray:(NSArray *)txtArray {
    if (self = [super initWithFrame:frame]) {

        self.tagScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tagScrollView.contentSize = CGSizeMake(CGFLOAT_MAX, self.size.height);
        self.tagScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.tagScrollView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, self.frame.size.height)];
        [self.tagScrollView addSubview:self.contentView];

        for (int i = 0; i < txtArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:txtArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor]];
            btn.titleLabel.font = kFont(12);
            btn.tag = kChooseClothesTag + i;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat length = [txtArray[i] boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            if (i == 0) {
                 btn.frame = CGRectMake(10, (self.frame.size.height- kFit(20))/2, length+20, kFit(20));
            } else {
                btn.frame = CGRectMake(10 *(i + 1) + self.AllLength, (self.frame.size.height- kFit(20))/2, length+20, kFit(20));
            }
            self.AllLength += (length+20);
            
            btn.layer.cornerRadius = kFit(10);
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(handleBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.contentView addSubview:btn];
        }
        self.contentWidth = 10*(txtArray.count+1)+self.AllLength;
    }
    return self;
}

- (void)handleBtnAction:(UIButton *)sender {
    if (self.lastClickArray.count > 0) {
        if (sender.superview.tag == kChooseClothesTag + 100) {
            for (UIButton *btn in self.lastClickArray) {
                if (btn.superview.tag == kChooseClothesTag+100) {
                    btn.selected = NO;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor]];
                    [btn setImage:nil forState:(UIControlStateNormal)];
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                }
            }
            
        } else if (sender.superview.tag == kChooseClothesTag + 200) {
            for (UIButton *btn in self.lastClickArray) {
                if (btn.superview.tag == kChooseClothesTag+200) {
                    btn.selected = NO;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor]];
                    [btn setImage:nil forState:(UIControlStateNormal)];
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                }
            }
            
            
        } else if (sender.superview.tag == kChooseClothesTag + 300) {
            for (UIButton *btn in self.lastClickArray) {
                if (btn.superview.tag == kChooseClothesTag+300) {
                    btn.selected = NO;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor]];
                    [btn setImage:nil forState:(UIControlStateNormal)];
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                }
            }
            
            
        } else if (sender.superview.tag == kChooseClothesTag + 400) {
            for (UIButton *btn in self.lastClickArray) {
                if (btn.superview.tag == kChooseClothesTag+400) {
                    btn.selected = NO;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor]];
                    [btn setImage:nil forState:(UIControlStateNormal)];
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                }
            }
            
            
        }
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor]];
        [sender setImage:kImage(@"ChooseClothes_chacha") forState:(UIControlStateNormal)];
        sender.imageEdgeInsets = UIEdgeInsetsMake(0, sender.size.width-20 +2, 0, -sender.size.width+20-2);
        sender.titleEdgeInsets = UIEdgeInsetsMake(0, -sender.imageView.image.size.width, 0, sender.imageView.image.size.width);

    } else {
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor blackColor]];
        [sender setImage:nil forState:(UIControlStateNormal)];
        sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    if (self.ClickTagBlock) {
        self.ClickTagBlock(sender.tag-kChooseClothesTag);
    }
    
    [self.lastClickArray addObject:sender];
}

#pragma mark ---------------- 颜色 ------------------------------------

- (instancetype)initWithFrame:(CGRect)frame ColorArray:(NSArray *)colorArray {
    if (self = [super initWithFrame:frame]) {
        self.tagScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tagScrollView.contentSize = CGSizeMake(CGFLOAT_MAX, self.size.height);
        self.tagScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.tagScrollView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, self.frame.size.height)];
        [self.tagScrollView addSubview:self.contentView];
        
        for (int i = 0; i < colorArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.backgroundColor = kRandomColor;
            btn.tag = kChooseClothesTag + i;
            [btn setImage:[UIImage imageNamed:colorArray[i]] forState:(UIControlStateNormal)];
            btn.titleLabel.font = kFont(12);
            btn.frame = CGRectMake(20*(i + 1) + i *kFit(15), kFit(35)/2, kFit(15), kFit(15));
            btn.layer.cornerRadius = kFit(15/2);
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(handleColorBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.contentView addSubview:btn];
        }
    }
    return self;
}


- (void)handleColorBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.layer.borderWidth = 1;
        sender.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        sender.layer.borderWidth = 0;
    }
    
    if (self.ClickTagBlock) {
        self.ClickTagBlock(sender.tag-kChooseClothesTag);
    }
    

}


#pragma mark -----------------------------------------------------------------------------------------------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kFit(40), frame.size.height)];
        self.categoryLabel.font = kFont(15);
        [self addSubview:self.categoryLabel];
        
        self.tagScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kFit(40), 0, self.frame.size.width, self.frame.size.height)];
        self.tagScrollView.contentSize = CGSizeMake(CGFLOAT_MAX, self.size.height);
        self.tagScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.tagScrollView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, self.frame.size.height)];
        [self.tagScrollView addSubview:self.contentView];
        
    }
    return self;
}


- (void)setContentArray:(NSArray *)contentArray {
    _contentArray = contentArray;
    for (int i = 0; i < self.contentArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:self.contentArray[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor]];
        btn.titleLabel.font = kFont(13);
        btn.tag = kChooseClothesTag + i;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGFloat length = [self.contentArray[i] boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        if (i == 0) {
            btn.frame = CGRectMake(10, (self.frame.size.height- kFit(20))/2, length+30, kFit(20));
        } else {
            btn.frame = CGRectMake(10 *(i + 1) + self.AllLength, (self.frame.size.height- kFit(20))/2, length+30, kFit(20));
        }
        self.AllLength += (length+30);
        btn.layer.cornerRadius = kFit(20)/2;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:btn];
    }
    self.contentWidth = 10*(self.contentArray.count+1)+self.AllLength;
}


- (void)selectedBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor]];
        
    } else {
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor blackColor]];
        [sender setImage:nil forState:(UIControlStateNormal)];
        sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
}














@end
