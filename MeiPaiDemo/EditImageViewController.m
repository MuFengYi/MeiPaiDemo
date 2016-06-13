//
//  EditImageViewController.m
//  MeiPaiDemo
//
//  Created by 易 彬锋 on 16/6/6.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import "EditImageViewController.h"
#import "FitlerCollectionViewCell.h"
#import "FitlerModel.h"
@interface EditImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView    *collectionView;
@property(nonatomic,strong)UIImageView  *fitlerImageView;
@property(nonatomic,strong)FitlerModel  *fitlerModel;
@property(nonatomic,strong)NSMutableArray   *fitlerModelArray;
@property(nonatomic,strong)CIFilter         *fitler;
@end

@implementation EditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryVideo];
    
    for (NSString *filterName in filterNames) {
        NSLog(@"filterName==%@",filterName);
    }
    
    self.title  =   @"编辑照片";
    
    //rewrite backbutton
    self.navigationItem.leftBarButtonItem   =   [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    // load imageView
    _fitlerImageView    =   [[UIImageView alloc]init];
    _fitlerImageView.frame  =   CGRectMake(0, 0,IPHONEWIDTH,IPHONEHEIGHIT-300);
    _fitlerImageView.contentMode    =   UIViewContentModeScaleAspectFit;
    _fitlerImageView.image  =   _image;
    [self.view addSubview:_fitlerImageView];
    
    //set fitler collectionview
    [self setCollectionView];
    _fitlerModelArray   =   [NSMutableArray array];
    [self initFitlerModelArray];
    [self.view setBackgroundColor:[UIColor cyanColor]];
}

#pragma mark back action
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark set Fitler collectionView
- (void)setCollectionView{
    
    UICollectionViewFlowLayout *layout =   [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _collectionView =   [[UICollectionView alloc]initWithFrame:CGRectMake(0, IPHONEHEIGHIT-100, IPHONEWIDTH, 100) collectionViewLayout:layout];
    _collectionView.delegate =   self;
    _collectionView.dataSource   =   self;
    [_collectionView registerNib:[UINib nibWithNibName:@"FitlerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fitlercollectioncell"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _fitlerModelArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FitlerCollectionViewCell    *fitlerCell =  (FitlerCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"fitlercollectioncell" forIndexPath:indexPath];
    [fitlerCell setCellMode:_fitlerModelArray[indexPath.item]];
    return fitlerCell;
}


- (void)initFitlerModelArray{
    for (int i=0; i<[self fitlerName].count; i++) {
        _fitlerModel    =   [[FitlerModel alloc]init];
          NSData  *data   =   UIImageJPEGRepresentation(_image, 1.0);
            NSString    *base64String   =   [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            _fitlerModel.fitlerimage    =   base64String;
            _fitlerModel.fitlerName     =   [self fitlerName][i];
            [_fitlerModelArray addObject:_fitlerModel];
    }
    [_collectionView reloadData];
}

- (NSArray*)fitlerName{
   
    NSArray     *filterName  =   [NSArray arrayWithObjects:@"CIColorInvert",@"CIPhotoEffectMono",@"CIPhotoEffectInstant",@"CIPhotoEffectTransfer",@"CIColorControls",@"CIMotionBlur",@"CIToneCurve"
                                  @"CIZoomBlur",
                                  @"CITriangleKaleidoscope",
                                  @"CIVignetteEffect",
                                  @"CIVibrance",
                                  @"CITwirlDistortion",
                                  @"CIUnsharpMask",nil];
    return filterName;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FitlerCollectionViewCell    *cell   =   (FitlerCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    self.fitlerImageView.image  =   cell.fitlerImage.image;
}
@end
