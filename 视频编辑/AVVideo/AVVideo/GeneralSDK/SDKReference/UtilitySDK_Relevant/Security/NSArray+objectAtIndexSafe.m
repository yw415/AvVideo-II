//
//  NSArray+objectAtIndexSafeSafe.m
//  GeneralFrame
//
//  Created by user on 14-7-12.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "NSArray+objectAtIndexSafe.h"

@implementation NSArray (objectAtIndexSafe)
- (id)objectAtIndexSafe:(NSUInteger)index
{
	if( index < self.count )
	{
		return [self objectAtIndex:index];
	}
	else
	{
		NSLog(@"!!!数组越界!!! ");
		return nil;
	}
}
@end

@implementation NSMutableArray (objectAtIndexSafe)
- (id)objectAtIndexSafe:(NSUInteger)index
{
	if( index < self.count )
	{
		return [self objectAtIndex:index];
	}
	else
	{
		NSLog(@"!!!数组越界!!! ");
		return nil;
	}
}
@end
