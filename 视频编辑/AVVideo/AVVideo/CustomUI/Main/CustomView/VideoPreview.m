//  VideoPreview.m
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//


#import "VideoPreview.h"
#import "UtilitySDK.h"
#import "UISDK.h"
#import "VideoProcess.h"
#import <AVFoundation/AVFoundation.h>
@interface VideoPreview()<AVCaptureVideoDataOutputSampleBufferDelegate,
                          AVCaptureAudioDataOutputSampleBufferDelegate>
/* Session相关参数开始 */
// Session操作队列
@property(nonatomic)dispatch_queue_t sessionQueue;
// 传输session
@property(nonatomic)AVCaptureSession * session;
/* Session相关参数结束 */

/* 视频音频设备相关参数开始 */
// 视频输入设备
@property(nonatomic)AVCaptureDeviceInput *videoDeviceInput;
// 音频输入设备
@property(nonatomic)AVCaptureDeviceInput * audioDeviceInput;
// 视频输出设备
@property (nonatomic) AVCaptureVideoDataOutput *videoDeviceOutput;
// 音频输出设备
@property (nonatomic) AVCaptureAudioDataOutput * audioDeviceOutput;
// 视频写入设备
@property (nonatomic,strong) AVAssetWriter * videoWriter;
// 视频写入设备输入
@property (nonatomic,strong)AVAssetWriterInput * videoWriterInput;
// 音频写入设备输入
@property (nonatomic,strong)AVAssetWriterInput * audioWriterInput;
// 视频写入编辑器
@property (nonatomic,strong)AVAssetWriterInputPixelBufferAdaptor * adaptor;
/* 视频音频设备相关参数结束 */

/* 视频状态BOOL值开始 */
// 闪光灯已经打开
@property(nonatomic,assign)BOOL haveOpenLight;
// 是否开始记录文件
@property(nonatomic,assign)BOOL willRecord;
/* 视频状态BOOL值结束 */

/* 其他参数开始 */
// 对焦示意图
@property(nonatomic,strong)UIView * forcusView;
// 时间戳
@property(nonatomic)CMTime time;
// 后台任务ID
@property(nonatomic)UIBackgroundTaskIdentifier backgroundRecordID;
/* 其他参数结束 */

/* 视频时间戳调整相关参数开始 */
@property(nonatomic)CMTime lastTime;
@property(nonatomic)CMTime offsetTime;
@property(nonatomic)CMTime durationTime;
@property(nonatomic,assign)BOOL interrupted;
/* 视频时间戳调整相关参数结束 */

@end
@implementation VideoPreview
#pragma mark - 界面生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configurePreView];
    }
    return self;
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
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint=[touch locationInView:touch.view];
    double focusx=touchPoint.x/self.frame.size.width;
    double focusy=touchPoint.y/self.frame.size.height;

    
    if([((AVCaptureDevice *)self.videoDeviceInput.device) isFocusPointOfInterestSupported])
    {
        [self.videoDeviceInput.device lockForConfiguration:nil];
        [self.videoDeviceInput.device setFocusPointOfInterest:CGPointMake(focusx, focusy)];
        [self.videoDeviceInput.device setFocusMode:AVCaptureFocusModeAutoFocus];
        [self.videoDeviceInput.device unlockForConfiguration];

        if(!self.forcusView)
        {
            self.forcusView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            self.forcusView.layer.borderColor=[UIColor orangeColor].CGColor;
            self.forcusView.center=touchPoint;
            self.forcusView.layer.borderWidth=1;
            [self addSubview:self.forcusView];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.forcusView removeFromSuperview];
            self.forcusView=nil;
        });

    }
}

#pragma mark - 硬件操作相关方法
/// 打开关闭闪光灯
-(void)switchLight
{
    AVCaptureDevice * device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(device.torchMode==AVCaptureTorchModeOn)
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    else
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}

/// 获取相关设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}


/// 切换前摄像头
-(void)switchCamera
{
    NSArray *inputs = self.session.inputs;
    AVCaptureDevicePosition position=0;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            self.videoDeviceInput=nil;
            
            [self.session beginConfiguration];
            self.videoDeviceInput=newInput;
            [self.session removeInput:input];
            [self.session addInput:self.videoDeviceInput];
            [self.session commitConfiguration];
            break;
        }
    }

    // 很奇怪必须在主线程设置帧率 否则小的视频碎片就不能合成 不明白为什么
    if(position==AVCaptureDevicePositionBack)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.videoDeviceInput.device lockForConfiguration:nil];
            [self.videoDeviceInput.device setActiveVideoMinFrameDuration:CMTimeMake(1, 13)];
            [self.videoDeviceInput.device setActiveVideoMaxFrameDuration:CMTimeMake(1, 13)];
            [self.videoDeviceInput.device unlockForConfiguration];
        });
        
    }

}

