//
//  MainViewController.m
//  GeneralFramework
//
//  Created by user on 14-8-5.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "MainViewController.h"
#import "ConfigSDK.h"
#import "UtilitySDK.h"
#import "UISDK.h"
#import "VideoRecordProgress.h"
#import "VideoPreview.h"
#import "VideoProcessViewController.h"


@interface MainViewController ()

/*各种决定状态的BOOL*/
/// 已经打开闪光灯
@property(nonatomic,assign)BOOL haveLight;
/// 摄像头已经转向
@property(nonatomic,assign)BOOL haveSwitch;
/// 记录视频已停止
@property(nonatomic,assign)BOOL haveStartRecord;
/// 准备删除上次记录
@property(nonatomic,assign)BOOL havePrepareDeleteLastRecord;

/*各种视图控件*/
/// 录制进度条
@property(nonatomic,strong)VideoRecordProgress * videoProgress;
/// 录制预览
@property(nonatomic,strong)VideoPreview * videoPreview;
/// 取消录制按钮
@property(nonatomic,strong)UIButton * cancelRecordBut;
/// 录制按钮
@property(nonatomic,strong)UIButton * recordBut;
/// 储存按钮
@property(nonatomic,strong)UIButton * saveBut;

/*计时器相关*/
/// 当前记录时间
@property(nonatomic,assign)float currentTime;
/// 当前记录计时器
@property(nonatomic,strong)NSTimer * recordTime;
// 记录时间节点数组
@property(nonatomic,strong)NSMutableArray * recordTimes;

/*视频保存相关*/
// Mp4文件保存路径
@property(nonatomic,strong)NSString * recordFilePath;
@end

@implementation MainViewController

#pragma mark - 界面生命周期
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 配置计时器
        [self configTime];
        // 初始化记录节点
        self.recordTimes=[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加导航按钮
    [self addNavBut];
    
    // 添加子视图
    [self addSubviews];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 预览开始
    [self.videoPreview startRun];
    self.videoPreview.hidden=NO;
    
    // 启动进度条闪烁
    [self.videoProgress startTime];
    self.saveBut.enabled=NO;
       
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.currentTime=0;
    //删除按钮设为不可用
    self.cancelRecordBut.enabled=NO;
    //清空已记录的时间节点
    [self.recordTimes removeAllObjects];
    // 预览停止
    [self.videoPreview stopRun];
    // 停止进度条闪烁
    [self.videoProgress stopTime];
    // 重设进度条进度
    [self.videoProgress reset];
    // 隐藏预览视图
    self.videoPreview.hidden=YES;
    
    UIImage * img;
    UIImage * selImg;
    __weak MainViewController * tempView=self;
    img=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
    selImg=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
    UIBarButtonItem * leftBut=[[UISDK Instance]imgBarButton:img
                                                     selImg:selImg
                                                       text:nil
                                                      block:^(UIButton *but) {
                                                          [tempView leftNavButCall];
                                                      }
                                                leftOrRight:0];
    leftBut.enabled=NO;
    self.navigationItem.leftBarButtonItem=leftBut;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 主视图UI配置相关
/// 添加子视图
-(void)addSubviews
{
    // 通用参数
    CGRect rect=CGRectZero;
    UIImage * img=nil;
    __weak MainViewController * tempView=self;
    
    /*开始添加视频预览*/
    rect=CGRectMake(0, 0, ScreenWidth, ScreenHeight-200);
    self.videoPreview=[[VideoPreview alloc]initWithFrame:rect];
    [self.view addSubview:self.videoPreview];
    /*结束添加视频预览*/
    
    /*开始添加录制进度条*/
    rect=CGRectMake(0, 0, ScreenWidth, 15);
    self.videoProgress=[[VideoRecordProgress alloc]initWithFrame:rect];
    [self.view addSubview:self.videoProgress];
    /*结束添加录制进度条*/
    
    /*开始添加删除按钮*/
    rect=CGRectMake(15, ScreenHeight-155, 53, 53);
    img=[[UISDK Instance]getImg:@"General_ConcelBut_.png"];
    self.cancelRecordBut=[[UISDK Instance]addButton:rect
                                              title:nil
                                              color:nil
                                             hcolor:nil
                                               font:nil
                                              bgImg:img
                                             selImg:img
                                              block:^(UIButton *but) {
                                                  [tempView deleteButCall];
                                              }
                                               view:self.view];
    self.cancelRecordBut.enabled=NO;
    /*结束添加删除按钮*/
    
    /*开始添加录制按钮*/
    rect=CGRectMake(ScreenWidth/2-78/2, rect.origin.y-15, 78, 78);
    img=[[UISDK Instance]getImg:@"MainView_RecordBut.png"];
    self.recordBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBut.frame=rect;
    [self.recordBut setBackgroundImage:img
                              forState:UIControlStateNormal];
    [self.recordBut addTarget:self
                       action:@selector(recordButPressedCall)
             forControlEvents:UIControlEventTouchDown];
    [self.recordBut addTarget:self
                       action:@selector(recordButCancelCall)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordBut];
    /*结束添加录制按钮*/
    
    /*开始添加储存按钮*/
    rect=CGRectMake(ScreenWidth-53-15, rect.origin.y+15, 53, 53);
    img=[[UISDK Instance]getImg:@"MainView_SaveBut.png"];
    self.saveBut=[[UISDK Instance]addButton:rect
                                      title:nil
                                      color:nil
                                     hcolor:nil
                                       font:nil
                                      bgImg:img
                                     selImg:img
                                      block:^(UIButton *but) {
                                          [tempView saveButCall];
                                      }
                                       view:self.view];
    self.saveBut.enabled=NO;
    /*结束添加储存按钮*/
}

#pragma mark - 导航栏相关
/// 添加导航栏按钮
-(void)addNavBut
{
    /*开始配置左右导航*/
    UIImage * img;
    UIImage * selImg;
    __weak MainViewController * tempView=self;
    img=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
    selImg=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
    UIBarButtonItem * leftBut=[[UISDK Instance]imgBarButton:img
                                                     selImg:selImg
                                                       text:nil
                                                      block:^(UIButton *but) {
                                                          [tempView leftNavButCall];
                                                      }
                                                leftOrRight:0];
    leftBut.enabled=NO;
    self.navigationItem.leftBarButtonItem=leftBut;
    
    img=[[UISDK Instance]getImg:@"MainView_LightBut.png"];
    selImg=[[UISDK Instance]getImg:@"MainView_LightBut.png"];
    UIBarButtonItem * lightBut=[[UISDK Instance]imgBarButton:img
                                                      selImg:selImg
                                                        text:nil
                                                       block:^(UIButton *but) {
                                                           [tempView lightButCall];
                                                       }
                                                 leftOrRight:0];
    
    img=[[UISDK Instance]getImg:@"MainView_Switch.png"];
    selImg=[[UISDK Instance]getImg:@"MainView_Switch.png"];
    UIBarButtonItem * switchBut=[[UISDK Instance]imgBarButton:img
                                                       selImg:selImg
                                                         text:nil
                                                        block:^(UIButton *but) {
                                                            [tempView switchCameraButCall];
                                                        }
                                                  leftOrRight:0];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:switchBut,lightBut,nil];
    /*结束配置左右导航*/

}

