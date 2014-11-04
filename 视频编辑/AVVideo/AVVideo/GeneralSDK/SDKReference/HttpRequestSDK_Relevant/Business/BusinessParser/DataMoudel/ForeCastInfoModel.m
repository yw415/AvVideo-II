//
//  ForeCastInfoModel.m
//  GeneralFrame
//
//  Created by user on 14-7-7.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ForeCastInfoModel.h"

@implementation ForeCastInfoModel
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_totalNum forKey:@"totalNum"];
    [aCoder encodeObject:_rightNum forKey:@"rightNum"];
    [aCoder encodeObject:_forecastRight forKey:@"forecastRight"];
    [aCoder encodeObject:_wrongNum forKey:@"wrongNum"];
    [aCoder encodeObject:_forecastWrong forKey:@"forecastWrong"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.totalNum = [aDecoder decodeObjectForKey:@"totalNum"];
        self.rightNum = [aDecoder decodeObjectForKey:@"rightNum"];
        self.forecastRight = [aDecoder decodeObjectForKey:@"forecastRight"];
        self.wrongNum = [aDecoder decodeObjectForKey:@"wrongNum"];
        self.forecastWrong = [aDecoder decodeObjectForKey:@"forecastWrong"];
    }
    return  self;
}
@end
