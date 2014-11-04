//
//  General_ViewController.m
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "General_ViewController.h"
#import "UtilitySDK.h"
#import "UINavigationBar+CustomBar.h"
@interface General_ViewController ()
{
   
}
@property(nonatomic,strong)UIImageView * bgView;
@end

@implementation General_ViewController

#pragma mark - 界面生命周期
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self=[super init];
    
    if(self)
    {
        
    }
    
    return self;
};

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    //ios7兼容
    if (IOS7_OR_LATER)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }
    
    [self.navigationController.navigationBar setHidden:NO];
    
    /*开始导航栏基本配置*/
    //改变导航栏背景
    UIImage * navBackGround;
    navBackGround=[[UtilitySDK Instance]getImageFromColor:[UIColor blackColor]
                                                     rect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.navigationController.navigationBar changeBackGround:navBackGround];
    [self.navigationController.navigationBar changeNavFont:[UIColor whiteColor]];
    /*结束导航栏基本配置*/

    
    /*开始设置页面背景色*/
    self.view.backgroundColor=[UIColor whiteColor];
    self.bgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [self.view addSubview:self.bgView];
    [self setBackGround];
    /*结束设置页面背景色*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
}

#pragma mark - 自定义方法
//根据枚举值选择背景颜色
-(void)setBackGround
{
    UIImage * bgImg=[[UtilitySDK Instance]getImageFromColor:[UIColor blackColor]
                                                              rect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    switch (_viewName)
//    {
//        case View_Main:
//        {
//        }
//            break;
//    }
    self.bgView.image=bgImg;
}

@end
