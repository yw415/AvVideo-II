//
//  TrainAnswerSheet.h
//  GeneralFrame
//
//  Created by user on 14-6-30.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainAnswerSheet : NSObject
@property(nonatomic,strong)NSString * paperID;
@property(nonatomic,strong)NSString * index;
@property(nonatomic,strong)NSString * questionID;
@property(nonatomic,strong)NSArray * answers;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,assign)BOOL isFavorite;
@end
