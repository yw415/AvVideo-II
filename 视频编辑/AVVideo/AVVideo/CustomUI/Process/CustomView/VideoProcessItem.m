//
//  VideoProcessItem.m
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoProcessItem.h"
#import "UISDK.h"
#define FontSize1 13
@implementation VideoProcessItem

#pragma mark - 界面生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor blackColor];
        [self addSubviews];
    }
    return self;
}

#pragma mark - 自定义方法
/// 添加子视图
-(void)addSubviews
{
    // 通用参数
    CGRect rect=CGRectZero;
    UIFont * font=[UIFont systemFontOfSize:FontSize1];
    UIColor * color=[UIColor whiteColor];
    // 添加label
    rect=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.label=[[UISDK Instance]addLabel:rect
                                    font:font
                                color:color
                                    text:nil
                               alignment:NSTextAlignmentCenter
                                    view:self];
}
@end