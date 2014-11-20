//
//  VideoProcessOperationView.m
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "VideoProcessOperationView.h"
#import "VideoProcessOperationItem.h"
#import "UtilitySDK.h"
#import "UISDK.h"
#import "VideoProcess.h"
@interface VideoProcessOperationView()
@property(nonatomic,strong)CustomHorizontalTable * horizontalTable;
@property(nonatomic,strong)NSMutableArray * data;
@property(nonatomic,assign)int tag;
@end
@implementation VideoProcessOperationView
#pragma mark - 界面生命周期
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.data=[NSMutableArray array];
        [self addSubviews];
    }
    return self;
}

#pragma mark - 自定义方法
/// 添加子视图
-(void)addSubviews
{
    CGRect rect=CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height);
    self.horizontalTable=[[CustomHorizontalTable alloc]initWithFrame:rect];
    self.horizontalTable.delegate=self;
    [self addSubview:self.horizontalTable];
}

/// 配置数据
-(void)configureData:(int)tag
{
    self.tag=tag;
    switch (tag) {
        case 0:
        {
            [self configureSound];
            [self.horizontalTable reloadData];
        }
            break;
        case 1:
        {
            [self configureFilter];
            [self.horizontalTable reloadData];
        }
            break;
        case 2:
        {
            [self configurePrint];
            [self.horizontalTable reloadData];
        }
            break;
        default:
            break;
    }
}

/// 配置声音数据
-(void)configureSound
{
    [self.data removeAllObjects];
    NSDictionary * plistDic=[self getSoundList];
    NSArray * soundList=[plistDic objectForKey:@"Sound"];
    for(int i=0;i<soundList.count;i++)
    {
        NSString * title=[soundList objectAtIndex:i];
        UIImage * img=[UIImage imageNamed:@"VideoProcessView_Sound.png"];
        
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
        [dic setObject:title forKey:@"Title"];
        [dic setObject:img forKey:@"Img"];
        [self.data addObject:dic];
    }
}

/// 配置滤镜数据
-(void)configureFilter
{
    [self.data removeAllObjects];
    NSDictionary * plistDic=[self getFilterList];
    NSDictionary * filterList=[plistDic objectForKey:@"Filters"];
    for(NSString * key in filterList.allKeys)
    {
       
        NSString * title=key;
        NSString * filterName=[filterList objectForKey:key];
        UIImage * img=[UIImage imageNamed:@"VideoProcessView_Sound.png"];
        
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
        [dic setObject:title forKey:@"Title"];
        [dic setObject:img forKey:@"Img"];
        [dic setObject:filterName forKey:@"FilterName"];
        [self.data addObject:dic];
    }
}

/// 配置水印
-(void)configurePrint
{
    [self.data removeAllObjects];
    for(int i=0;i<5;i++)
    {
        NSString * title=nil;
        switch (i) {
            case 0:
            {
                title=@"水印上";
            }
                break;
            case 1:
            {
                 title=@"水印右";
            }
                break;
            case 2:
            {
                 title=@"水印下";
            }
                break;
            case 3:
            {
                 title=@"水印左";
            }
                break;
            case 4:
            {
                 title=@"水印中";
            }
                break;
            default:
                break;
        }
        
        UIImage * img=[UIImage imageNamed:@"VideoProcessView_Sound.png"];
        
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
        [dic setObject:title forKey:@"Title"];
        [dic setObject:img forKey:@"Img"];
        [self.data addObject:dic];
    }
}

/// 获取SoundList的plist文件
-(NSDictionary *)getSoundList
{
    NSString * plistPath=[[NSBundle mainBundle]pathForResource:@"Sound" ofType:@"plist"];
    NSDictionary * plistDic=[NSDictionary dictionaryWithContentsOfFile:plistPath];
    return plistDic;
}

/// 获取FilterList的plist文件
-(NSDictionary *)getFilterList
{
    NSString * plistPath=[[NSBundle mainBundle]pathForResource:@"Filter" ofType:@"plist"];
    NSDictionary * plistDic=[NSDictionary dictionaryWithContentsOfFile:plistPath];
    return plistDic;
}

#pragma mark - CustomHorizontalTableDelegate
-(int)itemCount
{
   return (int)self.data.count;
}
-(float)itemMargin
{
    return 15.0;
}
-(UIView *)itemView:(int)index
{
    NSDictionary * dic=[self.data objectAtIndex:index];
    
    NSString * title=[dic objectForKey:@"Title"];
    UIImage * img=[dic objectForKey:@"Img"];
    
    CGRect rect=CGRectMake(0, 0, 50, 80);
    VideoProcessOperationItem * item=[[VideoProcessOperationItem alloc]initWithFrame:rect];
    item.title.text=title;
    item.image.image=img;
    return item;
}

