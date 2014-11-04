//
//  VideoRecordProgress.h
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoRecordProgress : UIView
/// 根据百分比改变进度条
-(void)changeProgressview:(float)percent;
/// 准备删除进度条区间
-(void)prepareChangeProgressview;
/// 回复删除进度条
-(void)resumeChangeProgressview;
/// 删除进度条区间
-(void)deleteProgressview:(float)percent;
/// 停止计时器
-(void)stopTime;
/// 开始计时器
-(void)startTime;
/// 重置视图状态
-(void)reset;
/// 添加暂停标识
-(void)addSuspendAccessory;
@end
