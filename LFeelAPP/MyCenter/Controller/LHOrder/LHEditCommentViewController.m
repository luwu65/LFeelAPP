//
//  LHEditCommentViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/9/27.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHEditCommentViewController.h"
#import "LHEditCommentCell.h"
@interface LHEditCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *editTableView;

@end

@implementation LHEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHBK_NavigationBar];
    [self setEditCommentView];
    
}

#pragma mark ---------------------  UI -------------------
- (void)setHBK_NavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hbk_navgationBar = [HBK_NavigationBar HBK_setupNavigationBarWithTitle:@"评价" backAction:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } rightFirst:@"发表" rightFirstBtnAction:^{
        
    }];
}

- (void)setEditCommentView {
    self.editTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.editTableView.delegate = self;
    self.editTableView.dataSource = self;
    [self.view addSubview: self.editTableView];
    
    
}
#pragma mark ------------------ UITableViewDelegate, UITableViewDataSource ----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"LHEditCommentCell";
    LHEditCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LHEditCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    @weakify(cell);
    cell.SelectImageBlock = ^{
        @strongify(cell);
        [self selectPhotoWithCell:cell];
        
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (kScreenWidth-kFit(40))/3 + kFit(150);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}


#pragma mark ------------------------Action ----------------------

- (void)selectPhotoWithCell:(LHEditCommentCell *)cell {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypeCamera) allowEdit:YES complete:^(UIImage *image) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    CGPoint point = cell.addImageView.center;
                    point.x += (kScreenWidth-kFit(40))/3 + kFit(10);
                    cell.addImageView.center = point;
                    
                } completion:^(BOOL finished) {
                    cell.secondImageView.image = image;
                    cell.secondImageView.deleteButton.hidden = NO;
                }];
                
                
                
                
            }];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册选择照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [LHImagePickerViewController showInViewController:self libraryType:(LHImagePickerMediaTypePhotoLibrary) allowEdit:YES complete:^(UIImage *image) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    CGPoint point = cell.addImageView.center;
                    point.x += (kScreenWidth-kFit(40))/3 + kFit(10);
                    cell.addImageView.center = point;
                    
                } completion:^(BOOL finished) {
                    cell.secondImageView.image = image;
                    
                }];
            }];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}



#pragma mark ------------------------ 网路请求 ---------------------











































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
