//
//  HttpRequestSDK.m
//  GeneralFrame
//
//  Created by user on 14-4-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "HttpRequestSDK.h"
#import "RequestEngine.h"
#import "BusinessURL.h"
#import "Parser.h"
#import "UtilitySDK.h"
#import "ConfigSDK.h"
#import "AppDelegate.h"
#pragma mark - 网络操作API集合
@implementation HttpRequestSDK
///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        self.showWait=YES;
        self.showNetFail=YES;
    }
    return self;
}

///单例模式
+(HttpRequestSDK *)Instance
{
    static HttpRequestSDK * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    
        /*开始打印操作日志*/
        NSMutableString * str=[NSMutableString stringWithFormat:@"\n----------正在请求%@服务器--------\n",
                               [[BusinessURL Instance] getURLWithRequest:URL_Host]];

        NSLog(@"%@",str);
        /*结束打印操作日志*/
        
       
        //设置Http头
        [[RequestEngine Instance] setDefaultHeader:@"imei" value:[UtilitySDK Instance].get_imei];
        [[RequestEngine Instance] setDefaultHeader:@"ua" value:[UtilitySDK Instance].get_ua];
        [[RequestEngine Instance] setDefaultHeader:@"c_version" value:c_version];
        [[RequestEngine Instance] setDefaultHeader:@"channel" value:channel];
        [[RequestEngine Instance] setDefaultHeader:@"sid" value:@"0"];
    });
    
    return instance;
}

///重置http头
-(void)resetHttpHead
{
    [[RequestEngine Instance] setDefaultHeader:@"imei" value:[UtilitySDK Instance].get_imei];
    [[RequestEngine Instance] setDefaultHeader:@"ua" value:[UtilitySDK Instance].get_ua];
    [[RequestEngine Instance] setDefaultHeader:@"c_version" value:c_version];
    [[RequestEngine Instance] setDefaultHeader:@"channel" value:channel];
    [[RequestEngine Instance] setDefaultHeader:@"sid" value:@"0"];
}

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
             failBlock:(void(^)(void))failBlock
{
    //检查网络状态
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    if([appDelegate.reach currentReachabilityStatus]>0)
    {
        //打印初始日志
        [self printLog:type parameters:parameters];
        //发送显示等待提示框信息
        if(self.showWait)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowWait" object:nil];
        }
        NSString * url=[[BusinessURL Instance]getURLWithRequest:type];
        [[RequestEngine Instance]requestWithURL:url parameters:parameters successBlock:^(id json) {
            //打印请求成功日志
            NSString * requestName=[[BusinessURL Instance]getNameWithRequest:type];
            NSString *responseStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            NSMutableString * str=[NSMutableString stringWithFormat:@"\n接口%@请求成功\n",requestName];
            [str appendString:[NSString stringWithFormat:@"接口返回数据：\n%@\n",responseStr]];
            [str appendString:[NSString stringWithFormat:@"----------接口%@请求结束--------\n",requestName]];
            NSLog(@"%@",str);
            
            //开始解析json
            id data=[[Parser Instance]parserWithRequestType:type json:json];
            if(successBlock)
            {
                //发送取消等待提示框信息
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HideWait" object:nil];
                
                successBlock(data);
            }
        
            
        } failBlock:^{
            
            //发送取消等待提示框信息
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HideWait" object:nil];
            NSString * requestName=[[BusinessURL Instance]getNameWithRequest:type];
            NSMutableString * str=[NSMutableString stringWithFormat:@"\n接口%@请求失败\n",requestName];
            NSLog(@"%@",str);
            if(failBlock)
            {
                failBlock();
            }
    
        }];

    }
    else
    {
        //发送网络连接失败信息
        NSLog(@"网络连接失败");
        if(self.showNetFail)
        {
             [[NSNotificationCenter defaultCenter]postNotificationName:@"NetFail" object:nil];
        }
        if(failBlock)
        {
            failBlock();
        }
    }
}

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
         failBlock:(void (^)(NSString * taskURL, NSError *error))failBlock

