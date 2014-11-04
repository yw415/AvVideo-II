//
//  ConfigSDK.h
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDGPreferences.h"
///此API负责保存所有必要的配置参数
@interface ConfigSDK :DDGPreferences<DDGPreferences>

#pragma mark - http头相关信息
///单例方法
+(ConfigSDK *)Instance;
///保存当前值
-(void)save;
@end
