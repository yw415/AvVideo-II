//
//  VideoProcess.m
//  AVVideo
//
//  Created by user on 14-10-20.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoProcess.h"
#import "UtilitySDK.h"
#import "ImageProcess.h"
#import <AVFoundation/AVFoundation.h>
@implementation VideoProcess

///单例
+(VideoProcess *)Instance
{
    static VideoProcess * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

/**
 *音频视频混音 
 *@pargm soundPath 要混合的音频文件路径
 *@pargm videoPath 要混合的视频文件路径
 *@pargm finishBlock 混音完成后调用的block
 */
-(void)mixSound:(NSString *)soundPath
      videoPath:(NSString *)videoPath
    finishBlock:(void(^)(void))finishBlock
{
     // 混音临时文件路径
    NSString * soundTempPath=[[UtilitySDK Instance]creatDirectiory:SoundTempVideoPath];
    soundTempPath=[soundTempPath stringByAppendingPathComponent:SoundTempVideoFile];
    
     NSURL * videoURL=[NSURL fileURLWithPath:videoPath];
     NSURL * audioURL=[NSURL fileURLWithPath:soundPath];
    
    AVURLAsset * videoAsset=[AVURLAsset assetWithURL:videoURL];
    AVURLAsset * audioAsset=[AVURLAsset assetWithURL:audioURL];
    
    
    AVMutableComposition * mixComposition=[[AVMutableComposition alloc]init];
    AVMutableCompositionTrack * videoTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeVideo
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack * audioTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeAudio
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    // 设置视频方向
    [videoTrack setPreferredTransform:CGAffineTransformMakeRotation(M_PI_2)];
    // 音轨时间
    
    /* 混音开始 */
    if([videoAsset tracksWithMediaType:AVMediaTypeVideo].count>0)
    {
        BOOL success=[videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                                ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0]
                                                 atTime: kCMTimeZero
                                                  error:nil];
        if(!success)
        {
            NSLog(@"混音失败");
            return;
        }
       
    }
    else
    {
        NSLog(@"混音失败");
        return;
    }
    
    if([audioAsset tracksWithMediaType:AVMediaTypeAudio].count>0)
    {
        BOOL success=[audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                         ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio]objectAtIndex:0]
                                          atTime: kCMTimeZero
                                           error:nil];
        if(!success)
        {
            NSLog(@"混音失败");
            return;
        }
        
    }
    else
    {
        NSLog(@"混音失败");
        return;
    }
    /* 混音结束 */
    
    /* 开始输出文件 */
    [[UtilitySDK Instance]deleteFile:soundTempPath];
    NSURL * outputVideoFileURL=[NSURL fileURLWithPath:soundTempPath];
    NSString * preset=nil;
    preset=AVAssetExportPresetHighestQuality;
    AVAssetExportSession * exporter=[[AVAssetExportSession alloc]initWithAsset:mixComposition
                                                                    presetName:preset];
    exporter.outputURL=outputVideoFileURL;
    exporter.outputFileType=AVFileTypeMPEG4;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        switch ([exporter status]) {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"文件输出失败: %@", [exporter error]);
                return;
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"文件输出取消");
                return;
                break;
            case AVAssetExportSessionStatusCompleted:
                NSLog(@"文件输出成功");
                break;
            default:
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UtilitySDK Instance]deleteFile:videoPath];
            [[UtilitySDK Instance]saveFile:soundTempPath toSavePath:videoPath];
            [[UtilitySDK Instance]deleteFile:soundTempPath];
            finishBlock();
        });
    }];
    /* 结束输出文件 */
}

/**
 *视频，音频与视频混合
 *@pargm sourceVideo 视频源文件路径
 *@pargm videoPath 要混合的视频文件路径
 *@pargm soundPath 要混合的音频文件路径
 *@pargm savePath 混合后的文件保存路径
 *@pargm finishBlock 混合完成后调用的block
 */
