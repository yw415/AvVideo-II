//
//  UINavigationBar+CustomBar.m
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "UINavigationBar+CustomBar.h"

@implementation UINavigationBar (CustomBar)
//通过所给予的图片改变导航栏背景色 (ios5.0支持)
-(void)changeBackGround:(UIImage *)img
{
    if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //第二个参数的意义
        //UIBarMetricsDefault：用竖着（拿手机）时UINavigationBar的标准的尺寸来显示UINavigationBar
        //UIBarMetricsLandscapePhone：用横着时UINavigationBar的标准尺寸来显示UINavigationBar
        [self setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        //去处ios7默认下划线
        if(!IOS5_OR_BEFORE)
        {
            [self setShadowImage:[UIImage new]];
        }
        self.translucent=NO;
    }
}
//根据所给予的参数改变导航栏文字颜色(ios5.0支持)
-(void)changeNavFont:(UIColor *) color
{
    if([self respondsToSelector:@selector(setTitleTextAttributes:)])
    {
        //设置要修改的键值表
        //UITextAttributeTextColor 导航栏文字颜色对应键
        //UITextAttributeTextShadowColor 导航栏阴影颜色对应键
        //UITextAttributeTextShadowOffset 导航栏阴影偏斜对应键
        NSDictionary * navBarTitleTextAttributes=[NSDictionary dictionaryWithObjectsAndKeys:
                                                  color,
                                                  UITextAttributeTextColor,
                                                  [UIColor clearColor],
                                                  UITextAttributeTextShadowColor,
                                                  [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)],UITextAttributeTextShadowOffset,
                                                  nil];
        [self setTitleTextAttributes:navBarTitleTextAttributes];
    }
}

@end
