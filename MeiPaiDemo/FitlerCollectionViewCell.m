//
//  FitlerCollectionViewCell.m
//  MeiPaiDemo
//
//  Created by 易 彬锋 on 16/6/7.
//  Copyright © 2016年 bfy. All rights reserved.
//

#import "FitlerCollectionViewCell.h"

@implementation FitlerCollectionViewCell
@synthesize context;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setCellMode:(FitlerModel*)Model{
    [self.fitlerName setTitle:Model.fitlerName forState:UIControlStateNormal];
    UIImage *image  =   [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:Model.fitlerimage options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    
    CIImage *outPutImage =   [[CIImage alloc]initWithImage:image];
    CIFilter  *_fitler  =   [CIFilter filterWithName:Model.fitlerName];
    if (_fitler!=nil) {
        [_fitler setValue:outPutImage forKey:kCIInputImageKey];
        outPutImage =   _fitler.outputImage;
    }
    CGImageRef  imageRef    =   [[self context] createCGImage:outPutImage fromRect:outPutImage.extent];
    self.fitlerImage.image  =   [[UIImage alloc]initWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
                                 
}
-(CIContext*)context{
    
    if (context==nil) {
        EAGLContext     *eaglContext    =   [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
        context =   [CIContext contextWithEAGLContext:eaglContext options:nil];
    }
    return context;
}
@end
