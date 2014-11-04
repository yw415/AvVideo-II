//
//  BusinessURL.m
//  GeneralFrame
//
//  Created by user on 14-4-16.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "BusinessURL.h"

@implementation BusinessURL

//初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}
//单例模式
+(BusinessURL *)Instance
{
    static BusinessURL * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

//获取接口地址
-(NSString *) getURLWithRequest:(BusinessRequestType) requestType
{
    switch (requestType) {
            
        case URL_Host:
        {
            return [self URL_Host];
        }
            break;
        case URL_User_Notice:
        {
            return [self URL_User_Notice];
        }
            break;
        case URL_Base_Area:
        {
            return [self URL_Base_Area];
        }
            break;
        case URL_User_Register_Email:
        {
            return [self URL_User_Register_Email];
        }
            break;
        case URL_User_Forget:
        {
            return [self URL_User_Forget];
        }
            break;
        case URL_User_Login:
        {
            return [self URL_User_Login];
        }
            break;
        case URL_Access_Ability:
        {
            return [self URL_Access_Ability];
        }
            break;
        case URL_Platform_Marquee:
        {
            return [self URL_Platform_Marquee];
        }
            break;
        case URL_Offline_Ziplist:
        {
            return [self URL_Offline_Ziplist];
        }
            break;
        case URL_Download:
        {
            return [self URL_Download];
        }
            break;
        case URL_Platform_Checkupdate:
        {
            return [self URL_Platform_Checkupdate];
        }
            break;
        case URL_Platform_Feedback:
        {
            return [self URL_Platform_Feedback];
        }
            break;
        case URL_Message_Messagelist:
        {
            return [self URL_Message_Messagelist];
        }
            break;
        case URL_Access_Exam:
        {
            return [self URL_Access_Exam];
        }
            break;
        case URL_Access_PointMaster:
        {
            return [self URL_Access_Pointmaster];
        }
            break;
        case URL_Access_Practice:
        {
            return [self URL_Access_Practice];
        }
            break;
        case URL_Train_Point:
        {
            return [self URL_Train_Point];
        }
            break;
        case URL_Train_DailySetting:
        {
            return [self URL_Train_DailySetting];
        }
            break;
        case URL_Train_SettingInfo:
        {
            return [self URL_Train_SettingInfo];
        }
            break;
        case URL_Train_DailyTrain:
        {
            return [self URL_Train_DailyTrain];
        }
            break;
        case URL_Question_Content:
        {
            return [self URL_Question_Content];
        }
            break;
        case URL_Train_DailyTrainAnswer:
        {
            return [self URL_Train_DailyTrainAnswer];
        }
            break;
        case URL_Question_Collection:
        {
            return [self URL_Question_Collection];
        }
            break;
        case URL_Platform_FeedBack:
        {
            return [self URL_Platform_FeedBack];
        }
        
        case URL_Question_Analyze:
        {
            return [self URL_Question_Analyze];
        }
            break ;
        case URL_Question_Allinfo:
        {
            return [self URL_Question_Allinfo];
        }
            break;
        case URL_Forecast_Intro:
        {
            return [self URL_Forecast_Intro];
        }
            break;
        case URL_Question_Forecast:
        {
            return [self URL_Question_Forecast];
        }
            break;
        case URL_Answer_Forecast:
        {
            return [self URL_Answer_Forecast];
        }
            break;
        case URL_Question_Point:
        {
            return [self URL_Question_Point];
        }
            break;
        case URL_Answer_Point:
        {
            return [self URL_Answer_Point];
        }
            break;
        case URL_Record_History:
        {
            return [self URL_Record_History];
        }
            break;
        case URL_Record_Search:
        {
            return [self URL_Record_Search];
        }
            break;
        case URL_Record_Info:
        {
            return [self URL_Record_Info];
        }
            break;
        case URL_Record_Athletics_Info:
        {
            return [self URL_Record_Athletics_Info];
        }
            break;
        case URL_Record_Error_PointList:
        {
            return [self URL_Record_Error_PointList];
        }
            break;
        case URL_Question_Incorrect:
        {
            return [self URL_Question_Incorrect];
        }
            break;
        case URL_Answer_Incorrect_Point:
        {
            return [self URL_Answer_Incorrect_Point];
        }
            break;
        case URL_Record_Collection_PointList:
        {
            return [self URL_Record_Collection_PointList];
        }
            break;
        case URL_Answer_Incorrect:
        {
            return [self URL_Answer_Incorrect];
        }
            break;
        case URL_Record_Question_Collection:
        {
            return [self URL_Record_Question_Collection];
        }
            break;
        case URL_Answer_Collection:
        {
            return [self URL_Answer_Collection];
        }
            break;
        case URL_Answer_Collection_Point:
        {
            return [self URL_Answer_Collection_Point];
        }
            break;
        case URL_Athletics_Info:
        {
            return [self URL_Athletics_Info];
        }
            break;
        case URL_Athletics_Roomlist:
        {
            return [self URL_Athletics_Roomlist];
        }
            break;
        case URL_Athletics_Historylist:
        {
            return [self URL_Athletics_Historylist];
        }
            break;
        case URL_Athletics_Ranking:
        {
            return [self URL_Athletics_Ranking];
        }
            break;
        case URL_Athletics_MyRanking:
        {
            return [self URL_Athletics_MyRanking];
        }
            break;
        case URL_Athletics_Resulte:
        {
            return [self URL_Athletics_Resulte];
        }
            break;
        case URL_Athletics_Join:
        {
            return [self URL_Athletics_Join];
        }
            break;
        case URL_Athletics_Quit:
        {
            return [self URL_Athletics_Quit];
        }
            break;
        case URL_Athletics_RefreshRoom:
        {
            return [self URL_Athletics_RefreshRoom];
        }
            break;
        case URL_Athletics_Submit:
        {
            return [self URL_Athletics_Submit];
        }
            break;
        case URL_Athletics_Handin:
        {
            return [self URL_Athletics_Handin];
        }
            break;
        default:
            break;
    }
}

//获取接口名称
-(NSString *) getNameWithRequest:(BusinessRequestType) requestType
{
    switch (requestType) {
            
        case URL_Host:
        {
            return @"URL_Host";
        }
            break;
        case URL_User_Login:
        {
            return @"URL_Login";
        }
            break;
        case URL_User_Notice:
        {
            return @"URL_User_Notice";
        }
            break;
            
        case URL_Base_Area:
        {
            return @"URL_Base_Area";
        }
            break;
        case URL_User_Register_Email:
        {
            return @"URL_User_Register_Email";
        }
            break;
        case URL_User_Forget:
        {
             return @"URL_User_Forget";
        }
            break;
        case URL_Access_Ability:
        {
            return @"URL_Access_Ability";
        }
            break;
        case URL_Platform_Marquee:
        {
            return @"URL_Platform_Marquee";
        }
            break;
        case URL_Offline_Ziplist:
        {
            return @"URL_Offline_Ziplist";
        }
            break;
        case URL_Platform_Checkupdate:
        {
            return @"URL_Platform_Checkupdate";
        }
            break;
        case URL_Platform_Feedback:
        {
            return @"URL_Platform_Feedback";
        }
            break;
        case URL_Message_Messagelist:
        {
            return @"URL_Message_Messagelist";
        }
            break;
        case URL_Access_Practice:
        {
            return @"URL_Access_Practice";
        }
            break;
        case URL_Access_Exam:
        {
            return @"URL_Access_Exam";
        }
            break;
        case URL_Access_PointMaster:
        {
            return @"URL_Access_Pointmaster";
        }
            break;
        case URL_Train_Point:
        {
            return @"URL_Train_Point";
        }
            break;
        case URL_Train_DailySetting:
        {
            return @"URL_Train_DailySetting";
        }
            break;
        case URL_Train_SettingInfo:
        {
            return @"URL_Train_SettingInfo";
        }
            break;
        case URL_Train_DailyTrain:
        {
            return @"URL_Train_DailyTrain";
        }
            break;
        case URL_Question_Content:
        {
            return @"URL_Question_Content";
        }
            break;
        case URL_Train_DailyTrainAnswer:
        {
            return @"URL_Train_DailyTrainAnswer";
        }
            break;
        case URL_Question_Collection:
        {
            return @"URL_Question_Collection";
        }
            break;
        case URL_Platform_FeedBack:
        {
            return @"URL_Platform_FeedBack";
        }
            break;
        case URL_Question_Analyze:
        {
             return @"URL_Question_Analyze";
        }
            break;
        case URL_Question_Allinfo:
        {
            return @"URL_Question_Allinfo";
        }
            break;
        case URL_Forecast_Intro:
        {
            return @"URL_Forecast_Intro";
        }
            break;
        case URL_Question_Forecast:
        {
            return @"URL_Question_Forecast";
        }
            break;
        case URL_Answer_Forecast:
        {
            return @"URL_Answer_Forecast";
        }
            break;
        case URL_Question_Point:
        {
            return @"URL_Question_Point";
        }
            break;
        case URL_Answer_Point:
        {
            return @"URL_Answer_Point";
        }
            break;
        case URL_Record_Search:
        {
            return @"URL_Record_Search";
        }
            break;
        case URL_Record_Info:
        {
            return @"URL_Record_Info";
        }
            break;
        case URL_Record_Athletics_Info:
        {
            return @"URL_Record_Athletics_Info";
        }
            break;
        case URL_Record_Error_PointList:
        {
            return @"URL_Record_Error_PointList";
        }
            break;
        case URL_Record_Collection_PointList:
        {
            return @"URL_Record_Collection_PointList";
        }
            break;
        case URL_Question_Incorrect:
        {
            return @"URL_Question_Incorrect";
        }
            break;
        case URL_Answer_Incorrect:
        {
            return @"URL_Answer_Incorrect";
        }
            break;
        case URL_Answer_Incorrect_Point:
        {
            return @"URL_Answer_Incorrect_Point";
        }
            break;
        case URL_Record_Question_Collection:
        {
            return @"URL_Record_Question_Collection";
        }
            break;
        case URL_Answer_Collection:
        {
            return @"URL_Answer_Collection";
        }
            break;
        case URL_Answer_Collection_Point:
        {
            return @"URL_Answer_Collection_Point";
        }
            break;
        case URL_Athletics_Info:
        {
            return @"URL_Athletics_Info";
        }
            break;
        case URL_Athletics_Roomlist:
        {
            return @"URL_Athletics_Roomlist";
        }
            break;
        case URL_Athletics_Historylist:
        {
            return @"URL_Athletics_Historylist";
        }
            break;
        case URL_Athletics_Ranking:
        {
            return @"URL_Athletics_Ranking";
        }
            break;
        case URL_Athletics_MyRanking:
        {
            return @"URL_Athletics_MyRanking";
        }
            break;
        case URL_Athletics_Resulte:
        {
            return @"URL_Athletics_Resulte";
        }
            break;
        case URL_Athletics_Join:
        {
            return @"URL_Athletics_Join";
        }
            break;
        case URL_Athletics_Quit:
        {
            return @"URL_Athletics_Quit";
        }
            break;
        case URL_Athletics_RefreshRoom:
        {
            return @"URL_Athletics_RefreshRoom";
        }
            break;
        case URL_Athletics_Submit:
        {
            return @"URL_Athletics_Submit";
        }
            break;
        case URL_Athletics_Handin:
        {
            return @"URL_Athletics_Handin";
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - 接口url
//获取服务器地址
-(NSString *)URL_Host
{
    //  return @"http://10.96.106.19:8087/nsapi/";
    //  return @"http://10.96.106.6:8080/nsapi/";
        return @"http://ns.huatu.com/nsapi/";
    //  return @"http://124.207.23.110:8080/nsapi/";
    //	return @"http://124.207.23.110:8080/nsapi/";
    //	return @"http://10.96.106.251:8080/nsapi/";
    //	return @"http://10.96.106.170:8080/nsapi/";
    //  return @"http://124.207.23.110:8080/nsapi/";
    //    return @"http://211.151.49.9:6789/nsapi/";
    //  return @"http://10.96.106.149:8090/nsapi/";
    //	return @"http://10.96.106.149:8090/nsapi/";
    //  return @"http://122.70.132.89:8080/nsapi/";
}

//获取活动信息接口地址
-(NSString *)URL_User_Notice
{
    NSString * url = [NSString stringWithFormat:@"user/notice"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//获取地区信息接口地址
-(NSString *)URL_Base_Area
{
    NSString * url = [NSString stringWithFormat:@"base/area"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//邮箱注册接口地址
-(NSString *)URL_User_Register_Email
{
    NSString * url = [NSString stringWithFormat:@"user/register/email"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//忘记密码接口（邮箱）
-(NSString *)URL_User_Forget
{
    NSString * url = [NSString stringWithFormat:@"user/recall"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//登录接口地址
-(NSString *)URL_User_Login
{
    NSString * url = [NSString stringWithFormat:@"user/login/new"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//登录接口综合分值接口地址
-(NSString *)URL_Access_Ability
{
   	NSString * url = [NSString stringWithFormat:@"access/ability"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//登录接口走马灯信息接口地址
-(NSString *)URL_Platform_Marquee
{
    NSString * url = [NSString stringWithFormat:@"platform/marquee"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//试题离线接口地址
-(NSString *)URL_Offline_Ziplist
{
    NSString * url = [NSString stringWithFormat:@"offline/ziplist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//试题离线下载地址
-(NSString *)URL_Download
{
      return @"http://ns.huatu.com";
  //  return @"http://211.151.49.9:6789";
}

//app版本检测
-(NSString *)URL_Platform_Checkupdate
{
   	NSString * url = [NSString stringWithFormat:@"platform/checkupdate"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//用户反馈
-(NSString *)URL_Platform_Feedback
{
    NSString * url = [NSString stringWithFormat:@"platform/feedback"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//信息列表
-(NSString *)URL_Message_Messagelist
{
    NSString * url = [NSString stringWithFormat:@"message/messagelist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//备考信息
-(NSString *)URL_Access_Exam
{
    NSString * url = [NSString stringWithFormat:@"access/exam"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//练习情况
-(NSString *)URL_Access_Practice
{
    NSString * url = [NSString stringWithFormat:@"access/practice"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//知识点
-(NSString *)URL_Access_Pointmaster
{
    NSString * url = [NSString stringWithFormat:@"access/pointmaster"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//每日训练知识点状态
-(NSString *)URL_Train_Point
{
    NSString * url = [NSString stringWithFormat:@"train/point"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//每日训练用户设置
-(NSString *)URL_Train_DailySetting
{
    NSString * url = [NSString stringWithFormat:@"train/dailysetting"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//每日训练用户设置数据
-(NSString *)URL_Train_SettingInfo
{
    NSString * url = [NSString stringWithFormat:@"train/settinginfo"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//每日训练抽题
-(NSString *)URL_Train_DailyTrain
{
    NSString * url = [NSString stringWithFormat:@"question/dailytrain"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//每日训练交卷
-(NSString *)URL_Train_DailyTrainAnswer
{
    NSString * url = [NSString stringWithFormat:@"answer/dailytrain"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//我猜你练数据信息
-(NSString *)URL_Forecast_Intro
{
    NSString * url = [NSString stringWithFormat:@"forecast/intro"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//我猜你练抽题
-(NSString *)URL_Question_Forecast
{
    NSString * url = [NSString stringWithFormat:@"question/forecast"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//我猜你练交卷
-(NSString *)URL_Answer_Forecast
{
    NSString * url = [NSString stringWithFormat:@"answer/forecast"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//考点直击抽题
-(NSString *)URL_Question_Point
{
    NSString * url = [NSString stringWithFormat:@"question/point"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//考点直击交卷
-(NSString *)URL_Answer_Point
{
    NSString * url = [NSString stringWithFormat:@"answer/point"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
//题干内容
-(NSString *)URL_Question_Content
{
    NSString * url = [NSString stringWithFormat:@"question/content"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//收藏题目
-(NSString *)URL_Question_Collection
{
    NSString * url = [NSString stringWithFormat:@"record/collection/submit"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//试题纠错
-(NSString *)URL_Platform_FeedBack
{
    NSString * url = [NSString stringWithFormat:@"platform/feedback"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//单个试题答案解析
-(NSString *)URL_Question_Analyze
{
    NSString * url = [NSString stringWithFormat:@"question/analyze"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//单个试题答案解析（题干＋解析）
-(NSString *)URL_Question_Allinfo
{
    NSString * url = [NSString stringWithFormat:@"question/allinfo"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//答题记录列表
-(NSString *)URL_Record_History
{
    NSString * url = [NSString stringWithFormat:@"record/history"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//答题记录查询
-(NSString *)URL_Record_Search
{
    NSString * url = [NSString stringWithFormat:@"record/history/search"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//答题记录详细信息
-(NSString *)URL_Record_Info
{
    NSString * url = [NSString stringWithFormat:@"record/history/info"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//答题记录竞技练习详细信息
-(NSString *)URL_Record_Athletics_Info
{
    NSString * url = [NSString stringWithFormat:@"record/history/info"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//错题首页展示数据
-(NSString *)URL_Record_Error_PointList
{
    NSString * url = [NSString stringWithFormat:@"record/error/pointlist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//错题抽题接口
-(NSString *)URL_Question_Incorrect
{
    NSString * url = [NSString stringWithFormat:@"question/incorrect"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//错题交卷接口
-(NSString *)URL_Answer_Incorrect
{
    NSString * url = [NSString stringWithFormat:@"answer/incorrect"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//错题答案解析
-(NSString *)URL_Answer_Incorrect_Point
{
    NSString * url = [NSString stringWithFormat:@"answer/incorrect/point"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//收藏首页展示数据
-(NSString *)URL_Record_Collection_PointList
{
    NSString * url = [NSString stringWithFormat:@"record/collection/pointlist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//收藏夹抽题接口
-(NSString *)URL_Record_Question_Collection
{
    NSString * url = [NSString stringWithFormat:@"question/collection"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//收藏夹交卷接口
-(NSString *)URL_Answer_Collection
{
    NSString * url = [NSString stringWithFormat:@"answer/collection"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//收藏夹答案解析
-(NSString *)URL_Answer_Collection_Point
{
    NSString * url = [NSString stringWithFormat:@"answer/collection/point"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞技场基本情况
-(NSString *)URL_Athletics_Info
{
    NSString * url = [NSString stringWithFormat:@"athletics/info"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞技场房间列表
-(NSString *)URL_Athletics_Roomlist
{
    NSString * url = [NSString stringWithFormat:@"athletics/roomlist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考记录列表
-(NSString *)URL_Athletics_Historylist
{
    NSString * url = [NSString stringWithFormat:@"athletics/historylist"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考总排行榜
-(NSString *)URL_Athletics_Ranking
{
    NSString * url = [NSString stringWithFormat:@"athletics/ranking"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考我的排行
-(NSString *)URL_Athletics_MyRanking
{
    NSString * url = [NSString stringWithFormat:@"athletics/myranking"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考成绩查询
-(NSString *)URL_Athletics_Resulte
{
    NSString * url = [NSString stringWithFormat:@"athletics/result"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考加入房间
-(NSString *)URL_Athletics_Join
{
    NSString * url = [NSString stringWithFormat:@"athletics/join"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考退出房间
-(NSString *)URL_Athletics_Quit
{
    NSString * url = [NSString stringWithFormat:@"athletics/quit"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考刷新房间
-(NSString *)URL_Athletics_RefreshRoom
{
    NSString * url = [NSString stringWithFormat:@"athletics/refreshroom"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考单题提交
-(NSString *)URL_Athletics_Submit
{
    NSString * url = [NSString stringWithFormat:@"athletics/submit"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}

//竞考主动交卷或退出
-(NSString *)URL_Athletics_Handin
{
    NSString * url = [NSString stringWithFormat:@"athletics/handin"];
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",[self URL_Host],url];
    return sUrl;
}
@end
