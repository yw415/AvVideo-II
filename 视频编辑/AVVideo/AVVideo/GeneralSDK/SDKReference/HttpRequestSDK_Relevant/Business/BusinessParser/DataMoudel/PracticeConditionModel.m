//
//  PracticeConditionModel.m
//  GeneralFrame
//
//  Created by user on 14-5-23.
//  Copyright (c) 2014年 ios. All rights reserved.
//

//@property(nonatomic,strong)NSString * times;
//@property(nonatomic,strong)NSString * masterDegree;
//@property(nonatomic,strong)NSString * masterLevel;
//@property(nonatomic,strong)NSString * coverDegree;
//@property(nonatomic,strong)NSString * coverLevel;
//@property(nonatomic,strong)NSString * speedDegree;
//@property(nonatomic,strong)NSString * speedLevel;
//@property(nonatomic,strong)NSString * accuracyLevel;
//@property(nonatomic,strong)NSString * dailyFrequency;
//@property(nonatomic,strong)NSString * adviceFrequency;
//@property(nonatomic,strong)NSString * dailyPaytime;
//@property(nonatomic,strong)NSString * advicePaytime;
#import "PracticeConditionModel.h"

@implementation PracticeConditionModel

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_times forKey:@"times"];
    [aCoder encodeObject:_masterDegree forKey:@"masterDegree"];
    [aCoder encodeObject:_masterLevel forKey:@"masterLevel"];
    [aCoder encodeObject:_coverDegree forKey:@"coverDegree"];
    [aCoder encodeObject:_coverLevel forKey:@"coverLevel"];
    [aCoder encodeObject:_speedDegree forKey:@"speedDegree"];
    [aCoder encodeObject:_speedLevel forKey:@"speedLevel"];
    [aCoder encodeObject:_accuracyDegree forKey:@"accuracyDegree"];
    [aCoder encodeObject:_accuracyLevel forKey:@"accuracyLevel"];
    [aCoder encodeObject:_dailyFrequency forKey:@"dailyFrequency"];
    [aCoder encodeObject:_adviceFrequency forKey:@"adviceFrequency"];
    [aCoder encodeObject:_dailyPaytime forKey:@"dailyPaytime"];
    [aCoder encodeObject:_advicePaytime forKey:@"advicePaytime"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.times = [aDecoder decodeObjectForKey:@"times"];
        self.masterDegree = [aDecoder decodeObjectForKey:@"masterDegree"];
        self.masterLevel = [aDecoder decodeObjectForKey:@"masterLevel"];
        self.coverDegree = [aDecoder decodeObjectForKey:@"coverDegree"];
        self.coverLevel = [aDecoder decodeObjectForKey:@"coverLevel"];
        self.speedDegree = [aDecoder decodeObjectForKey:@"speedDegree"];
        self.speedLevel = [aDecoder decodeObjectForKey:@"speedLevel"];
        self.accuracyDegree= [aDecoder decodeObjectForKey:@"accuracyDegree"];
        self.accuracyLevel = [aDecoder decodeObjectForKey:@"accuracyLevel"];
        self.dailyFrequency = [aDecoder decodeObjectForKey:@"dailyFrequency"];
        self.adviceFrequency= [aDecoder decodeObjectForKey:@"adviceFrequency"];
        self.dailyPaytime = [aDecoder decodeObjectForKey:@"dailyPaytime"];
        self.advicePaytime = [aDecoder decodeObjectForKey:@"advicePaytime"];
    }
    return  self;
}

@end
