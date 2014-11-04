//
//  Parser.h
//  GeneralFrame
//
//  Created by user on 14-4-15.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessEnmu.h"
//解析器 用来解析json字符串 与业务关连 无法分离
@interface Parser : NSObject
#pragma mark - 登录模块相关接口解析
//单例模式
+(Parser *)Instance;
//通过请求类型进行解析
-(id)parserWithRequestType:(BusinessRequestType)requestType json:(NSData *)json;
@end
