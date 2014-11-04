//
//  BusinessURL.h
//  GeneralFrame
//
//  Created by user on 14-4-16.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessEnmu.h"
@interface BusinessURL:NSObject
//单例
+(BusinessURL *)Instance;
//获取接口地址
-(NSString *) getURLWithRequest:(BusinessRequestType) requestType;
//获取接口名称
-(NSString *) getNameWithRequest:(BusinessRequestType) requestType;
@end

