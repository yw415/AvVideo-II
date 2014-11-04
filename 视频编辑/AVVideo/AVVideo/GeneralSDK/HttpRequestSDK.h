//
//  HttpRequestSDK.h
//  GeneralFrame
//
//  Created by user on 14-4-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessEnmu.h"

///网络操作API集合
#pragma mark - HttpRequestSDK 网络操作API集合
@interface HttpRequestSDK : NSObject
///单例
+(HttpRequestSDK *)Instance;
@property(nonatomic,assign)BOOL showWait;
@property(nonatomic,assign)BOOL showNetFail;
@property(nonatomic,assign)BOOL downLoadQueueFail;
@property(nonatomic,strong)NSArray * queueOperations;

/**
 *构建post请求
 *@pargm type 所要请求的url枚举
 *@pargm parameters 请求参数
 *@pargm successBlock 请求成功回调块
 *@pargm failBlock 请求失败回调块
 */
-(void)requestWithType:(BusinessRequestType)type
            parameters:(NSDictionary *)parameters
          successBlock:(void(^)(id json))successBlock
             failBlock:(void(^)(void))failBlock;

///重置http头
-(void)resetHttpHead;

/**
 *构建单个请求
 *@pargm type 所要请求的url枚举
 *@pargm parameters 请求参数
 *@pargm successBlock 请求成功回调块
 *@pargm failBlock 请求失败回调块
 *@return id 所构建的请求
 */
-(id)createRequest:(BusinessRequestType)type
        parameters:(NSDictionary *)parameters
      successBlock:(void (^)(NSString * taskURL, id responseObject))successBlock
         failBlock:(void (^)(NSString * taskURL, NSError *error))failBlock;

/**构建单个下载请求
 *@pargm type 所要请求的url枚举
 *@pargm url 额外的url后缀 如没有传nil
 *@pargm successBlock 请求成功回调块
 *@pargm failBlock 请求失败回调块
 *@pargm downLoadPath 下载路径
 *@pargm downLoadBlock 下载进度块
 *@pargm expireTimeBlock 后台任务超时块
 *@return id 所构建的请求
 */
-(id)createDownLoadRequest:(BusinessRequestType)type
                       url:(NSString *)url
              successBlock:(void (^)(NSString * taskURL, id responseObject))successBlock
                 failBlock:(void (^)(NSString * taskURL, NSError *error))failBlock
              downLoadPath:(NSString *)path
             downLoadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downLoadBlock
           expireTimeBlock:(void (^)(void))expireTimeBlock;

/**进行下载队列请求
  *@pargm operations 所要操作的请求队列
  *@pargm downLoad 是否下载队列
  *@pargm queueprogressBlock 队列请求完成进度回调块
  *@pargm queueCompletionBlock 整个队列请求完成回调块
*/
-(void)requestWithQueue:(NSArray *)operations
               download:(BOOL)downLoad
   queueCompletionBlock:(void(^)(NSArray *operations))queueCompletionBlock
         queueFailBlock:(void(^)(void))queueFailBlock;

///暂停整个下载请求队列
-(void)pauseAllOperations;
///恢复整个下载请求队列
-(void)resumeAllOperations;
///取消整个下载请求队列
-(void)concelAllOperations;
@end

