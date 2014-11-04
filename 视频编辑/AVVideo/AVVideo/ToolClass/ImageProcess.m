//
//  ImageProcess.m
//  AVVideo
//
//  Created by user on 14-11-2.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ImageProcess.h"
@interface ImageProcess()
@property(nonatomic,strong)CIContext * context;
@property(nonatomic,strong)CIFilter * filter;
@end

@implementation ImageProcess
///单例
+(ImageProcess *)Instance
{
    static ImageProcess * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        self.context=[CIContext contextWithOptions:nil];
    }
    return self;
}

/**
 *给图片添加滤镜
 *@pargm filterName 要添加的滤镜名称
 *@pargm sourceImg 要添加滤镜的图片
 *@return UIImage 加工后的图片
 */
-(UIImage *)addFilter:(NSString *)filterName
                toImg:(UIImage *)sourceImg
{

    CIImage * ciImg=[CIImage imageWithCGImage:sourceImg.CGImage];
    self.filter=[CIFilter filterWithName:filterName
                           keysAndValues:kCIInputImageKey,
                                         ciImg,
                 nil];
    CIImage * outPutImage=[self.filter outputImage];
    CGImageRef cgImg=[self.context createCGImage:outPutImage fromRect:outPutImage.extent];
    UIImage * newImage=[UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    return newImage;
}

@end
