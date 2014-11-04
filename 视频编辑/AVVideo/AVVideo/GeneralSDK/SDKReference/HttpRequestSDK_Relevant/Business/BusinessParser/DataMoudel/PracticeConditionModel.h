//
//  PracticeConditionModel.h
//  GeneralFrame
//
//  Created by user on 14-5-23.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PracticeConditionModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString * times;
@property(nonatomic,strong)NSString * masterDegree;
@property(nonatomic,strong)NSString * masterLevel;
@property(nonatomic,strong)NSString * coverDegree;
@property(nonatomic,strong)NSString * coverLevel;
@property(nonatomic,strong)NSString * speedDegree;
@property(nonatomic,strong)NSString * speedLevel;
@property(nonatomic,strong)NSString * accuracyDegree;
@property(nonatomic,strong)NSString * accuracyLevel;
@property(nonatomic,strong)NSString * dailyFrequency;
@property(nonatomic,strong)NSString * adviceFrequency;
@property(nonatomic,strong)NSString * dailyPaytime;
@property(nonatomic,strong)NSString * advicePaytime;
@end
