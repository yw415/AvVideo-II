//
//  PhotosAlbumOption.m
//  AVVideo
//
//  Created by user on 14-10-25.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "PhotosAlbumOption.h"

@implementation PhotosAlbumOption

///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

///单例
+(PhotosAlbumOption *)Instance
{
    static PhotosAlbumOption * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}


/**
 *保存视频到相册
 *@pargm videoPath 要保存的视频路径
 */
-(void)saveVideoToPhotosAlbum:(NSString *)videoPath
{
    if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath))
    {
         UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
    else
    {
        NSLog(@"格式不正确");
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {
        NSLog(@"输出错误");
    }
    else
    {
        NSLog(@"输出成功");
        if(self.saveFinishBlock)
        {
            self.saveFinishBlock();
        }
    }
}

@end
