//
//  QuestionAllInfo.h
//  GeneralFrame
//
//  Created by user on 14-7-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionAllInfo : NSObject
@property(nonatomic,strong)NSString * qid;
@property(nonatomic,strong)NSString * question;
@property(nonatomic,strong)NSString * answerComment;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,assign)BOOL isFavorite;
@end
