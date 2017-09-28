//
//  LHPayWayView.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/11.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPayWayView.h"


#define kRowHeight  50

@interface LHPayWayView ()


@property (nonatomic, assign) NSInteger index;

@end


@implementation LHPayWayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
//        self.size = CGSizeMake(kScreenWidth, kFit(kRowHeight)*4);
        if (index) {
            self.index = index;
        }
    }
    return self;
}

- (void)setUI {
    self.payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kFit(kRowHeight)*4) style:(UITableViewStylePlain)];
    self.payTableView.dataSource = self;
    self.payTableView.delegate = self;
    [self.bgView addSubview:self.payTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHPayWayCell"];
    if (!cell) {
        cell = [[LHPayWayCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LHPayWayCell"];
        cell.nameLabel.text = @[@"信用卡分期", @"支付宝", @"微信支付", @"银联支付"][indexPath.row];
        cell.payImageView.image = [UIImage imageNamed:@[@"Pay_LeFenQi", @"Pay_AliPay", @"Pay_WeChatPay", @"Pay_UnionPay"][indexPath.row]];
    }
    if (self.index) {
        if (self.index == indexPath.row) {
            cell.clickImageView.image = kImage(@"MyBox_clicked");
        } else {
            cell.clickImageView.image = kImage(@"MyBox_click_default");
        }
    } else {
        cell.clickImageView.image = kImage(@"MyBox_click_default");
    }
    
    
    return cell;
}


- (void)clickPayWayBlock:(ClickPayWayBlock)block {
    self.clickPayBlock = block;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(kRowHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.clickPayBlock) {
        self.clickPayBlock(indexPath.row);
    }
    for (LHPayWayCell *cell in [tableView visibleCells]) {
        cell.clickImageView.image = kImage(@"MyBox_click_default");
    }
    LHPayWayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.clickImageView.image = kImage(@"MyBox_clicked");
    [tableView reloadData];
    [self remove];
}

#pragma mark - 移除控件
- (void)remove {
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.payTableView.center;
        point.y = point.y + kFit(kRowHeight)*4;
        self.payTableView.center = point;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        [self.payTableView removeFromSuperview];
        self.payTableView = nil;
    }];
}

#pragma mark - 显示控件
- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.payTableView.center;
        point.y = point.y - kFit(kRowHeight)*4;
        self.payTableView.center = point;
    }];
}
#pragma mark - 背景遮罩
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        _bgView.tag = 999;
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWindowAction)];
        tap.delegate = self;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
- (void)handleWindowAction {
    [self remove];
}

//防止手势冲突——防止UITableView的点击事件和手势事件冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 输出点击的view的类名
    // NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end



@implementation LHPayWayCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}


- (void)setUI {
    self.payImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.payImageView];
    [self.payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(kFit(24));
        make.height.mas_equalTo(kFit(24));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:kFit(15)];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payImageView.mas_right).offset(10);
        make.width.mas_equalTo(kFit(150));
        make.height.mas_equalTo(kFit(24));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.clickImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.clickImageView];
    [self.clickImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(kFit(24));
        make.height.mas_equalTo(kFit(24));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
}


@end



