//
//  LHPhotoPickManager.m
//  LFeelAPP
//
//  Created by 黄冰珂 on 2017/10/10.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "LHPhotoPickManager.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>

@interface LHPhotoPickManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CTAssetsPickerControllerDelegate>

// 视图控制器
@property (nonatomic, strong) UIViewController *vc;
// 选择单张图片的block回调
@property (nonatomic, copy) void(^successBlock)(UIImage *image);
// 选择多张图片的block回调
@property (nonatomic, copy) void(^successBlocks)(NSMutableArray<UIImage *> *images);
// 选择多张图片时的最大张数
@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, strong) PHFetchResult<PHAsset *> *createAssets;

@end

@implementation LHPhotoPickManager

+ (instancetype)sharedManager {
    
    static LHPhotoPickManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHPhotoPickManager alloc] init];
    });
    return manager;
}

// 保存图片到相片胶卷
- (void)saveImage:(UIImage *)image toPhotoRoll:(void(^)())successSave fail:(void(^)())failBlock {
    
    __block NSString *createdAssetId = nil;
    // 添加图片到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    if (createdAssetId == nil) {
        if (failBlock) {
            failBlock();
        }
    } else {
        if (successSave) {
            successSave();
        }
    }
    
}

// 保存图片到自定义相册
- (void)saveImage:(UIImage *)image toPhotosName:(NSString *) name success:(void (^)())successSave fail:(void (^)())failBlock {
    
    [self saveImage:image toPhotoRoll:nil fail:nil];
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createAssets;
    // 获得相册
    PHAssetCollection * createdCollection = [self createdCollectionWithName:name];
    if (createdAssets == nil || createdCollection == nil) {
        if (failBlock) {
            failBlock();
        }
        return;
    }
    
    // 将相片添加到相册
    NSError * error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    // 保存结果
    if (error) {
        if (failBlock) {
            failBlock();
        }
    } else {
        if (successSave) {
            successSave();
        }
    }
    
}

// 获得自定义相册
- (PHAssetCollection *)createdCollectionWithName:(NSString *)name {
    
    // 获取软件的名字作为相册的标题(如果需求不是要软件名称作为相册名字就可以自己把这里改成想要的名称)
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    if (name) {
        title = name;
    }
    
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    // 代码执行到这里， 说明还没有自定义相册
    __block NSString *createdCollectionId = nil;
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    if (createdCollectionId == nil) {
        return nil;
    }
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
    
}



#pragma mark - ================================选择单张图片
// 选择单张图片
- (void)getImageInView:(UIViewController *)vc successBlock:(void(^)(UIImage *image))successBlock {
    
    self.vc = vc;
    self.successBlock = successBlock;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self readImageFromLibrary];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self readImageFromCamera];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}

//UIImagePickerControllerSourceTypePhotoLibrary, 从所有相册中选择图片
//UIImagePickerControllerSourceTypeCamera, 利用照相机拍一张图片（自定义照相机AVCaptureSession）
//UIImagePickerControllerSourceTypeSavedPhotosAlbum 从Moments相册中选择图片

//从图库中读取照片
- (void)readImageFromLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self;//指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
    imagePicker.allowsEditing = YES;//设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    [self.vc presentViewController:imagePicker animated:YES completion:nil];//显示相册
    
}

//拍照
- (void)readImageFromCamera {
    //判断选择的模式是否为相机模式，如果没有弹窗警告
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;//允许编辑
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self.vc presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action1];
        [self.vc presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (self.successBlock) {
        self.successBlock(image);
    }
    
}

#pragma mark - =========================选择多张图片
// 选择多张图片  0为不限张数
- (void)getImagesInView:(UIViewController *)vc maxCount:(NSInteger)maxCount successBlock:(void(^)(NSMutableArray<UIImage *> *images))successBlock {
    
    self.vc = vc;
    self.maxCount = maxCount;
    self.successBlocks = successBlock;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.delegate = self;
            // 显示选择的索引
            picker.showsSelectionIndex = YES;
            // 显示相册的类型： 相机胶卷+自定义相册
            picker.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeAny)];
            // 不需要显示空的相册
            picker.showsEmptyAlbums = NO;
            [vc presentViewController:picker animated:YES completion:nil];
            
        });
    }];
    
}

#pragma mark - CTAssetsPickerControllerDelegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset {
    
    if (self.maxCount != 0) {
        if (picker.selectedAssets.count >= self.maxCount) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%ld张照片", (long)self.maxCount] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
            [picker presentViewController:alert animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
    
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets {
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 基本配置
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    NSMutableArray *images = [NSMutableArray array];
    // 遍历选择所有的图片
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
        // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImage *image = result;
            [images addObject:image];
            
            if (i == assets.count - 1) {
                if (self.successBlocks) {
                    self.successBlocks(images);
                }
            }
        }];
    }
}


@end
