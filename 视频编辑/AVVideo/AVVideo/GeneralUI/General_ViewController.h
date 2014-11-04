//
//  General_ViewController.h
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISDK.h"
#import "NSArray+objectAtIndexSafe.h"
//页面模块枚举
typedef enum {
    View_Main,
}ViewName;

@interface General_ViewController : UIViewController
{
     ViewName _viewName;
}
@end
