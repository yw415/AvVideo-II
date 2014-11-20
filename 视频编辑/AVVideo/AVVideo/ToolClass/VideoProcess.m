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
    BOOL change;
    if([[UtilitySDK Instance]searchString:@"-A"
                                     from:videoPath].location!=NSNotFound)
    {
        change=YES;
    }
    else
    {
        change=NO;
    }

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
    // 改变视频方向
    if(!change)
    {
        videoTrack.preferredTransform=CGAffineTransformMakeRotation(M_PI_2);
    }
    AVMutableCompositionTrack * audioTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeAudio
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    
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
    
    /* 开始设置混合类 */
    // 此类用于应用变幻 剪切等效果在视频轨迹中
    AVAssetTrack * assetTrack=[[videoAsset tracksWithMediaType:AVMediaTypeVideo]
                              objectAtIndex:0];
    // 注意此处要使用videoTrack进行初始化而不是assetTrack 否则第二次混合时会出奇怪的错误
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction =
    [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    //转换矩阵90度 否则输出方向不对 之后还要重新设定原点 将左上的原点设到中心位置
    [self isPortrait:assetTrack.preferredTransform];

    // 此类代表应用在轨迹上的各种效果集合
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration);
    mainInstruction.layerInstructions=[NSArray arrayWithObjects:videolayerInstruction,nil];
    //视频组合类
    float renderWidth=assetTrack.naturalSize.width;
    float renderHeight=assetTrack.naturalSize.height;
    AVMutableVideoComposition * composition=[AVMutableVideoComposition videoComposition];
    composition.renderSize=CGSizeMake(renderWidth, renderHeight);
    composition.frameDuration=CMTimeMake(1, 30);
    composition.instructions=[NSArray arrayWithObject:mainInstruction];
    /* 结束设置混合类 */
    
    /* 开始输出文件 */
    [[UtilitySDK Instance]deleteFile:soundTempPath];
    NSURL * outputVideoFileURL=[NSURL fileURLWithPath:soundTempPath];
    NSString * preset=nil;
    preset=AVAssetExportPresetHighestQuality;
    AVAssetExportSession * exporter=[[AVAssetExportSession alloc]initWithAsset:mixComposition
                                                                    presetName:preset];
    exporter.outputURL=outputVideoFileURL;
    exporter.outputFileType=AVFileTypeMPEG4;
    //exporter.videoComposition=composition;
    
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
 *抽取视频帧渲染后输出
 *@pargm sourceVideo 视频源文件路径
 *@pargm filterName 滤镜名称
 *@pargm finishFilterCallBack 滤镜完成调用块
 */
