//
//  LHShoppingCartCell.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/14.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHShoppingCartCell.h"

@implementation LHShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}



- (void)setUI {
    __weak typeof(self) weakSelf = self;
    //选中按钮
    self.clickBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.clickBtn];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"MyBox_click_default"] forState:(UIControlStateNormal)];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"MyBox_clicked"] forState:(UIControlStateSelected)];
    [_clickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30*kRatio);
        make.height.mas_equalTo(30*kRatio);
        make.left.mas_equalTo(15*kRatio);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    //商品图片
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_clickBtn.mas_right).offset(10*kRatio);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf.mas_top).offset(5*kRatio);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5*kRatio);
        make.width.equalTo(weakSelf.goodsImageView.mas_height).multipliedBy(1.0f);
    }];
    
    //title
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    self.titleLabel.font = kFont(14*kRatio);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5*kRatio);
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(8*kRatio);
        make.right.equalTo(weakSelf.mas_right).offset(-8*kRatio);
        make.height.mas_equalTo(20*kRatio);
    }];

    //尺码 颜色 选择属性
    self.sizeColorLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.sizeColorLabel];
    self.sizeColorLabel.font = kFont(12*kRatio);
    self.sizeColorLabel.textColor = [UIColor lightGrayColor];
    [self.sizeColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(8*kRatio);
        make.right.equalTo(weakSelf.mas_right).offset(-8*kRatio);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(5*kRatio);
        make.height.mas_equalTo(20*kRatio);
    }];

    
    //加
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.contentView addSubview:self.addBtn];
    self.addBtn.layer.borderWidth = 1;
    self.addBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.addBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.addBtn.titleLabel.font = kFont(18*kRatio);
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10*kRatio);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5*kRatio);
        make.height.mas_equalTo(25*kRatio);
        make.width.mas_equalTo(25*kRatio);
    }];
    
    //商品数量
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.numberLabel];
    self.numberLabel.text = @"0";
    self.numberLabel.font = kFont(15*kRatio);
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.addBtn.mas_left).offset(0);
        make.top.equalTo(weakSelf.addBtn.mas_top);
        make.bottom.equalTo(weakSelf.addBtn.mas_bottom);
        make.width.mas_equalTo(40*kRatio);
    }];

    //减
    self.subBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.contentView addSubview:self.subBtn];
    self.subBtn.layer.borderWidth = 1;
    self.subBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.subBtn setTitle:@"-" forState:(UIControlStateNormal)];
    [self.subBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.subBtn.titleLabel.font = kFont(18*kRatio);
    [self.subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.numberLabel.mas_left).offset(0);
        make.bottom.equalTo(weakSelf.numberLabel.mas_bottom);
        make.height.mas_equalTo(25*kRatio);
        make.width.mas_equalTo(25*kRatio);
    }];


    //价格
    self.priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.font = kFont(14*kRatio);
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(5);
        make.right.equalTo(weakSelf.subBtn.mas_left).offset(-5);
        make.top.equalTo(self.subBtn.mas_top);
        make.bottom.equalTo(self.subBtn.mas_bottom);
    }];
    
}

//选中按钮
- (void)clickBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.clickBlock) {
        self.clickBlock(sender.selected);
    }
}


//加
- (void)addBtnAction:(UIButton *)sender {
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    if (self.numberOfAddBlock) {
        self.numberOfAddBlock(count);
    }

}

//减
- (void)subBtnAction:(UIButton *)sender {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    if (self.numberSubBlock) {
        self.numberSubBlock(count);
    }
}

//重写setter方法
- (void)setNumber:(NSInteger)number {
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", number];
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.clickBtn.selected = isClick;
}


- (void)numberOfAddBlock:(NumberOfChangeBlock)block {
    self.numberOfAddBlock = block;
}

- (void)numberOfSubBlock:(NumberOfChangeBlock)block {
    self.numberSubBlock = block;
}

- (void)clickWithCellBlock:(ClickedBlock)block {
    self.clickBlock = block;
}


//- (void)setGoodsModel:(LHCartGoodsModel *)goodsModel {
//    self.titleLabel.text = goodsModel.goodsName;
//    self.numberLabel.text = [NSString stringWithFormat:@"%ld", goodsModel.count];
//    self.priceLabel.text = [NSString stringWithFormat:@"%ld", [goodsModel.realPrice integerValue]];
//    self.clickBtn.selected = self.isClick;
//}

- (void)reloadDataWithModel:(LHCartGoodsModel *)goodsModel {
    self.titleLabel.text = goodsModel.product_name;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", goodsModel.count];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2lf/件", [goodsModel.price_lfeel floatValue]];
    self.clickBtn.selected = goodsModel.isSelect;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.url] placeholderImage:kImage(@"")];
    for (int i = 0; i < goodsModel.property_value.count; i++) {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"%@", goodsModel.property_value[i]];
    }
 
    if (goodsModel.property_value.count == 1) {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"%@", goodsModel.property_value.firstObject];
    } else {
        self.sizeColorLabel.text = [NSString stringWithFormat:@"%@, %@", goodsModel.property_value.firstObject, goodsModel.property_value.lastObject];
    }
    
    
    
}











@end