/// 左导航按钮方法
-(void)leftNavButCall
{
    __weak MainViewController * tempView=self;
    
    [[UISDK Instance]showAlert:@"提示"
                       message:@"确定删除所有记录的视频？"
                    confirmStr:nil
                  confirmBlock:^{
                      // 清空已有的视频记录,然后重置进度条样式
                      [self.videoPreview reset];
                      [self.recordTimes removeAllObjects];
                      [self.videoProgress reset];
                      self.currentTime=0.0;
                      
                      UIImage * img=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
                      UIImage * selImg=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
                      UIBarButtonItem * leftBut=[[UISDK Instance]imgBarButton:img
                                                                       selImg:selImg
                                                                         text:nil
                                                                        block:^(UIButton *but) {
                                                                            [tempView leftNavButCall];
                                                                        }
                                                                  leftOrRight:0];
                      leftBut.enabled=NO;
                      self.navigationItem.leftBarButtonItem=leftBut;
                      
                      self.cancelRecordBut.enabled=NO;
        
    }
                     concelStr:nil concelBlock:^{
                         return;
    }
                 singleOrMulti:NO];
}

/// 闪光灯按钮方法
-(void)lightButCall
{
    // 取反闪光灯状态,然后重新配置导航栏样式
    self.haveLight=!self.haveLight;
    [self configNavBut];
    [self.videoPreview switchLight];
    
}

/// 镜头转化按钮方法
-(void)switchCameraButCall
{
    // 取反摄像头位置状态,然后重新配置导航栏样式
    self.haveSwitch=!self.haveSwitch;
    [self configNavBut];
    [self.videoPreview switchCamera];
}

/// 设置导航按钮样式
-(void)configNavBut
{
    UIImage * lightimg;
    UIImage * switchImg;
    UIBarButtonItem * lightBut;
    UIBarButtonItem * switchBut;
    __weak MainViewController * tempView=self;
    if(self.haveLight)
    {
        
        lightimg=[[UISDK Instance]getImg:@"MainView_LightBut_.png"];
    }
    else
    {
        
        lightimg=[[UISDK Instance]getImg:@"MainView_LightBut.png"];
    }
    
    
    if(self.haveSwitch)
    {
        lightimg=[[UISDK Instance]getImg:@"MainView_LightBut.png"];
        switchImg=[[UISDK Instance]getImg:@"MainView_Switch_.png"];
    }
    else
    {
        switchImg=[[UISDK Instance]getImg:@"MainView_Switch.png"];
        
    }
    
    lightBut=[[UISDK Instance]imgBarButton:lightimg
                                    selImg:lightimg
                                      text:nil
                                     block:^(UIButton *but) {
                                         [tempView lightButCall];
                                     }
              
                               leftOrRight:0];
    
    switchBut=[[UISDK Instance]imgBarButton:switchImg
                                     selImg:switchImg
                                       text:nil
                                      block:^(UIButton *but) {
                                          [tempView switchCameraButCall];
                                      }
                                leftOrRight:0];
    
    
    if(self.haveSwitch)
    {
        lightBut.enabled=NO;
        self.haveLight=NO;
        
    }
    else
    {
        lightBut.enabled=YES;
        
    }
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:switchBut,lightBut,nil];
}