-(void)extractImageFromVideo:(NSString *)sourceVideo
                 filterName:(NSString *)filterName
        finishFilterCallBack:(void(^)(void))block;
{
    BOOL change;
    if([[UtilitySDK Instance]searchString:@"-A"
                                     from:sourceVideo].location!=NSNotFound)
    {
        change=YES;
    }
    else
    {
        change=NO;
    }

    // 视频源文件路径URL
    NSURL * url=[NSURL fileURLWithPath:sourceVideo];
    // 滤镜文件临时存储路径
    NSString * filterVideoPath=[[UtilitySDK Instance]creatDirectiory:FilterTempVideoPath];
    if(change)
    {
        filterVideoPath=[filterVideoPath stringByAppendingPathComponent:FilterTempVideoFileA];
    }
    else
    {
        filterVideoPath=[filterVideoPath stringByAppendingPathComponent:FilterTempVideoFile];
    }
  
    
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

/**
 *给视频添加水印
 *@pargm sourceVideo 视频源文件路径
 *@pargm printImg 水印图片
 *@pargm pringRect 水印位置
 *@pargm finishFilterCallBack 水印添加完成调用块
 */
-(void)addWaterPrintToVideo:(NSString *)sourceVideo
                  printImg:(UIImage *)printImg
                  printRect:(CGRect)printRect
  finishWataerPrintCallBack:(void(^)(NSString *))block
{
    // 获取视频文件宽高
    
    BOOL change;
    if([[UtilitySDK Instance]searchString:@"-A"
                                        from:sourceVideo].location!=NSNotFound)
    {
        change=YES;
    }
    else
    {
        change=NO;
    }
    
    NSURL * assetURL=[NSURL fileURLWithPath:sourceVideo];
    AVAsset *avAsset=[[AVURLAsset alloc]initWithURL:assetURL options:nil];
    float renderWidth=0.0;
    float renderHeight=0.0;
    AVAssetTrack * videoAssetTrack=nil;
    if([[avAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0])
    {
        videoAssetTrack=[[avAsset tracksWithMediaType:AVMediaTypeVideo]
                                        objectAtIndex:0];
        renderWidth=videoAssetTrack.naturalSize.width;
        renderHeight=videoAssetTrack.naturalSize.height;
    }
    /* 开始设置混合层 */
    // 父图层
    CALayer * parentLayer=[CALayer layer];
    parentLayer.frame=CGRectMake(0, 0, renderWidth, renderHeight);
    // 水印图层
    CALayer * overLayer=[CALayer layer];
    [overLayer setContents:(id)[printImg CGImage]];
    overLayer.frame=printRect;
    [overLayer setMasksToBounds:YES];
    
    // 视频层
    CALayer * videoLayer=[CALayer layer];
    videoLayer.frame=CGRectMake(0, 0, renderWidth, renderHeight);
    // 混合各个层
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overLayer];
    

    /* 结束设置混合层 */
    
    /* 开始设置混合类 */
    // 此类代表混合的各种轨迹
    AVMutableComposition * mixComposition=[[AVMutableComposition alloc]init];
    // 此类代表视频轨迹集合
    AVMutableCompositionTrack * videoTrack=[mixComposition addMutableTrackWithMediaType:
                                                                        AVMediaTypeVideo
                                                                       preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, avAsset.duration)
                        ofTrack:videoAssetTrack
                         atTime:kCMTimeZero error:nil];
    
    // 此类代表音频轨迹集合
    AVMutableCompositionTrack * audioTrack=[mixComposition
                                            addMutableTrackWithMediaType:AVMediaTypeAudio
                                            preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, avAsset.duration)
                        ofTrack:[[avAsset tracksWithMediaType:AVMediaTypeAudio]
                                 objectAtIndex:0]
                         atTime: kCMTimeZero
                          error:nil];
    
    // 此类用于应用变幻 剪切等效果在视频轨迹中
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction =
    [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    [self isPortrait:videoAssetTrack.preferredTransform];
    //转换矩阵90度 否则输出方向不对 之后还要重新设定原点 将左上的原点设到中心位置
    if(!change)
    {
        CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(M_PI_2);
        CGAffineTransform rotateTranslate = CGAffineTransformTranslate(rotationTransform,0,-480);
        [videolayerInstruction setTransform:rotateTranslate
                                     atTime:kCMTimeZero];
    }
    // 此类代表应用在轨迹上的各种效果集合
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, avAsset.duration);
    mainInstruction.layerInstructions=[NSArray arrayWithObjects:videolayerInstruction,nil];
    //视频组合类
    AVMutableVideoComposition * composition=[AVMutableVideoComposition videoComposition];
    composition.renderSize=CGSizeMake(renderWidth, renderHeight);
    composition.frameDuration=CMTimeMake(1, 30);
    composition.instructions=[NSArray arrayWithObject:mainInstruction];
    composition.animationTool=[AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer
                                                                inLayer:parentLayer];
    /* 结束设置混合类 */
    
    //建立水印临时文件
    NSString * waterPrintTempPath=[[UtilitySDK Instance]
                                   creatDirectiory:WaterPrintTempVideoPath];
    waterPrintTempPath=[waterPrintTempPath stringByAppendingPathComponent:WaterPrintTempVideoFile];
    NSURL * outPutURL=[NSURL fileURLWithPath:waterPrintTempPath];
    /* 开始输出文件 */
    NSString * preset=nil;
    preset=AVAssetExportPresetHighestQuality;
    AVAssetExportSession * exporter=[[AVAssetExportSession alloc]initWithAsset:mixComposition
                                                                    presetName:preset];
    exporter.outputURL=outPutURL;
    exporter.outputFileType=AVFileTypeMPEG4;
    exporter.videoComposition=composition;
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
            [[UtilitySDK Instance]deleteFile:sourceVideo];
            NSString * orientationFixPath=sourceVideo;
            if(change)
            {
                 orientationFixPath=[orientationFixPath substringToIndex:orientationFixPath.length-6];
            }
            else
            {
                 orientationFixPath=[orientationFixPath substringToIndex:orientationFixPath.length-4];
            }
           
            orientationFixPath=[orientationFixPath stringByAppendingString:@"-A.mp4"];
            [[UtilitySDK Instance]saveFile:waterPrintTempPath toSavePath:orientationFixPath];
            [[UtilitySDK Instance]deleteFile:waterPrintTempPath];
            block(orientationFixPath);
        });
    }];
    /* 结束输出文件 */
    
}

/// 判断当前视频方向
-(BOOL)isPortrait:(CGAffineTransform) videoTransform
{
    NSLog(@"%f,%f,%f,%f",videoTransform.a,videoTransform.b,videoTransform.c,videoTransform.d);
    if(videoTransform.a==0&&videoTransform.b==-1.0&&videoTransform.c==1.0&&videoTransform.d==0)
    {
        return YES;
    }
    
    return NO;
}

@end
