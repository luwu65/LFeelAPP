//
//  LHImagePickerViewController.h
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/8/31.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHBaseViewController.h"
typedef NS_OPTIONS(NSUInteger, LHImagePickerMediaType) {
    LHImagePickerMediaTypeCamera = 1 << 0,
    LHImagePickerMediaTypePhotoLibrary = 1 << 1
};

@interface LHImagePickerViewController : LHBaseViewController


/**
 弹出相机或相册

 @param vc 由哪个控制器modal出来
 @param libraryType 相机或相册类型，传单个或多个，传‘0’两个都选
 @param edit 是否需要裁剪
 @param complete 回调
 */
+ (void)showInViewController:(UIViewController *)vc
                 libraryType:(LHImagePickerMediaType)libraryType
                   allowEdit:(BOOL)edit
                    complete:(void(^)(UIImage *image))complete;









@end
