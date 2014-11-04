//
//  UINavigationBar+CustomBar.h
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CustomBar)
//通过所给予的图片改变导航栏背景色 (ios5.0支持)
-(void)changeBackGround:(UIImage *) img;
//根据所给予的参数改变导航栏文字颜色(ios5.0支持)
-(void)changeNavFont:(UIColor *) color;
@end
