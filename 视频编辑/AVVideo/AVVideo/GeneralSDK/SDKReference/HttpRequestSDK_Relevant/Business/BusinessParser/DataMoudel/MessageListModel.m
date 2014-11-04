//
//  MessageListModel.m
//  GeneralFrame
//
//  Created by user on 14-7-25.
//  Copyright (c) 2014年 ios. All rights reserved.
//

//@property(nonatomic,strong)NSString * msgID;
//@property(nonatomic,strong)NSString * useType;
//@property(nonatomic,strong)NSString * title;
//@property(nonatomic,strong)NSString * content;
//@property(nonatomic,assign)BOOL isOld;

#import "MessageListModel.h"

@implementation MessageListModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_msgID forKey:@"msgID"];
    [aCoder encodeObject:_useType forKey:@"useType"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_content forKey:@"content"];
    [aCoder encodeBool:_isOld forKey:@"isOld"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.msgID = [aDecoder decodeObjectForKey:@"msgID"];
        self.useType = [aDecoder decodeObjectForKey:@"useType"];
        self.title=[aDecoder decodeObjectForKey:@"title"];
        self.content=[aDecoder decodeObjectForKey:@"content"];
        self.isOld=[aDecoder decodeBoolForKey:@"isOld"];
    }
    return  self;
}
@end
