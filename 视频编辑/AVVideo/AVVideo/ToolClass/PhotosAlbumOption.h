//
//  PhotosAlbumOption.h
//  AVVideo
//
//  Created by user on 14-10-25.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveToPhotosAlbumFinishBlock) (void);
@interface PhotosAlbumOption : NSObject

///单例
+(PhotosAlbumOption *)Instance;

/**
 *保存视频到相册
 *@pargm videoPath 要保存的视频路径
 */
-(void)saveVideoToPhotosAlbum:(NSString *)videoPath;
@property(nonatomic,copy)SaveToPhotosAlbumFinishBlock saveFinishBlock;
@end
