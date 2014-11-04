//
//  FavoriteListModel.m
//  GeneralFrame
//
//  Created by user on 14-7-13.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "FavoriteListModel.h"

@implementation FavoriteListModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_favoriteID forKey:@"favoriteID"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_favoriteNum forKey:@"favoriteNum"];
    [aCoder encodeObject:_totalNum forKey:@"totalNum"];
}

// 反序列化时提取成员变量
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.favoriteID = [aDecoder decodeObjectForKey:@"favoriteID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.favoriteNum=[aDecoder decodeObjectForKey:@"favoriteNum"];
        self.totalNum=[aDecoder decodeObjectForKey:@"totalNum"];
    }
    return  self;
}
@end
