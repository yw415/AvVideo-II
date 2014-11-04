//
//  NSArray+objectAtIndexSafeSafe.h
//  GeneralFrame
//
//  Created by user on 14-7-12.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (objectAtIndexSafe)
- (id)objectAtIndexSafe:(NSUInteger)index;
@end

@interface NSMutableArray (objectAtIndexSafe)
- (id)objectAtIndexSafe:(NSUInteger)index;
@end