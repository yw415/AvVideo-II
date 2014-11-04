//
//  AccessAbilityModel.m
//  GeneralFrame
//
//  Created by user on 14-5-1.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "AccessAbilityModel.h"

@implementation AccessAbilityModel

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_synthetic forKey:@"synthetic"];
    [aCoder encodeObject:_commonsense forKey:@"commonsense"];
    [aCoder encodeObject:_language forKey:@"language"];
    [aCoder encodeObject:_quantityrel forKey:@"quantityrel"];
    [aCoder encodeObject:_inference forKey:@"inference"];
    [aCoder encodeObject:_dataanalysis forKey:@"dataanalysis"];
    [aCoder encodeObject:_othersability forKey:@"othersability"];
    [aCoder encodeObject:_defeatpercent forKey:@"defeatpercent"];
    [aCoder encodeObject:_totalquestionnum forKey:@"totalquestionnum"];
}
// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.synthetic = [aDecoder decodeObjectForKey:@"synthetic"];
        self.commonsense = [aDecoder decodeObjectForKey:@"commonsense"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.quantityrel = [aDecoder decodeObjectForKey:@"quantityrel"];
        self.inference = [aDecoder decodeObjectForKey:@"inference"];
        self.dataanalysis = [aDecoder decodeObjectForKey:@"dataanalysis"];
        self.othersability = [aDecoder decodeObjectForKey:@"othersability"];
        self.defeatpercent = [aDecoder decodeObjectForKey:@"defeatpercent"];
        self.totalquestionnum = [aDecoder decodeObjectForKey:@"totalquestionnum"];
    }
    return  self;
}

@end
