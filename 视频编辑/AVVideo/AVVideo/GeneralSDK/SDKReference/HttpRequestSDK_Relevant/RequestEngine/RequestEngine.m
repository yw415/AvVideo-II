//
//  RequestEngine.m
//  GeneralFrame
//
//  Created by user on 14-4-16.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "RequestEngine.h"
#import "BusinessURL.h"
#import "AFHTTPRequestOperation.h"
#pragma mark - AFNetWorking单例
@implementation RequestEngine

//单例模式
+(RequestEngine *)Instance
{
    static RequestEngine * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
        
    });
    
    return instance;
}

//初始化
-(id)init
{
    NSURL * url=[NSURL URLWithString:HostUrl];
    self=[super initWithBaseURL:url];
    if(!self)
    {
        return nil;
    }
    
    
    return self;
}

//处理相关请求
-(void)requestWithURL:(NSString *)url
           parameters:(NSDictionary *)parameters
         successBlock:(void(^)(id data))successBlock
            failBlock:(void(^)(void))failBlock;
{

    //开始请求
    [self postPath:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successBlock)
        {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failBlock)
        {
            failBlock();
        }
    }];
}

//创建单个请求
-(id)createRequest:(NSString *)urlStr
        parameters:(NSDictionary *)parameters
      successBlock:(void (^)(NSString * taskURL, id responseObject))successBlock
         failBlock:(void (^)(NSString * taskURL, NSError *error))failBlock
{

    NSURLRequest *request = [self requestWithMethod:@"POST" path:urlStr parameters:parameters ];
    AFHTTPRequestOperation * task=[self HTTPRequestOperationWithRequest:request
                                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                    if(successBlock)
                                                                    {
                                                                        NSString * url=operation.request.URL.absoluteString;
                                                                        successBlock(url,responseObject);
                                                                    }
                                                                }
                                                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                    if(failBlock)
                                                                    {
                                                                        NSString * url=operation.request.URL.absoluteString;
                                                                        failBlock(url,error);
                                                                    }
                                                                }];
    

    [task setThreadPriority:1000];
    return (id)task;

}

//创建单个下载请求
-(id)createDownLoadRequest:(NSString *)urlStr
              successBlock:(void (^)(NSString * taskURL, id responseObject))successBlock
                 failBlock:(void (^)(NSString * taskURL, NSError *error))failBlock
              downLoadPath:(NSString *)path
             downLoadBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downLoadBlock
           expireTimeBlock:(void (^)(void))expireTimeBlock
{
    NSURL * url=[NSURL URLWithString:urlStr];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100000];
    
    AFHTTPRequestOperation * task=[self HTTPRequestOperationWithRequest:request
                                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                    if(successBlock)
                                                                    {
                                                                        NSString * url=operation.request.URL.absoluteString;
                                                                        successBlock(url,responseObject);
                                                                    }
                                                                }
                                                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                    if(failBlock)
                                                                    {
                                                                        NSString * url=operation.request.URL.absoluteString;
                                                                        failBlock(url,error);
                                                                    }
                                                                }];
    
         task.outputStream=[NSOutputStream outputStreamToFileAtPath:path append:NO];
        [task setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            if(downLoadBlock)
            {
                downLoadBlock(bytesRead,totalBytesRead,totalBytesExpectedToRead);
            }
        }];
    [task setThreadPriority:1];
    
    if(expireTimeBlock)
    {
         [task setShouldExecuteAsBackgroundTaskWithExpirationHandler:expireTimeBlock];
    }


    return (id)task;
    
}

//下载队列请求
-(void)requestWithQueue:(NSArray *)operations
               download:(BOOL)downLoad
   queueCompletionBlock:(void(^)(NSArray *operations))queueCompletionBlock
{
    if(downLoad==YES)
    {
        self.requestOperations=operations;
    }
    
    NSLog(@"\n请求队列开始运行\n");
    [self enqueueBatchOfHTTPRequestOperations:operations
                                progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                    NSLog(@"\n当前已经完成%d个请求\n",(int)numberOfFinishedOperations);
                                    NSLog(@"\n当前需要完成的请求数：%d\n",(int)totalNumberOfOperations);
                                

    }
                              completionBlock:^(NSArray *operations) {
                                  NSLog(@"请求队列已完成");
                                  self.requestOperations=nil;
                                  if(queueCompletionBlock)
                                  {
                                      queueCompletionBlock(operations);
                                  }
 
    }];
 
}

//暂停整个下载请求队列
-(void)pauseAllOperations
{
    for(AFHTTPRequestOperation * operation in self.requestOperations)
    {
        [operation pause];
    }
}
//恢复整个下载请求队列
-(void)resumeAllOperations
{
    for(AFHTTPRequestOperation * operation in self.requestOperations)
    {
        [operation resume];
    }
}
//取消整个下载请求队列
-(void)concelAllOperations
{
    for(AFHTTPRequestOperation * operation in self.requestOperations)
    {
        [operation cancel];
    }
}

@end
