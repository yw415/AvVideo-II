//
//  CompetRoomModel.h
//  GeneralFrame
//
//  Created by user on 14-7-22.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompetRoomModel : NSObject
@property(nonatomic,strong)NSString * roomID;
@property(nonatomic,strong)NSString * roomCode;
@property(nonatomic,strong)NSString * maxNum;
@property(nonatomic,strong)NSString * examType;
@property(nonatomic,strong)NSString * topicNum;
@property(nonatomic,strong)NSString * examTime;
@property(nonatomic,strong)NSString * curNum;
@property(nonatomic,strong)NSString * startTime;
@property(nonatomic,strong)NSString * waitTime;
@property(nonatomic,strong)NSString * state;
@property(nonatomic,strong)NSString * countDown;
@property(nonatomic,strong)NSString * success;
@end
