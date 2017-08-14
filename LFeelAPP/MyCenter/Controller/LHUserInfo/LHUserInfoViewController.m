//
//  LHUserInfoViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/6/20.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHUserInfoViewController.h"
#import "LHUserInfoCell.h"
#import "LHPickView.h"
@interface LHUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, LHPickViewDelegate>


@property (nonatomic, strong) UITableView *userInfoTableView;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) LHPickView *datePickView;

@property (nonatomic, strong) LHPickView *linePickView;

@property (nonatomic, strong) NSMutableArray *heightArray;//身高
@property (nonatomic, strong) NSMutableArray *weightArray;//体重

@end

@implementation LHUserInfoViewController
- (NSMutableArray *)weightArray {
    if (!_weightArray) {
        self.weightArray = [NSMutableArray new];
        for (int i = 35; i < 90; i++) {
            [_weightArray addObject:[NSString stringWithFormat:@"%dKG", i]];
        }
    }
    return _weightArray;
}
- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray new];
        for (int i = 120; i < 196; i++) {
            [_heightArray addObject:[NSString stringWithFormat:@"%dCM", i]];
        }
    }
    return _heightArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        self.titleArray = [NSMutableArray arrayWithObjects:@"手机号", @"昵称", @"姓名", @"地区", @"身份证", @"性别", @"出生日期", @"鞋码", @"尺码", @"身高", @"体重", @"三围", @"邀请码", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    
    [self setUI];
    
}

- (void)setUI {
    self.userInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight) style:(UITableViewStylePlain)];
    self.userInfoTableView.dataSource = self;
    self.userInfoTableView.delegate = self;
    [self.view addSubview:self.userInfoTableView];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHUserInfoCell"];
    if (cell == nil) {
        cell = [[LHUserInfoCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"LHUserInfoCell"];
    }
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.detailTF.placeholder = @[@"请输入手机号", @"请输入昵称", @"请输入真实姓名", @"请输入地区", @"请输入身份证号", @"请选择性别", @"请选择出生日期", @"请选择鞋码", @"请选择尺码", @"请选择身高", @"请选择体重", @"请选择三围", @"请输入邀请码(选填)"][indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4) {
        
        
        
    } else {
//        cell.detailTF.userInteractionEnabled = NO;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //绑定新手机号
    } else if (indexPath.row == 3) {
        //显示地区
        
    } else if (indexPath.row == 5) {
        //性别
        [self createLineOnePickViewWithArray:@[@"男", @"女"]];
    } else if (indexPath.row == 6) {
        //日期
        [self createDatePickView];
        
        
    } else if (indexPath.row == 7) {
        //鞋码
        NSArray *sizeArr = @[@"34", @"34.5", @"35", @"35.5", @"36", @"36.5", @"37", @"37.5", @"38", @"38.5", @"39", @"39.5", @"40", @"40.5", @"41", @"41.5", @"42", @"42.5", @"43", @"43.5", @"44", @"44.5", @"45", @"45.5", @"46"];
        [self createLineOnePickViewWithArray: sizeArr];
        
        
    } else if (indexPath.row == 8) {
        //尺码
        [self createLineOnePickViewWithArray:@[@"XS", @"S", @"M", @"L", @"XL", @"XXL"]];
    } else if (indexPath.row == 9) {
        //身高
        [self createLineOnePickViewWithArray:self.heightArray];
        
    } else if (indexPath.row == 10) {
        //体重
        [self createLineOnePickViewWithArray:self.weightArray];
        
    } else if (indexPath.row == 11) {
        //三围
        
        
        
    }
}


- (void)createDatePickView {
    self.datePickView = [[LHPickView alloc] initDatePickWithDate:nil datePickerMode:(UIDatePickerModeDate) isHaveNavControler:NO];
    self.datePickView.delegate = self;
    self.datePickView.toolbarTextColor = [UIColor blackColor];
    self.datePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.datePickView show];
}

- (void)createLineOnePickViewWithArray:(NSArray *)array {
    self.linePickView = [[LHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.linePickView.delegate = self;
    self.linePickView.toolbarTextColor = [UIColor blackColor];
    self.linePickView.toolbarBGColor = kColor(245, 245, 245);
    [self.linePickView show];
}


//选中pickview走的回调
- (void)toobarDonBtnHaveClick:(LHPickView *)pickView resultString:(NSString *)resultString resultIndex:(NSInteger) index {
    if (pickView == self.datePickView) {
        NSLog(@"%@", resultString);
    }
    if (pickView == self.linePickView) {
        NSLog(@"%@", resultString);
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