-(void)mixVideo:(NSString *)sourceVideo
      videoPath:(NSString *)videoPath
      soundPath:(NSString *)soundPath
       savePath:(NSString *)savePath
    finishBlock:(void(^)(void))finishBlock
{
    NSURL * videoSourceURL=[NSURL fileURLWithPath:sourceVideo];
    NSURL * videoURL=[NSURL fileURLWithPath:videoPath];
    NSURL * audioURL=[NSURL fileURLWithPath:soundPath];
    
    AVURLAsset * videoSourceAsset=[AVURLAsset assetWithURL:videoSourceURL];
    AVURLAsset * videoAsset=[AVURLAsset assetWithURL:videoURL];
    AVURLAsset * audioAsset=[AVURLAsset assetWithURL:audioURL];
    
    
    AVMutableComposition * mixComposition=[[AVMutableComposition alloc]init];
    AVMutableCompositionTrack * videoSourceTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeVideo
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack * videoTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeVideo
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack * audioTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeAudio
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    
    // 设置视频方向
    [videoSourceTrack setPreferredTransform:CGAffineTransformMakeRotation(M_PI_2)];

    /* 混音开始 */
    if([videoSourceAsset tracksWithMediaType:AVMediaTypeVideo].count>0)
    {
        BOOL success=[videoSourceTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoSourceAsset.duration)
                                         ofTrack:[[videoSourceAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0]
                                          atTime: kCMTimeZero
                                           error:nil];
        if(!success)
        {
            NSLog(@"混合失败");
            return;
        }
        
    }
    else
    {
        NSLog(@"混合失败");
        return;
    }
    
    if([videoAsset tracksWithMediaType:AVMediaTypeVideo].count>0)
    {
        BOOL success=[videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoSourceAsset.duration)
                                         ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0]
                                          atTime: kCMTimeZero
                                           error:nil];

        if(!success)
        {
            NSLog(@"混合失败");
            return;
        }
        
    }
    else
    {
        NSLog(@"混合失败");
        return;
    }
    
    if([audioAsset tracksWithMediaType:AVMediaTypeAudio].count>0)
    {
        BOOL success=[audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoSourceAsset.duration)
                                         ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio]objectAtIndex:0]
                                          atTime: kCMTimeZero
                                           error:nil];
        if(!success)
        {
            NSLog(@"混音失败");
            return;
        }
        
    }
    else
    {
        NSLog(@"混音失败");
        return;
    }
    /* 混音结束 */
    
    /*开始设置组合配置*/
//    AVMutableVideoCompositionInstruction * mainInstruction=[AVMutableVideoCompositionInstruction
//                                                            videoCompositionInstruction];
//    mainInstruction.timeRange=CMTimeRangeMake(kCMTimeZero,duration);
//    
//    AVMutableVideoCompositionLayerInstruction * layerInstructionSource=
//                                                    [AVMutableVideoCompositionLayerInstruction
//                                                    videoCompositionLayerInstructionWithAssetTrack:videoSourceTrack];
//    [layerInstructionSource setOpacity:1 atTime:videoAsset.duration];
//   
//    AVMutableVideoCompositionLayerInstruction * layerInstructionVideo=
//    [AVMutableVideoCompositionLayerInstruction
//     videoCompositionLayerInstructionWithAssetTrack:videoTrack];
//    [layerInstructionSource setOpacity:0.5 atTime:videoAsset.duration];
//    
//    NSArray * ins=[NSArray arrayWithObjects:layerInstructionVideo,layerInstructionSource,nil];
//    mainInstruction.layerInstructions=ins;
//    AVMutableVideoComposition * mainComposition=[AVMutableVideoComposition videoComposition];
//    mainComposition.instructions=[NSArray arrayWithObjects:mainInstruction, nil];
//    
//    float renderWidth,renderHeight;
//    AVAssetTrack * track = [[videoSourceAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0];
//    renderWidth=track.naturalSize.width;
//    renderHeight=track.naturalSize.height;
//    mainComposition.renderSize=CGSizeMake(renderWidth, renderHeight);
//    mainComposition.frameDuration=CMTimeMake(1, 30);
    /*结束设置组合配置*/
    
    /* 开始输出文件 */
    NSURL * outputVideoFileURL=[NSURL fileURLWithPath:savePath];
    NSString * preset=nil;
    preset=AVAssetExportPresetHighestQuality;
    
    AVAssetExportSession * exporter=[[AVAssetExportSession alloc]initWithAsset:mixComposition
                                                                    presetName:preset];
    exporter.outputURL=outputVideoFileURL;
    //exporter.videoComposition=mainComposition;
    exporter.outputFileType=AVFileTypeMPEG4;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        switch ([exporter status]) {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"文件输出失败: %@", [exporter error]);
                return;
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"文件输出取消");
                return;
                break;
            case AVAssetExportSessionStatusCompleted:
                NSLog(@"文件输出成功");
                break;
            default:
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            finishBlock();
        });
    }];
    /* 结束输出文件 */

}

/**
 *抽取视频帧渲染后输出
 *@pargm sourceVideo 视频源文件路径
 *@pargm filterName 滤镜名称
 *@pargm finishFilterCallBack 滤镜完成调用块
 */
