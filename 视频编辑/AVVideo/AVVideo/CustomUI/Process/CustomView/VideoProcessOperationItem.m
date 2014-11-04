//
//  VideoProcessOperationItem.m
//  AVVideoExample
//
//  Created by user on 14-9-5.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoProcessOperationItem.h"
#import "UISDK.h"
@implementation VideoProcessOperationItem
#pragma mark - 界面生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubviews];
    }
    return self;
}

#pragma mark - 自定义方法
-(void)addSubviews
{
    // 通用参数
    CGRect rect=CGRectZero;
    UIFont * font=[UIFont systemFontOfSize:9];
    UIColor * color=[UIColor whiteColor];
    
    rect=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-30);
    self.image=[[UIImageView alloc]initWithFrame:rect];
    [self addSubview:self.image];
    
    rect=CGRectMake(0, rect.origin.y+rect.size.height, self.bounds.size.width, 30);
    self.title=[[UISDK Instance]addLabel:rect
                                    font:font
                                   color:color
                                    text:nil
                               alignment:NSTextAlignmentCenter
                                    view:self];
    
}
@end
