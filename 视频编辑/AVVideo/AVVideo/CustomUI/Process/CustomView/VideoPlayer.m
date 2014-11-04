//
//  VideoPlayer.m
//  AVVideo
//
//  Created by user on 14-10-10.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "UISDK.h"
@interface VideoPlayer()
@property(nonatomic,strong)AVPlayerItem * playItem;
@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)UIButton * pauseButton;
@property(nonatomic,assign)BOOL havePause;
@property(nonatomic,strong)AVPlayerLayer * playerLayer;
@end

@implementation VideoPlayer
#pragma mark - 界面生命周期

- (id)initWithFrame:(CGRect)frame url:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        __weak VideoPlayer * tempView=self;
        NSURL * outputFileURL=[NSURL fileURLWithPath:url];
        AVAsset * movieAsset=[AVURLAsset URLAssetWithURL:outputFileURL
                                                 options:nil];
        self.playItem=[AVPlayerItem playerItemWithAsset:movieAsset];
        self.player=[AVPlayer playerWithPlayerItem:self.playItem];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(relPlay)
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.playItem];
        
        self.playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame=self.bounds;
        self.playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:self.playerLayer];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(relPlay)
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.playItem];
        
        CGRect rect = CGRectMake(0, 0, 70, 50);
        self.pauseButton=[[UISDK Instance]addButton:rect
                                              title:@"播放"
                                              color:[UIColor blackColor]
                                             hcolor:nil
                                               font:nil
                                              bgImg:nil
                                             selImg:nil
                                              block:^(UIButton *but) {
                                                  [tempView resumePlay];
                                              }
                                               view:self];
        
        self.pauseButton.center=CGPointMake(ScreenWidth/2, ScreenHeight/2-100);
        self.pauseButton.hidden=YES;
        [self addSubview:self.pauseButton];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:AVPlayerItemDidPlayToEndTimeNotification
                                                 object:self.playItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.pauseButton.hidden==YES)
    {
        self.havePause=YES;
        [self.player pause];
        self.pauseButton.hidden=NO;
    }

}


#pragma mark - 功能方法

/// 开始播放
-(void)startPlayer
{
    [self.player play];
}

/// 重复播放
-(void)relPlay
{
    NSLog(@"Replay");
    [self.playItem seekToTime:kCMTimeZero];
    [self.player play];
}

/// 恢复播放
-(void)resumePlay
{
    [self.player play];
    self.pauseButton.hidden=YES;
}

/// 停止播放
-(void)stopPlayer
{
    [self.player pause];
}

/// 改变播放文件
-(void)changePlayerItem:(NSString *)url
{
    [self.player pause];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:AVPlayerItemDidPlayToEndTimeNotification
                                                 object:self.playItem];
    
    NSURL * outputFileURL=[NSURL fileURLWithPath:url];
    AVAsset * movieAsset=[AVURLAsset URLAssetWithURL:outputFileURL
                                             options:nil];
    self.playItem=[AVPlayerItem playerItemWithAsset:movieAsset];
    [self.player replaceCurrentItemWithPlayerItem:self.playItem];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(relPlay)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:self.playItem];
    
        [self.player play];
}


@end
