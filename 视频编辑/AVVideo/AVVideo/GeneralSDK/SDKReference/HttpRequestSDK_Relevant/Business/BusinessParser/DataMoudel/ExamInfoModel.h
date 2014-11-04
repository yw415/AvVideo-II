//
//  ExamInfoModel.h
//  GeneralFrame
//
//  Created by user on 14-5-27.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamInfoModel : NSObject
@property(nonatomic,strong)NSArray * timesScore;
@property(nonatomic,strong)NSString * averageTime;
@property(nonatomic,strong)NSString * commonsenseTime;
@property(nonatomic,strong)NSString * languageTime;
@property(nonatomic,strong)NSString * quantityRelTime;
@property(nonatomic,strong)NSString * inferenceTime;
@property(nonatomic,strong)NSString * dataAnalysisTime;
@end
