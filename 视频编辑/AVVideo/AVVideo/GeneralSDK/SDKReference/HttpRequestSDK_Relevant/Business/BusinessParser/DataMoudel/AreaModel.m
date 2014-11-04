//
//  AreaMoudel.m
//  GeneralFrame
//
//  Created by user on 14-4-18.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_areaID forKey:@"areaID"];
    [aCoder encodeObject:_areaName forKey:@"areaName"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.areaID = [aDecoder decodeObjectForKey:@"areaID"];
        self.areaName = [aDecoder decodeObjectForKey:@"areaName"];
    }
    return  self;
}

@end
