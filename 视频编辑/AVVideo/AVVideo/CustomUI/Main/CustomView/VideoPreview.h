//
//  VideoPreview.h
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface VideoPreview : UIView
/// 开始预览
-(void)startRun;
/// 停止预览
-(void)stopRun;
/// 打开关闭闪光灯
-(void)switchLight;
/// 切换摄像头
-(void)switchCamera;
/// 开始记录
-(void)startRecord;
/// 停止记录
-(void)stopRecord;
/// 重置
-(void)reset;
/// 将记录的视频保存到文件
-(void)saveToDisk:(void(^)(void))finishBlock;
@end
