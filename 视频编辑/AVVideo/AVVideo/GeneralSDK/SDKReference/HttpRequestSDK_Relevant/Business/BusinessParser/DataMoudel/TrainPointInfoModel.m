//
//  TrainPointInfoModel.m
//  GeneralFrame
//
//  Created by user on 14-6-3.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "TrainPointInfoModel.h"

//@property(nonatomic,strong)NSString * finish;
//@property(nonatomic,strong)NSString * masterLevel;
//@property(nonatomic,strong)NSString * pointID;
//@property(nonatomic,strong)NSString * name;
//@property(nonatomic,strong)NSString * level;
//@property(nonatomic,strong)NSString * parentID;

@implementation TrainPointInfoModel
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_finish forKey:@"finish"];
    [aCoder encodeObject:_masterLevel forKey:@"masterLevel"];
    [aCoder encodeObject:_parentID forKey:@"pointID"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_level forKey:@"level"];
    [aCoder encodeObject:_parentID forKey:@"parentID"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.finish = [aDecoder decodeObjectForKey:@"finish"];
        self.masterLevel = [aDecoder decodeObjectForKey:@"masterLevel"];
        self.pointID = [aDecoder decodeObjectForKey:@"pointID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.level = [aDecoder decodeObjectForKey:@"level"];
        self.parentID = [aDecoder decodeObjectForKey:@"parentID"];
        
    }
    return  self;
}
@end
