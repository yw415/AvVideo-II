//
//  PointMasterModel.h
//  GeneralFrame
//
//  Created by user on 14-5-20.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointMasterModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString * masterDegree;
@property(nonatomic,strong)NSString * doneQuestion;
@property(nonatomic,strong)NSString * accuracy;
@property(nonatomic,strong)NSString * grade;
@property(nonatomic,strong)NSString * pID;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * parentID;
@property(nonatomic,strong)NSString * totalQuestion;
@property(nonatomic,strong)NSArray  * childs;
@property(nonatomic,assign)BOOL isOpen;

@end
