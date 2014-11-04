//
//  CustomHorizontalScrollView.m
//  AVVideoExample
//
//  Created by user on 14-9-9.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "CustomHorizontalScrollView.h"

@implementation CustomHorizontalScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
