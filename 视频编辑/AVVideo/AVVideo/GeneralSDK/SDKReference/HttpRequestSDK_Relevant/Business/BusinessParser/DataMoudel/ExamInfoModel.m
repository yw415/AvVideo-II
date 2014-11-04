//
//  ExamInfoModel.m
//  GeneralFrame
//
//  Created by user on 14-5-27.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ExamInfoModel.h"
//@property(nonatomic,strong)NSArray * timesScore;
//@property(nonatomic,strong)NSString * averageTime;
//@property(nonatomic,strong)NSString * commonsenseTime;
//@property(nonatomic,strong)NSString * languageTime;
//@property(nonatomic,strong)NSString * quantityRelTime;
//@property(nonatomic,strong)NSString * inferenceTime;
//@property(nonatomic,strong)NSString * dataAnalysisTime;
@implementation ExamInfoModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_timesScore forKey:@"timesScore"];
    [aCoder encodeObject:_averageTime forKey:@"averageTime"];
    [aCoder encodeObject:_commonsenseTime forKey:@"commonsenseTime"];
    [aCoder encodeObject:_languageTime forKey:@"languageTime"];
    [aCoder encodeObject:_quantityRelTime forKey:@"quantityRelTime"];
    [aCoder encodeObject:_inferenceTime forKey:@"inferenceTime"];
    [aCoder encodeObject:_dataAnalysisTime forKey:@"dataAnalysisTime"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.timesScore = [aDecoder decodeObjectForKey:@"timesScore"];
        self.averageTime = [aDecoder decodeObjectForKey:@"averageTime"];
        self.commonsenseTime = [aDecoder decodeObjectForKey:@"commonsenseTime"];
        self.languageTime = [aDecoder decodeObjectForKey:@"languageTime"];
        self.quantityRelTime = [aDecoder decodeObjectForKey:@"quantityRelTime"];
        self.inferenceTime = [aDecoder decodeObjectForKey:@"inferenceTime"];
        self.dataAnalysisTime = [aDecoder decodeObjectForKey:@"dataAnalysisTime"];
    }
    return  self;
}
@end
