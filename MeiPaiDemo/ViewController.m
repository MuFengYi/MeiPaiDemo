//
//  ViewController.m
//  MeiPaiDemo
//
//  Created by 易 彬锋 on 16/6/6.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "EditImageViewController.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController  *imagePickerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}
- (IBAction)selectPhoto:(id)sender {
    _imagePickerController.sourceType   =   UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
- (IBAction)selectVideo:(id)sender {
    _imagePickerController.sourceType   =  UIImagePickerControllerSourceTypePhotoLibrary;
     _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage     *editImage  =   info[UIImagePickerControllerEditedImage];
        [self dismissViewControllerAnimated:YES completion:^(){
            EditImageViewController *editView   =[[EditImageViewController alloc]init];
            editView.image  =   editImage;
            UINavigationController  *navation    =   [[UINavigationController alloc]initWithRootViewController:editView];
            
            [self presentViewController:navation animated:YES completion:nil];
        }];
    }else{
    
        NSURL *url = info[UIImagePickerControllerMediaURL];
    
    }
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}


@end