-(void)extractImageFromVideo:(NSString *)sourceVideo
                 filterName:(NSString *)filterName
        finishFilterCallBack:(void(^)(void))block;
{
  
    // 视频源文件路径URL
    NSURL * url=[NSURL fileURLWithPath:sourceVideo];
    // 滤镜文件临时存储路径
    NSString * filterVideoPath=[[UtilitySDK Instance]creatDirectiory:FilterTempVideoPath];
    filterVideoPath=[filterVideoPath stringByAppendingPathComponent:FilterTempVideoFile];
    
    AVAsset *avAsset=[[AVURLAsset alloc]initWithURL:url options:nil];
    NSError * error = nil;
    AVAssetReader * reader=[[AVAssetReader alloc]initWithAsset:avAsset error:&error];
    NSArray * videoTracks=[avAsset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack * videoTrack=[videoTracks objectAtIndex:0];
    NSDictionary * options=[NSDictionary dictionaryWithObject:
                            [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                       forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    AVAssetReaderTrackOutput * assetReaderOutput=[[AVAssetReaderTrackOutput alloc]initWithTrack:
                                                  videoTrack
                                                                                 outputSettings:options];
    [reader addOutput:assetReaderOutput];
    [reader startReading];
    CMSampleBufferRef buffer;

    /* 开始配置写入 */
    NSError * wirteError = nil;
    [[UtilitySDK Instance]deleteFile:filterVideoPath];
    NSURL * writeurl=[NSURL fileURLWithPath:filterVideoPath];
    AVAssetWriter * videoWriter=[[AVAssetWriter alloc]initWithURL:writeurl
                                                         fileType:AVFileTypeMPEG4
                                                            error:&wirteError];
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:480], AVVideoWidthKey,
                                   [NSNumber numberWithInt:480], AVVideoHeightKey,
                                   nil];
    
    AVAssetWriterInput* writerInput = [AVAssetWriterInput
                                        assetWriterInputWithMediaType:AVMediaTypeVideo
                                        outputSettings:videoSettings];
    writerInput.transform=CGAffineTransformMakeRotation(M_PI_2);
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                     sourcePixelBufferAttributes:nil];
    
    writerInput.expectsMediaDataInRealTime=YES;
    [videoWriter addInput:writerInput];
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    /* 结束配置写入 */
    
    /* 开始写入帧 */
    int frameCount = 0;
    CVPixelBufferRef writebuffer = NULL;
    
    while ([reader status]==AVAssetReaderStatusReading)
    {
        // 所有creath或core打头的方法都会自动retain 要进行清理 否则内存会撑不住
        buffer=[assetReaderOutput copyNextSampleBuffer];
        
        if(buffer)
        {
            UIImage * img=[self imageFromSampleBuffer:buffer];
            img=[[ImageProcess Instance]addFilter:filterName toImg:img];
            CGImageRef cgimg=img.CGImage;
            writebuffer=[self pixelBufferFromCGImage:cgimg
                                           frameSize:CGSizeMake(480, 480)];
            if(writebuffer)
            {
                if (adaptor.assetWriterInput.readyForMoreMediaData)
                {
                    CMTime frameTime = CMTimeMake(frameCount,(int32_t) 30);
                    if(![adaptor appendPixelBuffer:writebuffer withPresentationTime:frameTime])
                    {
                        NSLog(@"加载帧出错");
                        
                    };
                    CVPixelBufferRelease(writebuffer);
                }
                frameCount++;
            }
            
            CMSampleBufferInvalidate(buffer);
            CFRelease(buffer);
            buffer = NULL;
        }
        
    }
    /* 结束写入帧 */
    
    

    
    // 输出文件
    if(videoWriter.status>0)
    {
        // [self.videoWriter endSessionAtSourceTime:self.time];
        [writerInput markAsFinished];
        [videoWriter finishWritingWithCompletionHandler:^{
            [self mixSound:sourceVideo
                 videoPath:filterVideoPath
               finishBlock:^{
                   [[UtilitySDK Instance]deleteFile:sourceVideo];
                   [[UtilitySDK Instance]saveFile:filterVideoPath toSavePath:sourceVideo];
                   [[UtilitySDK Instance]deleteFile:filterVideoPath];
                   block();

            }];
        }];
    }
   
}

// 从图片中抽取CVPixelBufferRef
- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image frameSize:(CGSize)frameSize
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameSize.width,
                                          frameSize.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameSize.width,
                                                 frameSize.height,
                                                 8,
                                                 4*frameSize.width,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}


/// 从抽样缓存中获得UIImage
-(UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    // 获取抽样缓存中存储的像素buffer
    CVImageBufferRef imageBuffer=CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // 获取像素开始时 必须调用此函数
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // 获取像素buffer地址
    void * baseAddress=CVPixelBufferGetBaseAddress(imageBuffer);
    // 获取图片每行像素的个数
    size_t bytesPerRow=CVPixelBufferGetBytesPerRow(imageBuffer);
    // 获取buffer的宽和高
    size_t width=CVPixelBufferGetWidth(imageBuffer);
    size_t height=CVPixelBufferGetHeight(imageBuffer);
    // 创建RGB颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    CGImageRelease(quartzImage);
    //获取像素结束时 必须调用此函数
    
    return image;
}
@end
