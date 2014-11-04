//
//  CustomHorizontalTable.m
//  AVVideoExample
//
//  Created by user on 14-9-5.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "CustomHorizontalTable.h"
#import "CustomHorizontalScrollView.h"
#import "UISDK.h"
@interface CustomHorizontalTable()
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * items;
@end
#pragma mark - 界面生命周期
@implementation CustomHorizontalTable

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

    self.scrollView=[[CustomHorizontalScrollView alloc]initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 ScreenWidth,
                                                                  self.frame.size.height)];

    [self addSubview:self.scrollView];
    
    // 使拉动按钮可以滚动
    self.scrollView.canCancelContentTouches=YES;
}

//根据数据配置各项
-(void)reloadData
{
    if(self.delegate)
    {
        //通用参数
        float margin =[self.delegate itemMargin];
        float count =[self.delegate itemCount];
        float width=[self.delegate itemView:0].frame.size.width;
        __weak CustomHorizontalTable * tempView=self;
        
        /*开始配置滚动视图*/
        CGSize size=CGSizeMake(width*count+margin*(count+1), self.frame.size.height);
        self.scrollView.contentSize=size;
        NSArray * views=self.scrollView.subviews;
        for(UIView * view in views)
        {
            [view removeFromSuperview];
        }
        
        /*结束配置滚动视图*/
        
        
        /*开始配置内容视图*/
        for(int i=0;i<count;i++)
        {
            float originx=0;
            originx=i*width+(i+1)*margin;
        
            CGRect rect=CGRectMake(originx, 0, width, self.frame.size.height);
            UIView * item=[self.delegate itemView:i];
            item.frame=rect;
            [self.scrollView addSubview:item];
            [self.items addObject:item];
            
            UIButton * but=[[UISDK Instance]addButton:item.frame
                                                title:nil
                                                color:nil
                                               hcolor:nil
                                                 font:nil
                                                bgImg:nil
                                               selImg:nil
                                                block:^(UIButton *but) {
                                                    int index=(int)but.tag-1;
                                                    UIView * item=[tempView.items objectAtIndex:index];
                                                    [tempView.delegate selectedItem:item
                                                                              index:index];
                                        
                                                }
                                                 view:self.scrollView];
            but.tag=i+1;
            [but setBackgroundImage:nil forState:UIControlStateNormal];
            [but setBackgroundImage:nil forState:UIControlStateHighlighted];
            [but setBackgroundColor:[UIColor clearColor]];
            but.layer.borderWidth=0;
            but.layer.cornerRadius=0;
            
        }
        /*结束配置内容视图*/
    }

}


@end
