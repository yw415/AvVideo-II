//
//  MessageListModel.h
//  GeneralFrame
//
//  Created by user on 14-7-25.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListModel : NSObject
@property(nonatomic,strong)NSString * msgID;
@property(nonatomic,strong)NSString * useType;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,assign)BOOL isOld;
@end
