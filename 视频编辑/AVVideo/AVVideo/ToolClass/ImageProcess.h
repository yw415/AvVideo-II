//
//  ImageProcess.h
//  AVVideo
//
//  Created by user on 14-11-2.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageProcess : NSObject
///单例
+(ImageProcess *)Instance;

/**
 *给图片添加滤镜
 *@pargm filterName 要添加的滤镜名称
 *@pargm sourceImg 要添加滤镜的图片
 *@return UIImage 加工后的图片
 */
-(UIImage *)addFilter:(NSString *)filterName
                toImg:(UIImage *)sourceImg;
@end