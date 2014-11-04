//
//  TrainAnswerPoint.h
//  GeneralFrame
//
//  Created by user on 14-7-1.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainAnswerPoint : NSObject
@property(nonatomic,strong)NSString * pID;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * parentID;
@property(nonatomic,strong)NSArray * childs;
@property(nonatomic,strong)NSString * totalQuestion;
@property(nonatomic,strong)NSString * changeRate;
@property(nonatomic,strong)NSString * masterDegree;
@property(nonatomic,assign)BOOL isOpen;
@end