{
    //单个请求成功回调块
    void(^successCallBack)(NSString * taskURL,
                           id responseObject)=
    ^(NSString * taskURL,
     id responseObject)
    {
        NSString * urlName=[[BusinessURL Instance]getNameWithRequest:type];
        NSMutableString * str=[NSMutableString stringWithFormat:@"\n接口%@请求成功\n",urlName];
        NSString *responseStr = [[NSString alloc] initWithData:responseObject
                                                      encoding:NSUTF8StringEncoding];
        [str appendString:[NSString stringWithFormat:@"接口返回数据：\n%@\n",responseStr]];
        [str appendString:[NSString stringWithFormat:@"----------接口%@请求结束--------\n",urlName]];
        NSLog(@"%@",str);
        //开始解析json

       id data=[[Parser Instance]parserWithRequestType:type json:responseObject];
        
        if(successBlock)
        {
            successBlock(taskURL,data);
        }

    };
    
    //单个请求失败回调块
    void(^failCallBack)(NSString * taskURL,
                        NSError * error)=
    ^(NSString * taskURL,
      NSError * error)
    {
        NSString * urlName=[[BusinessURL Instance]getNameWithRequest:type];
        NSLog(@"\n----------接口%@请求结束--------\n",urlName);
        //标记下载队列下载失败 并取消所有队列中的请求
        if(!self.downLoadQueueFail)
        {
            if(failBlock)
            {
                failBlock(taskURL,error);
            }
            
            self.downLoadQueueFail=YES;
        }


    };
    
    //打印初始日志
    [self printLog:type parameters:nil];
    NSString * urlStr=[[BusinessURL Instance]getURLWithRequest:type];
    id task=[[RequestEngine Instance]createRequest:urlStr
                                      parameters:parameters
                                      successBlock:successCallBack
                                         failBlock:failCallBack];
    return task;

}

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
   expireTimeBlock:(void (^)(void))expireTimeBlock
{
    NSString * urlStr=[[BusinessURL Instance]getURLWithRequest:type];
    if(url)
    {
        urlStr=[urlStr stringByAppendingString:url];
    }
    id task=[[RequestEngine Instance]createDownLoadRequest:urlStr
                                      successBlock:^(NSString *taskURL, id responseObject) {
                                          NSLog(@"\n%@请求成功\n",taskURL);
                                        if(successBlock)
                                        {
                                            successBlock(taskURL,responseObject);
                                        }
                                      }
                                         failBlock:^(NSString *taskURL, NSError *error) {
                                             NSLog(@"\n%@请求失败\n",taskURL);
                                             //标记下载队列下载失败 并取消所有队列中的请求
                                             if(!self.downLoadQueueFail)
                                             {
                                                 if(failBlock)
                                                 {
                                                     failBlock(taskURL,error);
                                                 }

                                                self.downLoadQueueFail=YES;
                                             }
                                             
                                            
                                             
                                         }
                                      downLoadPath:path
                                     downLoadBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                                         if(downLoadBlock)
                                         {
                                             downLoadBlock(bytesRead,totalBytesRead,totalBytesExpectedToRead);
                                         }
                                     } expireTimeBlock:^{
                                         if(expireTimeBlock)
                                         {
                                             expireTimeBlock();
                                         }
                                     }];
    return task;
}

/**进行下载队列请求
 *@pargm operations 所要操作的请求队列
 *@pargm downLoad 是否下载队列
 *@pargm queueprogressBlock 队列请求完成进度回调块
 *@pargm queueCompletionBlock 整个队列请求完成回调块
 */
-(void)requestWithQueue:(NSArray *)operations
               download:(BOOL)downLoad
   queueCompletionBlock:(void(^)(NSArray *operations))queueCompletionBlock
         queueFailBlock:(void(^)(void))queueFailBlock
{

    //检查网络状态
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    if([appDelegate.reach currentReachabilityStatus]>0)
    {
        //发送显示等待提示框信息
        if(self.showWait&&!downLoad)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowWait" object:nil];
        }
        
        [[RequestEngine Instance]requestWithQueue:operations
                                 download:downLoad
                             queueCompletionBlock:^(NSArray *operations) {
                                 if(self.downLoadQueueFail)
                                 {
                                     self.downLoadQueueFail=NO;
                                     NSLog(@"n队列中存在错误请求\n");
                                    
                                     //发送取消等待提示框信息
                                     if(!downLoad)
                                     {
                                         
                                         [[NSNotificationCenter defaultCenter]postNotificationName:@"HideWait" object:nil];
                                         if(queueFailBlock)
                                         {
                                             queueFailBlock();
                                         }
                                     }
                                     if(downLoad)
                                     {
                                         
                                         queueCompletionBlock(operations);
                                     }
                                         
                                     
                                 }
                                 else
                                 {
                                     //发送取消等待提示框信息
                                     if(!downLoad)
                                     {
                                         [[NSNotificationCenter defaultCenter]postNotificationName:@"HideWait" object:nil];
                                     }

                                     if(queueCompletionBlock)
                                     {
                                         
                                        queueCompletionBlock(operations);
                                     }
                                   
                                 }
                                 
                                 

                             }];
    }
    else
    {
        //发送网络连接失败信息
        NSLog(@"网络连接失败");
        if(self.showNetFail)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NetFail" object:nil];
        }
        if(queueFailBlock)
        {
            queueFailBlock();
        }
    }
}

///暂停整个下载请求队列
-(void)pauseAllOperations
{
    [[RequestEngine Instance]pauseAllOperations];
}
///恢复整个下载请求队列
-(void)resumeAllOperations
{
    //检查网络状态
    AppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    if([appDelegate.reach currentReachabilityStatus]>0)
    {
         [[RequestEngine Instance]resumeAllOperations];
    }
    else
    {
        //发送下载相关网络状况通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NetFail" object:nil];
    }
   
}
///取消整个下载请求队列
-(void)concelAllOperations
{
    [[RequestEngine Instance]concelAllOperations];
}
///打印日志
-(void)printLog:(BusinessRequestType) requestType parameters:(NSDictionary *)dic
{
    NSString * requestName=[[BusinessURL Instance]getNameWithRequest:requestType];
    NSString * requestURL=[[BusinessURL Instance]getURLWithRequest:requestType];
    
    
    //开始打印请求日志
    NSMutableString * str=[NSMutableString
                           stringWithFormat:@"\n----------正在请求接口%@----------\n",requestName];
    [str appendString:[NSString stringWithFormat:@"接口地址：%@\n",requestURL]];
    
    if(dic)
    {
        for(NSString * key in dic.allKeys)
        {
            NSString * value=[dic objectForKey:key];
            [str appendString:[NSString stringWithFormat:@"接口参数key：%@\n",key]];
            [str appendString:[NSString stringWithFormat:@"接口参数值：%@\n",value]];
        }
    }
    else
    {
        [str appendString:@"无接口参数：\n"];
    }
    
    NSLog(@"%@",str);
}
@end
