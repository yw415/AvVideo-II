//
//  CustomToolBar.m
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "CustomToolBar.h"
#import "UISDK.h"
@interface CustomToolBar()
@property(nonatomic,strong)NSMutableArray * items;
@end
@implementation CustomToolBar
#pragma mark - 界面生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.items=[NSMutableArray array];
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

#pragma mark - 自定义方法
-(void)reloadData
{
    if(self.delegate)
    {
        __weak CustomToolBar * tempView=self;
        int count=[self.delegate itemCount];
        float width=ScreenWidth/count;
        
        
        for(int i=0;i<count;i++)
        {
            UIView * item=[self.delegate itemView:i];
            item.frame=CGRectMake(width*i, 0, width, item.bounds.size.height);
            [self addSubview:item];
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
                                                    [tempView selectedItem:index];
                                                }
                                                 view:self];
            but.tag=i+1;
            [but setBackgroundImage:nil forState:UIControlStateNormal];
            [but setBackgroundImage:nil forState:UIControlStateHighlighted];
            [but setBackgroundColor:[UIColor clearColor]];
            but.layer.borderWidth=0;
            but.layer.cornerRadius=0;
        }
    }
}

-(void)selectedItem:(int)index
{
    for(int i=0;i<self.items.count;i++)
    {
        if(i==index)
        {
            UIView * view=[self.items objectAtIndex:index];
            [self.delegate selectedItem:view
                                      index:index];
        }
        else
        {
            if([self.delegate respondsToSelector:@selector(unselectedItem:index:)])
            {
                UIView * view=[self.items objectAtIndex:i];
                [self.delegate unselectedItem:view
                                        index:index];
            }
        }
    }
}
@end
