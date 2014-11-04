//
//  ConfigSDK.m
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ConfigSDK.h"

@implementation ConfigSDK
///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}
///单例模式
+(ConfigSDK *)Instance
{
    static ConfigSDK * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

#pragma mark - DDGPreferences委托方法
///设置默认值
-(void)setDefaultPreferences
{
    
}

///保存当前值
-(void)save
{
    if (self.isDirty) {
        [self writePreferences];
    }
}
@end
