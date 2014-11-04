//
//  VideoRecordProgress.m
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoRecordProgress.h"
@interface VideoRecordProgress();
/* 各视图控件开始 */
// 背景图
@property(nonatomic,strong)UIView * background;
// 进度条
@property(nonatomic,strong)UIView * progressview;
// 阀值
@property(nonatomic,strong)UIView * threshold;
// 标识
@property(nonatomic,strong)UIView * accessory;
// 准备删除的区间
@property(nonatomic,strong)UIView * prepareDeletedItem;
/* 各视图控件结束 */

// 计时器
@property(nonatomic,strong)NSTimer * timer;

// 暂停标识集合
@property(nonatomic,strong)NSMutableArray * suspendAccessory;

@end
#pragma mark - 界面生命周期
@implementation VideoRecordProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubviews];
        self.suspendAccessory=[NSMutableArray array];
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

#pragma mark - 主视图UI配置相关
/// 添加子视图
-(void)addSubviews
{
    // 通用参数
    CGRect rect=CGRectZero;
    
    // 添加背景
    self.background=[[UIView alloc]initWithFrame:self.bounds];
    self.background.backgroundColor=[UIColor blackColor];
    self.background.alpha=0.5;
    [self addSubview:self.background];
    
    // 添加进度条
    self.progressview=[[UIView alloc]initWithFrame:rect];
    self.progressview.backgroundColor=[UIColor greenColor];
    [self addSubview:self.progressview];
    
    // 添加阀值
    float x=RequireTime/MaxTime*ScreenWidth;
    rect=CGRectMake(x, 0, 5, self.bounds.size.height);
    self.threshold=[[UIView alloc]initWithFrame:rect];
    self.threshold.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.threshold];
    
    // 添加标识
    rect=CGRectMake(0, 0, 5, self.bounds.size.height);
    self.accessory=[[UIView alloc]initWithFrame:rect];
    self.accessory.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.accessory];
    
    // 添加准备删除的区间
    rect=CGRectZero;
    self.prepareDeletedItem=[[UIView alloc]initWithFrame:rect];
    self.prepareDeletedItem.backgroundColor=[UIColor redColor];
    [self addSubview:self.prepareDeletedItem];
    
}

#pragma mark - 计时器相关
/// 停止计时器
-(void)stopTime
{
    [self.timer invalidate];
    self.timer=nil;
}

/// 开始计时器
-(void)startTime
{
    if (!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.5
                                                    target:self
                                                  selector:@selector(twinkle)
                                                  userInfo:nil
                                                   repeats:YES];
        
        [self.timer setFireDate:[NSDate distantPast]];
    }
}

/// 计时器闪烁方法
-(void)twinkle
{
    self.accessory.hidden=!self.accessory.hidden;
}

#pragma mark - 功能方法
/// 重置视图状态
-(void)reset
{
    for(UIView * view in self.suspendAccessory)
    {
        [view removeFromSuperview];
    }
    
    [self.suspendAccessory removeAllObjects];
    self.prepareDeletedItem.frame=CGRectZero;
    self.accessory.frame=CGRectMake(0, 0, self.accessory.frame.size.width, self.accessory.frame.size.height);
    self.progressview.frame=CGRectZero;
}

/// 准备删除进度条区间
-(void)prepareChangeProgressview
{
    float x=0.0;
    float width=0.0;
    
    if(self.suspendAccessory.count>=2)
    {
        UIView * view=[self.suspendAccessory objectAtIndex:self.suspendAccessory.count-2];
        x=view.frame.origin.x;
        width=self.progressview.frame.size.width-x;
    }
    else if(self.suspendAccessory.count>=1)
    {
        UIView * view=[self.suspendAccessory lastObject];
        width=view.frame.origin.x;
    }
  
    self.prepareDeletedItem.frame=CGRectMake(x, 0, width, self.frame.size.height);
}

/// 回复删除进度条
-(void)resumeChangeProgressview
{
    self.prepareDeletedItem.frame=CGRectZero;
}

/// 删除进度条区间
-(void)deleteProgressview:(float)percent;
{
    float width=ScreenWidth*percent;
    CGRect rect=CGRectMake(0, 0, width, self.frame.size.height);
    self.progressview.frame=rect;
    self.accessory.frame=CGRectMake(width, 0, 5, self.frame.size.height);
    
    if(self.suspendAccessory&&self.suspendAccessory.count>0)
    {
        UIView * view =[self.suspendAccessory lastObject];
        [view removeFromSuperview];
        [self.suspendAccessory removeLastObject];
    
    }
    
    self.prepareDeletedItem.frame=CGRectZero;
}

/// 根据百分比改变进度条
-(void)changeProgressview:(float)percent
{
    float width=ScreenWidth*percent;
    CGRect rect=CGRectMake(0, 0, width, self.frame.size.height);
    self.progressview.frame=rect;
    self.accessory.frame=CGRectMake(width, 0, 5, self.frame.size.height);
}

/// 添加暂停标识
-(void)addSuspendAccessory
{
    float x=self.accessory.frame.origin.x;
    CGRect rect=CGRectMake(x,0,2,self.frame.size.height);
    UIView * suspendAccessory=[[UIView alloc]initWithFrame:rect];
    suspendAccessory.backgroundColor=[UIColor blackColor];
    [self addSubview:suspendAccessory];
    [self.suspendAccessory addObject:suspendAccessory];
}
@end
