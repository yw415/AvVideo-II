//
//  PointMasterModel.m
//  GeneralFrame
//
//  Created by user on 14-5-20.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "PointMasterModel.h"


@implementation PointMasterModel

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_masterDegree forKey:@"masterDegree"];
    [aCoder encodeObject:_doneQuestion forKey:@"doneQuestion"];
    [aCoder encodeObject:_accuracy forKey:@"accuracy"];
    [aCoder encodeObject:_grade forKey:@"grade"];
    [aCoder encodeObject:_pID forKey:@"pID"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_level forKey:@"level"];
    [aCoder encodeObject:_parentID forKey:@"parentID"];
    [aCoder encodeObject:_childs forKey:@"childs"];
    [aCoder encodeObject:_totalQuestion forKey:@"totalQuestion"];
    [aCoder encodeBool:_isOpen forKey:@"isOpen"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.masterDegree = [aDecoder decodeObjectForKey:@"masterDegree"];
        self.doneQuestion = [aDecoder decodeObjectForKey:@"doneQuestion"];
        self.accuracy = [aDecoder decodeObjectForKey:@"accuracy"];
        self.grade = [aDecoder decodeObjectForKey:@"grade"];
        self.pID = [aDecoder decodeObjectForKey:@"pID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.level = [aDecoder decodeObjectForKey:@"level"];
        self.parentID = [aDecoder decodeObjectForKey:@"parentID"];
        self.childs = [aDecoder decodeObjectForKey:@"childs"];
        self.totalQuestion = [aDecoder decodeObjectForKey:@"totalQuestion"];
        self.isOpen=[aDecoder decodeBoolForKey:@"isOpen"];
    }
    return  self;
}



@end
