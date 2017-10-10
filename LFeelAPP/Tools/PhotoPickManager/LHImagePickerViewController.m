//
//  LHImagePickerViewController.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHImagePickerViewController.h"

@interface LHImagePickerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

static void (^_imageBlock)(UIImage *) = nil;
static BOOL _allowEdit = NO;
@implementation LHImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)showInViewController:(UIViewController *)vc libraryType:(LHImagePickerMediaType)media allowEdit:(BOOL)edit complete:(void (^)(UIImage *))complete {
    
    _imageBlock = [complete copy];
    _allowEdit = edit;
    
    if (media & LHImagePickerMediaTypeCamera) {
#if TARGET_IPHONE_SIMULATOR // 模拟器
        NSLog(@"模拟器不支持");
#elif TARGET_OS_IPHONE      // 真机
        [self _excute:UIImagePickerControllerSourceTypeCamera vc:vc];
#endif
    } else if (media & LHImagePickerMediaTypePhotoLibrary) {
        [self _excute:UIImagePickerControllerSourceTypePhotoLibrary vc:vc];
    } else  {
        
    }
}

+ (void)_excute:(UIImagePickerControllerSourceType)type vc:(UIViewController *)vc{
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    pickerCtrl.allowsEditing = _allowEdit;
    pickerCtrl.sourceType = type;
    pickerCtrl.delegate = [self self];
    [vc presentViewController:pickerCtrl animated:YES completion:nil];
}

#pragma mark - 代理

+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * image = nil;
    if (!_allowEdit) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    !_imageBlock ? : _imageBlock(image);
    _allowEdit = NO;
    _imageBlock = nil;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    _allowEdit = NO;
    _imageBlock = nil;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
