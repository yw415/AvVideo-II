//
//  CompetRankingModel.m
//  GeneralFrame
//
//  Created by user on 14-7-19.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "CompetRankingModel.h"

@implementation CompetRankingModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userID forKey:@"userID"];
    [aCoder encodeObject:_nickName forKey:@"nickName"];
    [aCoder encodeObject:_ranking forKey:@"ranking"];
    [aCoder encodeObject:_athleticsNum forKey:@"athleticsNum"];
    [aCoder encodeObject:_athleticsAvggrade forKey:@"athleticsAvggrade"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.ranking=[aDecoder decodeObjectForKey:@"ranking"];
        self.athleticsNum=[aDecoder decodeObjectForKey:@"athleticsNum"];
        self.athleticsAvggrade=[aDecoder decodeObjectForKey:@"athleticsAvggrade"];
    }
    return  self;
}
@end
