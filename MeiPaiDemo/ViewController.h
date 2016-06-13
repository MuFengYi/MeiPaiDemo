//
//  ViewController.h
//  MeiPaiDemo
//
//  Created by 易 彬锋 on 16/6/6.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^pushEditBlock)(UIImage *image);
@interface ViewController : UIViewController

@property(nonatomic,weak)pushEditBlock editBlock;

@end

