//
//  AccessAbilityModel.h
//  GeneralFrame
//
//  Created by user on 14-5-1.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessAbilityModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString * synthetic;
@property(nonatomic,strong)NSString * commonsense;
@property(nonatomic,strong)NSString * language;
@property(nonatomic,strong)NSString * quantityrel;
@property(nonatomic,strong)NSString * inference;
@property(nonatomic,strong)NSString * dataanalysis;
@property(nonatomic,strong)NSString * othersability;
@property(nonatomic,strong)NSString * defeatpercent;
@property(nonatomic,strong)NSString * totalquestionnum;
@end
