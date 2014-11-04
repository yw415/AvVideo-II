//
//  ErrorListModel.m
//  GeneralFrame
//
//  Created by user on 14-7-12.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "ErrorListModel.h"

@implementation ErrorListModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_errorID forKey:@"errorID"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_errorNum forKey:@"errorNum"];
    [aCoder encodeObject:_totalNum forKey:@"totalNum"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.errorID = [aDecoder decodeObjectForKey:@"errorID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.errorNum=[aDecoder decodeObjectForKey:@"errorNum"];
        self.totalNum=[aDecoder decodeObjectForKey:@"totalNum"];
    }
    return  self;
}
@end