#pragma mark - 计时器相关
/// 配置计时器
-(void)configTime
{
    if (!self.recordTime) {
        self.recordTime=[NSTimer scheduledTimerWithTimeInterval:0.01
                                                         target:self
                                                       selector:@selector(addTime)
                                                       userInfo:nil
                                                        repeats:YES];
        
        [self.recordTime setFireDate:[NSDate distantFuture]];
    }
}

/// 计时器方法
-(void)addTime
{
    self.currentTime+=CoundTime;
    float percent=self.currentTime/MaxTime;
    [self.videoProgress changeProgressview:percent];
    
    if(self.currentTime>=RequireTime)
    {
        UIImage * img=[[UISDK Instance]getImg:@"MainView_SaveBut_.png"];
        [self.saveBut setBackgroundImage:img forState:UIControlStateNormal];
        self.saveBut.enabled=YES;
    }
}


#pragma mark - 按钮事件回调
/// 删除按钮回调
-(void)deleteButCall
{
   

}

/// 录制按钮按下回调
-(void)recordButPressedCall
{
    //开始记录状态取反 调用记录或停止方法
    self.haveStartRecord=!self.haveStartRecord;
    self.recordBut.enabled=NO;
    [self startOrPauselRecord];
}

/// 录制按钮按下弹起
-(void)recordButCancelCall
{
        //开始记录状态取反 调用记录或停止方法
        self.haveStartRecord=!self.haveStartRecord;
        [self startOrPauselRecord];
        [self.videoProgress addSuspendAccessory];
        self.recordBut.enabled=YES;
    

}

/// 储存按钮回调
-(void)saveButCall
{
    __weak MainViewController * tempView=self;
    self.saveBut.enabled=NO;
    [self.videoPreview saveToDisk:^{
        // 将源视频文件保存到混合文件夹中
        NSString * sourceFile=[[UtilitySDK Instance]creatDirectiory:VideoRecordPath];
        sourceFile=[sourceFile stringByAppendingPathComponent:VideoRecordFile];
        NSString * savePath=[[UtilitySDK Instance]creatDirectiory:MixVideoPath];
        savePath=[savePath stringByAppendingPathComponent:MixVideoFile];
        [[UtilitySDK Instance]saveFile:sourceFile toSavePath:savePath];
        
        VideoProcessViewController * processView=[[VideoProcessViewController alloc]init];
        [tempView.navigationController pushViewController:processView animated:YES];
    }];

}

#pragma mark - 功能方法
/// 开始录制或暂停录制
-(void)startOrPauselRecord
{
    __weak MainViewController * tempView=self;
    UIImage * img=nil;
    // 开始记录
    if(self.haveStartRecord)
    {
        self.havePrepareDeleteLastRecord=NO;
        [self.videoProgress resumeChangeProgressview];
        

        img=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
        [self.cancelRecordBut setBackgroundImage:img forState:UIControlStateNormal];
        self.cancelRecordBut.enabled=YES;
        
        UIImage * img;
        UIImage * selImg;
        
        img=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
        selImg=[[UISDK Instance]getImg:@"General_ConcelBut.png"];
        UIBarButtonItem * leftBut=[[UISDK Instance]imgBarButton:img
                                                         selImg:selImg
                                                           text:nil
                                                          block:^(UIButton *but) {
                                                              [tempView leftNavButCall];
                                                          }
                                                    leftOrRight:0];
        leftBut.enabled=YES;
        self.navigationItem.leftBarButtonItem=leftBut;

        
        
        img=[[UISDK Instance]getImg:@"MainView_RecordBut_.png"];
        [self.recordBut setBackgroundImage:img forState:UIControlStateNormal];
        [self.recordTime setFireDate:[NSDate distantPast]];
        
        NSNumber * recordTime=[NSNumber numberWithFloat:self.currentTime];
        [self.recordTimes addObject:recordTime];
        [self.videoPreview startRecord];
    }
    // 停止记录
    else
    {
        [self.videoPreview stopRecord];
        img=[[UISDK Instance]getImg:@"MainView_RecordBut.png"];
        [self.recordBut setBackgroundImage:img forState:UIControlStateNormal];
        [self.recordTime setFireDate:[NSDate distantFuture]];
    }
}

@end