#pragma mark - 预览配置相关方法
/// 配置预览层
-(void)configurePreView
{
    // 创建AVCaptureSession
    AVCaptureSession * session=[[AVCaptureSession alloc]init];
    session.sessionPreset=AVCaptureSessionPresetHigh;
    // 給预览层设置Session
    
    self.session=session;
    // 设置session操作队列
    self.sessionQueue=dispatch_queue_create("session queue",NULL);
    [self runQueue];
}

/// 执行操作队列
-(void)runQueue
{
    // 注册后台任务
    self.backgroundRecordID=UIBackgroundTaskInvalid;
    
    /*开始配置视频输入设备*/
    [self configureInputDevice];
    /*结束配置视频输入设备*/
    
    /*开始配置视频输出设备*/
    [self configureOuputDevice];
    /*结束配置视频输出设备*/
   
    
     /*开始配置预览层*/
    AVCaptureVideoPreviewLayer * preViewLayer= (AVCaptureVideoPreviewLayer *)self.layer;
    //设置预览层视频方向
    preViewLayer.connection.videoOrientation=(AVCaptureVideoOrientation)UIDeviceOrientationPortrait;
    /*结束配置预览层*/
   
}

/// 配置视频输入设备
-(void)configureInputDevice
{
    /*开始配置视频*/
    // 获取前后两个摄像头
    NSArray * devices=[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice * captureDevice;
    
    for(AVCaptureDevice * device in devices)
    {
        // 获取参数指定位置的摄像头
        if([device position]==AVCaptureDevicePositionBack)
        {
            captureDevice=device;
            break;
        }
    }
    
    // 配置收入设备焦点，曝光度
    NSError * error=nil;
    
    self.videoDeviceInput=[AVCaptureDeviceInput deviceInputWithDevice:captureDevice
                                                                error:&error];
    
    if([self.session canAddInput:self.videoDeviceInput])
    {
        [self.session addInput:self.videoDeviceInput];
        
    }
    
    [self.videoDeviceInput.device lockForConfiguration:nil];
    self.videoDeviceInput.device.focusMode=AVCaptureFocusModeLocked;
    self.videoDeviceInput.device.exposureMode=AVCaptureExposureModeContinuousAutoExposure;
    [self.videoDeviceInput.device unlockForConfiguration];
    /*结束配置视频*/
    
    /*开始配置音频*/
    AVCaptureDevice * audioDevice=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    self.audioDeviceInput=[AVCaptureDeviceInput deviceInputWithDevice:audioDevice
                                                                error:&error];
    if([self.session canAddInput:self.audioDeviceInput])
    {
        [self.session addInput:self.audioDeviceInput];
    }
    /*结束配置音频*/
    
    
    
}

/// 配置视频输出设备
-(void)configureOuputDevice
{
    
    /*开始配置视频输出*/
    self.videoDeviceOutput=[[AVCaptureVideoDataOutput alloc]init];
    self.videoDeviceOutput.alwaysDiscardsLateVideoFrames=YES;
    [self.videoDeviceOutput setSampleBufferDelegate:self
                                              queue:self.sessionQueue];
    self.session.sessionPreset=AVCaptureSessionPresetMedium;
    if([self.session canAddOutput:self.videoDeviceOutput])
    {
        [self.session addOutput:self.videoDeviceOutput];
    }
    /*结束配置视频输出*/
    
    /*开始配置音频输出*/
    self.audioDeviceOutput=[[AVCaptureAudioDataOutput alloc]init];
    [self.audioDeviceOutput setSampleBufferDelegate:self queue:self.sessionQueue];
    if([self.session canAddOutput:self.audioDeviceOutput])
    {
        [self.session addOutput:self.audioDeviceOutput];
    }
    /*结束配置音频输出*/
}

/// 改变layer类型为视频预览页
+(Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

/// 获取session
- (AVCaptureSession *)session
{
	return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

/// 设置session
- (void)setSession:(AVCaptureSession *)session
{
	[(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
    ((AVCaptureVideoPreviewLayer *)[self layer]).videoGravity=AVLayerVideoGravityResizeAspectFill;
}

#pragma mark 文件写入相关方法
/// 配置写入
-(void)configureWritter
{

        // 视频记录文件路径
        NSString * outputVideoFilePath=[[UtilitySDK Instance]creatDirectiory:VideoRecordPath];
        NSString * videoFile=[NSString stringWithFormat:VideoRecordFile];
        
        outputVideoFilePath=[outputVideoFilePath stringByAppendingPathComponent:videoFile];
        NSURL * outputVideoFileURL=[NSURL fileURLWithPath:outputVideoFilePath];
        
        
        NSError * videoError =nil;
        self.videoWriter=[[AVAssetWriter alloc]
                          initWithURL:outputVideoFileURL
                          fileType:AVFileTypeMPEG4
                          error:&videoError];
        
        if(videoError)
        {
            NSLog(@"写入配置错误");
            return;
        }

  
        // 开始设置写入输入
        [self configureWritterInput];
        
    //    // 设置写入编辑器
    //    [self configureWritterAdaptor];
        
        [self.videoWriter addInput:self.videoWriterInput];
        [self.videoWriter addInput:self.audioWriterInput];
    
}

/// 配置写入输入
-(void)configureWritterInput
{
    /*开始配置视频输入*/
    // 视频设置
    NSDictionary * videoSettings=[NSDictionary dictionaryWithObjectsAndKeys:
                                  AVVideoCodecH264,AVVideoCodecKey,
                                  [NSNumber numberWithInt:480],AVVideoWidthKey,
                                  [NSNumber numberWithInt:480],AVVideoHeightKey,
                                  nil];
    // 视频写入输入设置
    self.videoWriterInput=[AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                             outputSettings:videoSettings];
    self.videoWriterInput.expectsMediaDataInRealTime=YES;

    // 角度调整 否则视频是歪的
    self.videoWriterInput.transform=CGAffineTransformMakeRotation(M_PI_2);
    /*结束配置视频输入*/
    
    /*开始配置音频输入*/
    NSDictionary* audioOutputSettings = nil;
    
    audioOutputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                           [NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey,
                           [NSNumber numberWithInt: 1 ], AVNumberOfChannelsKey,
                           nil];
    self.audioWriterInput = [AVAssetWriterInput
                             assetWriterInputWithMediaType: AVMediaTypeAudio
                             outputSettings: audioOutputSettings ];
    self.audioWriterInput.expectsMediaDataInRealTime = YES;
    /*结束配置音频输入*/
}

#pragma mark 功能方法
/// 开始记录
-(void)startRecord
{
    self.willRecord=YES;
}

/// 停止记录
-(void)stopRecord
{
    if(self.videoWriter.status>0)
    {
        self.willRecord=NO;
        self.interrupted=YES;
    }
}

/// 开始预览
-(void)startRun
{
    [self.session startRunning];
    self.lastTime=CMTimeMake(0, 0);
    self.offsetTime=CMTimeMake(0, 0);
    self.durationTime=CMTimeMake(0, 0);
    self.interrupted=NO;
    
    self.videoWriterInput=nil;
    self.audioWriterInput=nil;
    self.videoWriter=nil;
    
    [self removeExistFiles];
    [self configureWritter];
}

/// 停止预览
-(void)stopRun
{
    [self.session stopRunning];
}

/// 删除所有的的影音文件
-(void)removeExistFiles
{
    NSArray * fileList=nil;
    
    // 删除视频文件
    NSString * outputVideoFilePath=[[UtilitySDK Instance]creatDirectiory:VideoRecordPath];
    fileList=[[UtilitySDK Instance]getFilesInDirectory:outputVideoFilePath];
    
    for (NSString * videoFile in fileList) {
        NSString * filePath=[outputVideoFilePath stringByAppendingPathComponent:videoFile];
        [[UtilitySDK Instance]deleteFile: filePath];
    }
    
    // 删除混音文件
    NSString * mixFilePath=[[UtilitySDK Instance]creatDirectiory:MixVideoPath];
    fileList=[[UtilitySDK Instance]getFilesInDirectory:mixFilePath];
    
    for (NSString * videoFile in fileList) {
        NSString * filePath=[outputVideoFilePath stringByAppendingPathComponent:videoFile];
        [[UtilitySDK Instance]deleteFile:filePath];
    }
}

/// 重置
-(void)reset
{
    self.videoWriterInput=nil;
    self.audioWriterInput=nil;
    self.videoWriter=nil;
    
    self.lastTime=CMTimeMake(0, 0);
    self.offsetTime=CMTimeMake(0, 0);
    self.durationTime=CMTimeMake(0, 0);
    self.interrupted=NO;
    
    [self removeExistFiles];
    [self configureWritter];
}

/// 将记录的视频保存到文件
-(void)saveToDisk:(void(^)(void))finishBlock;
{
    if(self.videoWriter.status>0)
    {
        
       // [self.videoWriter endSessionAtSourceTime:self.time];
        [self.videoWriter finishWritingWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock();
            });
        
        }];
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void) captureOutput:(AVCaptureFileOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{

    self.time=CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    if(!CMSampleBufferDataIsReady(sampleBuffer))
    {
        NSLog(@"Sample Buffer Data 尚未完成");
        return;
    }
    
    if(!self.willRecord)
    {
        return;
    }
    
    //NSLog(@"status:%d",self.videoWriter.status);
    // 当前输出设备是否视频输出
    BOOL isVideo=(connection==[self.videoDeviceOutput connectionWithMediaType:AVMediaTypeVideo]);
    CMTime currentTimeStamp=CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    
    // 计算打断间隔时间
    if(self.interrupted&&!isVideo)
    {
        
        self.interrupted=NO;
        if(CMTIME_IS_VALID(currentTimeStamp))
        {
            if(self.durationTime.value>0)
            {
                 NSLog(@"Start Adjust");
            }
            CMTime offset = CMTimeSubtract(currentTimeStamp, self.durationTime);
            self.lastTime=(self.lastTime.value==0)?offset:CMTimeAdd(self.lastTime, offset);
        }
    }
    
    // 调整SampleBuffer
    CMSampleBufferRef bufferToWrite=NULL;
    if(self.lastTime.value>0)
    {
        NSLog(@"Interrupted");
        bufferToWrite=[self adjustTime:sampleBuffer by:self.lastTime];
    }
    else
    {
        NSLog(@"NoInterrupted");
        bufferToWrite=sampleBuffer;
        CFRetain(bufferToWrite);

    }
    
   
    
    /* 开始记录音频视频 */
    if(!self.interrupted)
    {
        if(bufferToWrite)
        {
            // 准备记录
            if(self.videoWriter.status==AVAssetWriterStatusUnknown)
            {
                [self.videoWriter startWriting];
            }
            
            // 开始记录
            if(self.videoWriter.status==AVAssetWriterStatusWriting)
            {
                //记录视频
                if(isVideo)
                {
                    // 在此设置开始时间 否则第一帧可能为黑帧
                    CMTime startTime=CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
                    [self.videoWriter startSessionAtSourceTime:startTime];
                    
                    if(![self.videoWriterInput appendSampleBuffer:bufferToWrite])
                    {
                        NSLog(@"视频记录失败");
                    }
                }
                
                //记录音频
                if(!isVideo)
                {
                    if(![self.audioWriterInput appendSampleBuffer:bufferToWrite])
                    {
                        NSLog(@"音频记录失败");
                    }
                }
                
            }
            
        }
    }
     /* 结束记录音频视频 */
    
    // 计算这一帧持续时间
    if(!isVideo)
    {
        CMTime presentTimeStamp=CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
        CMTime duration=CMSampleBufferGetDuration(sampleBuffer);
        if(duration.value>0)
        {
            presentTimeStamp=CMTimeAdd(presentTimeStamp, duration);
        }
        self.durationTime=presentTimeStamp;
    }

    
    if(bufferToWrite)
    {
        CFRelease(bufferToWrite);
    }
    
   
    
}

/// 调整视频帧
-(CMSampleBufferRef) adjustTime:(CMSampleBufferRef) sampleBuffer by:(CMTime) timeOffset
{
    CMItemCount itemCount;
    
    OSStatus status = CMSampleBufferGetSampleTimingInfoArray(sampleBuffer, 0, NULL, &itemCount);
    if (status) {
        return NULL;
    }
    
    CMSampleTimingInfo *timingInfo = (CMSampleTimingInfo *)malloc(sizeof(CMSampleTimingInfo) * (unsigned long)itemCount);
    if (!timingInfo) {
        return NULL;
    }

    status = CMSampleBufferGetSampleTimingInfoArray(sampleBuffer, itemCount, timingInfo, &itemCount);
    if (status) {
        free(timingInfo);
        timingInfo = NULL;
        return NULL;
    }

    for (CMItemCount i = 0; i < itemCount; i++) {
        timingInfo[i].presentationTimeStamp = CMTimeSubtract(timingInfo[i].presentationTimeStamp, timeOffset);
        timingInfo[i].decodeTimeStamp = CMTimeSubtract(timingInfo[i].decodeTimeStamp, timeOffset);
    }

    CMSampleBufferRef offsetSampleBuffer;
    CMSampleBufferCreateCopyWithNewTiming(kCFAllocatorDefault, sampleBuffer, itemCount, timingInfo, &offsetSampleBuffer);

    
    if (timingInfo) {
        free(timingInfo);
        timingInfo = NULL;
    }
    
    return offsetSampleBuffer;
}
@end
