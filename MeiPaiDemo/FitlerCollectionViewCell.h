//
//  FitlerCollectionViewCell.h
//  MeiPaiDemo
//
//  Created by 易 彬锋 on 16/6/7.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FitlerModel.h"
@interface FitlerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fitlerImage;
@property (weak, nonatomic) IBOutlet UIButton *fitlerName;
@property(nonatomic,strong)CIContext    *context;
- (void)setCellMode:(FitlerModel*)Model;

@end
