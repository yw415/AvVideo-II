//
//  BusinessEnmu.h
//  GeneralFrame
//
//  Created by user on 14-4-16.
//  Copyright (c) 2014年 ios. All rights reserved.
//
//业务相关的接口枚举
typedef enum {
    //服务器地址
#pragma mark - 登录模块
    URL_Host,
    //用户活动信息
    URL_User_Notice,
    //地区信息
    URL_Base_Area,
    //邮箱注册
    URL_User_Register_Email,
    //找回密码
    URL_User_Forget,
    //登录
    URL_User_Login,
#pragma mark - 主页面
    //主页走马灯
    URL_Platform_Marquee,
    //消息列表
    URL_Message_Messagelist,
#pragma mark - 设置模块
    //试题离线
    URL_Offline_Ziplist,
    //试题离线下载
    URL_Download,
    //检查版本更新
    URL_Platform_Checkupdate,
    //用户反馈
    URL_Platform_Feedback,
#pragma mark - 综合分值模块
    //知识点
    URL_Access_PointMaster,
    //综合分值
    URL_Access_Ability,
    //练习情况
    URL_Access_Practice,
    //备考信息
    URL_Access_Exam,
#pragma mark - 每日训练模块
    //每日训练知识点状态
    URL_Train_Point,
    //每日训练用户设置
    URL_Train_DailySetting,
    //每日训练用户设置数据
    URL_Train_SettingInfo,
    //每日训练抽题接口
    URL_Train_DailyTrain,
    //每日训练交卷接口
    URL_Train_DailyTrainAnswer,
#pragma mark - 我猜你练模块
    //我猜你练数据信息
    URL_Forecast_Intro,
    //我猜你练抽题
    URL_Question_Forecast,
    //我猜你练交卷
    URL_Answer_Forecast,
#pragma mark - 考点直击模块
    //考点直击抽题
    URL_Question_Point,
    //考点直击交卷
    URL_Answer_Point,
#pragma mark - 试题相关模块
    //单个试题内容
    URL_Question_Content,
    //收藏试题
    URL_Question_Collection,
    //试题纠错
    URL_Platform_FeedBack,
    //单个试题解析
    URL_Question_Analyze,
    //单个试题全信息
    URL_Question_Allinfo,
#pragma mark - 答题历史相关模块
    //答题记录列表
    URL_Record_History,
    //答题记录查询
    URL_Record_Search,
    //答题记录详细信息
    URL_Record_Info,
    //答题记录竞技练习详细信息
    URL_Record_Athletics_Info,
#pragma mark - 错题库相关模块
    //错题首页展示数据
    URL_Record_Error_PointList,
    //错题抽题接口
    URL_Question_Incorrect,
    //错题交卷接口
    URL_Answer_Incorrect,
    //错题答案解析
    URL_Answer_Incorrect_Point,
#pragma mark - 收藏夹相关模块
    //收藏夹首页展示数据
    URL_Record_Collection_PointList,
    //收藏夹抽题接口
    URL_Record_Question_Collection,
    //收藏夹交卷接口
    URL_Answer_Collection,
    //收藏答案解析
    URL_Answer_Collection_Point,
#pragma mark - 竞技场相关模块
    //竞技场基本情况
    URL_Athletics_Info,
    //竞技场房间列表
    URL_Athletics_Roomlist,
    //竞考记录列表
    URL_Athletics_Historylist,
    //竞考总排行榜
    URL_Athletics_Ranking,
    //竞考我的排行
    URL_Athletics_MyRanking,
    //竞考成绩查询
    URL_Athletics_Resulte,
    //竞考加入房间
    URL_Athletics_Join,
    //竞考退出房间
    URL_Athletics_Quit,
    //竞考刷新房间
    URL_Athletics_RefreshRoom,
    //竞考单题提交
    URL_Athletics_Submit,
    //竞考主动交卷或退出
    URL_Athletics_Handin,

} BusinessRequestType;
