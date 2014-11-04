//
//  QuestionContent.h
//  GeneralFrame
//
//  Created by user on 14-6-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionContent : NSObject
@property(nonatomic,strong)NSString * qID;
@property(nonatomic,strong)NSString * stem;
@property(nonatomic,strong)NSString * question;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSArray * choice;
@property(nonatomic,strong)NSString * standardAnswer;
@property(nonatomic,strong)NSString * sourceYear;
@property(nonatomic,strong)NSString * source;
@property(nonatomic,strong)NSString * seqinpastPaper;
@property(nonatomic,strong)NSString * paperName;
@property(nonatomic,strong)NSString * selectedChoice;
@property(nonatomic,strong)NSString * payTime;
@property(nonatomic,strong)NSString * jsonStr;
@property(nonatomic,assign)BOOL isFavorite;
@end
