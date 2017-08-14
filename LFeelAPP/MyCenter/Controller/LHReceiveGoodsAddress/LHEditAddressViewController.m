//
//  LHEditAddressViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditAddressViewController.h"
#import "LHCityChooseView.h"
@interface LHEditAddressViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UITableView *editTableView;
@property (nonatomic, strong) UITextField *textField;//输入框
@property (nonatomic, strong) UILabel *addressLabel;//展示省市区


@end

@implementation LHEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];

    
    
    [self setHBK_NavigationBar];
}
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"新增地址" backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setUI {
    self.editTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.editTableView.scrollEnabled = NO;
    self.editTableView.dataSource = self;
    self.editTableView.delegate = self;
    [self.view addSubview:self.editTableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-45*kRatio*4)];
    footerView.backgroundColor = kColor(245, 245, 245);
    //给footerView添加手势, 回收键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(handleTableFooterViewAction)];
    [footerView addGestureRecognizer:tap];
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [submitBtn setTitle:@"保存地址" forState:(UIControlStateNormal)];
    submitBtn.layer.borderColor = [UIColor redColor].CGColor;
    submitBtn.layer.borderWidth = 1;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    submitBtn.frame = CGRectMake(50, footerView.frame.size.height-45*kRatio-30, kScreenWidth-100, 45*kRatio);
    [footerView addSubview:submitBtn];
    self.editTableView.tableFooterView = footerView;    
}

//保存地址
- (void)submitBtnAction {
    NSLog(@"保存地址");
}


//给footerView添加手势, 回收键盘
- (void)handleTableFooterViewAction {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
#pragma mark ----------------- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editTableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"editTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc] init];
    label.font = kFont(14);
    label.text = @[@"收货人姓名", @"手机号码", @"省市区", @"详细地址"][indexPath.row];
    label.textColor = [UIColor blackColor];
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(10);
        make.width.mas_equalTo(90*kRatio);
        make.height.mas_equalTo(cell.mas_height);
        make.centerY.equalTo(cell.mas_centerY);
    }];
    if (indexPath.row != 2) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = kFont(15);
        if (indexPath.row == 0) {
            _textField.placeholder = @"请输入姓名";
        } else if (indexPath.row == 1) {
            _textField.placeholder = @"请输入电话号码";
        } else {
            _textField.placeholder = @"请输入详细地址";
        }
        [cell addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(0);
            make.right.equalTo(cell.mas_right).offset(-5);
            make.height.mas_equalTo(cell.mas_height);
            make.centerY.equalTo(cell.mas_centerY);
        }];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentRight;
        _addressLabel.font = kFont(15);
        [cell addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(0);
            make.right.equalTo(cell.mas_right).offset(-30);
            make.height.mas_equalTo(cell.mas_height);
            make.centerY.equalTo(cell.mas_centerY);
        }];
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45*kRatio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        LHCityChooseView * cityView = [[LHCityChooseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) weakSelf = self;
        cityView.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            NSLog(@"%@%@%@",province,city,area);
        };
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview: cityView];
        [window bringSubviewToFront:cityView];
        
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
