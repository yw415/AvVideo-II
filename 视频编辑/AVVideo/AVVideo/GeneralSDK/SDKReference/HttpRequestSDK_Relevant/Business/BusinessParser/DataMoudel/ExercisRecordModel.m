//
//  ExercisRecordModel.m
//  GeneralFrame
//
//  Created by user on 14-7-9.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ExercisRecordModel.h"

@implementation ExercisRecordModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_recordID forKey:@"recordID"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_totalNum forKey:@"totalNum"];
    [aCoder encodeObject:_rightNum forKey:@"rightNum"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.recordID = [aDecoder decodeObjectForKey:@"recordID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.totalNum = [aDecoder decodeObjectForKey:@"totalNum"];
        self.rightNum = [aDecoder decodeObjectForKey:@"rightNum"];
    }
    return  self;
}
@end
