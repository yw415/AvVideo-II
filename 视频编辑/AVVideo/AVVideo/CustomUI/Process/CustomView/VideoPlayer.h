//
//  VideoPlayer.h
//  AVVideo
//
//  Created by user on 14-10-10.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayer : UIView
/// 开始播放
-(void)startPlayer;
/// 停止播放
-(void)stopPlayer;
/// 改变播放文件
-(void)changePlayerItem:(NSString *)url;
- (id)initWithFrame:(CGRect)frame url:(NSString *)url;
@end