-(void)selectedItem:(UIView *)selectedView index:(int)selectedIndex
{
    
    [[UISDK Instance]showWait:@"请稍候" view:self.superview.window];
    switch (self.tag) {
        case 0:
        {
            // 从plist文件中提取声音和视频文件名
            NSLog(@"当前选择为音乐");
            NSDictionary * pList=[self getSoundList];
            NSString * soundFile= [[pList objectForKey:@"Sound"]objectAtIndex:selectedIndex];
            
            // 设置文件路径
            NSString * soundPath=[[NSBundle mainBundle]pathForResource:soundFile ofType:@"mp3"];
            NSString * sourceVideoPath=[[UtilitySDK Instance]creatDirectiory:MixVideoPath];
            NSArray * files=[[UtilitySDK Instance]getFilesInDirectory:sourceVideoPath];
            NSString * file=[files objectAtIndex:0];
            sourceVideoPath=[sourceVideoPath stringByAppendingPathComponent:file];
            
            //混合
            [[VideoProcess Instance] mixSound:soundPath
                         videoPath:sourceVideoPath
                       finishBlock:^{
                           if(self.selectedBlock)
                           {
    
                               self.selectedBlock(sourceVideoPath);
                           }
                           
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               [[UISDK Instance]hideWait:self.window];
                           });

            }];
            
        }
            break;
        case 1:
        {
            NSLog(@"当前选择为滤镜");
            // 滤镜名
            NSDictionary * dic=[self.data objectAtIndex:selectedIndex];
            NSString * filterName = [dic objectForKey:@"FilterName"];
            NSLog(@"滤镜名:%@",filterName);
            // 设置文件路径
            NSString * sourceVideoPath=[[UtilitySDK Instance]creatDirectiory:MixVideoPath];
            NSArray * files=[[UtilitySDK Instance]getFilesInDirectory:sourceVideoPath];
            NSString * file=[files objectAtIndex:0];
            sourceVideoPath=[sourceVideoPath stringByAppendingPathComponent:file];
            
            dispatch_queue_t filterQueue=dispatch_queue_create("filterQueue", NULL);
            dispatch_async(filterQueue, ^{
                [[VideoProcess Instance]extractImageFromVideo:sourceVideoPath
                                                  filterName:filterName
                                                  finishFilterCallBack:^{
                                                      if(self.selectedBlock)
                                                       {
                                                           self.selectedBlock(sourceVideoPath);
                                                       }
                                                       
                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                          [[UISDK Instance]hideWait:self.window];
                                                      });
                                                  }
                 ];
            });
       
        }
            break;
        case 2:
        {
            NSLog(@"当前选择为水印");
            UIImage * img=[[UISDK Instance]getImg:@"star.png"];
            CGRect rect=CGRectZero;
            switch (selectedIndex) {
                case 0:
                {
                    rect=CGRectMake(100, 300, 100, 100);
                }
                    break;
                case 1:
                {
                    rect=CGRectMake(300, 300, 100, 100);
                }
                    break;
                case 2:
                {
                    rect=CGRectMake(100, 100, 100, 100);
                }
                    break;
                case 3:
                {
                    rect=CGRectMake(100, 400, 100, 100);
                }
                    break;
                case 4:
                {
                    rect=CGRectMake(150, 150, 100, 100);
                }
                    break;
                default:
                    break;
            }
            // 设置文件路径
            NSString * sourceVideoPath=[[UtilitySDK Instance]creatDirectiory:MixVideoPath];
            NSArray * files=[[UtilitySDK Instance]getFilesInDirectory:sourceVideoPath];
            NSString * file=[files objectAtIndex:0];
            sourceVideoPath=[sourceVideoPath stringByAppendingPathComponent:file];
            
            [[VideoProcess Instance]addWaterPrintToVideo:sourceVideoPath
                                               printImg:img
                                              printRect:rect
                              finishWataerPrintCallBack:^(NSString * path) {
                                  
                                  if(self.selectedBlock)
                                  {
                                      
                                      self.selectedBlock(path);
                                  }
                                  
                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                      [[UISDK Instance]hideWait:self.window];
                                  });
                              }
             ];
        }
            break;
        default:
            break;
    }
    
    
}
@end
