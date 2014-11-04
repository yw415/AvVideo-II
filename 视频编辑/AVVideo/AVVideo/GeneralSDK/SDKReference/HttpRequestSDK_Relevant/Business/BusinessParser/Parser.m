//
//  Parser.m
//  GeneralFrame
//
//  Created by user on 14-4-15.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "Parser.h"
#import "AreaModel.h"
#import "RegisterOrLoginInfoModel.h"
#import "AccessAbilityModel.h"
#import "PlatformMarqueeModel.h"
#import "OfflineZiplistModel.h"
#import "CheckUpdateModel.h"
#import "PointMasterModel.h"
#import "PracticeConditionModel.h"
#import "ExamInfoModel.h"
#import "TrainPointInfoModel.h"
#import "TrainSettingInfoModel.h"
#import "TrainQuestionInfo.h"
#import "UtilitySDK.h"
#import "QuestionContent.h"
#import "TrainAnswerBasic.h"
#import "TrainAnswerPoint.h"
#import "TrainAnswerPointSummary.h"
#import "TrainAnswerSheet.h"
#import "QuestionAnalyze.h"
#import "ForeCastInfoModel.h"
#import "ExercisRecordModel.h"
#import "AnalyzeAllInfo.h"
#import "ErrorListModel.h"
#import "FavoriteListModel.h"
#import "ErrorAnalyzeModel.h"
#import "FavoriteAnalyzeModel.h"
#import "CompetConditionModel.h"
#import "CompetRoomlistModel.h"
#import "CompetHistorylistModel.h"
#import "CompetRankingModel.h"
#import "CompetRewardModel.h"
#import "CompetResultRankModel.h"
#import "CompetRoomModel.h"
#import "CompetRoomUser.h"
#import "MessageListModel.h"
@implementation Parser
#pragma mark - 登录模块相关接口解析
//初始化
-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
    }
    return self;

}
//单例模式
+(Parser *)Instance
{
    static Parser * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}
//通过请求类型进行解析
-(id)parserWithRequestType:(BusinessRequestType)requestType json:(NSData *)json
{
    if(!json)
    {
        return nil;
    }
    
    NSDictionary * jsonDic=[NSJSONSerialization JSONObjectWithData:json
                                                            options:NSJSONReadingMutableContainers
                                                              error:NULL];
    
    //检查服务器返回的信息码
    NSString * conditionCode=[jsonDic objectForKey:@"code"];
    if(conditionCode.intValue>=0)
    {
        id datas=[jsonDic objectForKey:@"data"];
        
        if(datas)
        {
            switch (requestType)
            {
                case URL_User_Notice:
                {
                    return [self getNoticeInfo:datas];
                }
                    break;
                case URL_Base_Area:
                {
                    return [self getAreaInfo:datas];
                }
                    break;
                case URL_User_Register_Email:
                {
                    return [self getRegisterOrLoginInfo:datas];
                }
                    break;
                case URL_User_Forget:
                {
                    return [self getForgetPasswordInfo:datas];
                }
                    break;
                case URL_User_Login:
                {
                    return [self getRegisterOrLoginInfo:datas];
                }
                    break;
                case URL_Access_Ability:
                {
                    return [self getAccessAbilityInfo:datas];
                }
                    break;
                case URL_Access_PointMaster:
                {
                    return [self getAccessPointMaster:datas];
                }
                    break;
                case URL_Access_Practice:
                {
                    return [self getAccessPractice:datas];
                }
                    break;
                case URL_Access_Exam:
                {
                    return [self getAccessExam:datas];
                }
                    break;
                case URL_Platform_Marquee:
                {
                    return [self getPlatformMarqueeInfo:datas];
                }
                    break;
                case URL_Message_Messagelist:
                {
                    return [self getMessageList:datas];
                }
                    break;
                case URL_Offline_Ziplist:
                {
                    return [self getOfflineZiplist:datas];
                }
                    break;
                case URL_Platform_Checkupdate:
                {
                    return [self getCheckupdate:datas];
                }
                    break;
                case URL_Platform_Feedback:
                {
                    return [self getFeedBack:datas];
                }
                    break;
                case URL_Train_Point:
                {
                    return [self getTrainPointInfo:datas];
                }
                    break;
                case URL_Train_DailySetting:
                {
                    return [self getTrainDailySetting:datas];
                }
                    break;
                case URL_Train_SettingInfo:
                {
                    return [self getTrainDailySettingInfo:datas];
                }
                    break;
                case URL_Train_DailyTrain:
                {
                    return [self getDailyTrainQuestionInfo:datas];
                }
                    break;
                case URL_Train_DailyTrainAnswer:
                {
                    return [self getDailyTrainAnswer:datas];
                }
                    break;
                case URL_Question_Content:
                {
                    datas=[[UtilitySDK Instance]aesDecryp:datas WithKey:@"9527952895299530"];
                    datas=[NSJSONSerialization JSONObjectWithData:[datas dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:NSJSONReadingMutableContainers
                                                             error:NULL];
                    return [self getQuestionContent:datas];
                }
                    break;
                case URL_Question_Collection:
                {
                    return [self getCollectionInfo:datas];
                }
                    break;
                case URL_Platform_FeedBack:
                {
                    return [self getPlatformFeddBackInfo:datas];
                }
                    break;
                case URL_Question_Analyze:
                {
                    datas=[[UtilitySDK Instance]aesDecryp:datas WithKey:@"9527952895299530"];
                    datas=[NSJSONSerialization JSONObjectWithData:[datas dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:NSJSONReadingMutableContainers
                                                            error:NULL];
                    return [self getQuestionAnalyze:datas];
                }
                    break;
                case URL_Question_Allinfo:
                {
                    datas=[[UtilitySDK Instance]aesDecryp:datas WithKey:@"9527952895299530"];
                    datas=[NSJSONSerialization JSONObjectWithData:[datas dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:NSJSONReadingMutableContainers
                                                            error:NULL];
                    return [self getQuestionANalyzeAllInfo:datas];
                }
                    break;
                case URL_Forecast_Intro:
                {
                     return [self getForecastIntro:datas];
                }
                    break;
                case URL_Question_Forecast:
                {
                    return [self getQuestionForecast:datas];
                }
                    break;
                case URL_Answer_Forecast:
                {
                    return [self getAnswerForecast:datas];
                }
                    break;
                case URL_Question_Point:
                {
                    return [self getQuestionPoint:datas];
                }
                    break;
                case URL_Answer_Point:
                {
                    return [self getAnswerPoint:datas];
                }
                    break;
                case URL_Record_Search:
                {
                    return [self getHistorySearch:datas];
                }
                    break;
                case URL_Record_Info:
                {
                    return [self getRecordInfo:datas];
                }
                    break;
                case URL_Record_Athletics_Info:
                {
                    return [self getRecordAthleticsInfo:datas];
                }
                    break;
                case URL_Record_Error_PointList:
                {
                    return [self getRecordErrorPointList:datas];
                }
                    break;
                case URL_Record_Collection_PointList:
                {
                    return [self getRecordCollectionPointList:datas];
                }
                    break;
                case URL_Question_Incorrect:
                {
                    return [self getQuestionIncorrectInfo:datas];
                }
                    break;
                case URL_Answer_Incorrect:
                {
                    return [self getAnswerIncorrect:datas];
                }
                    break;
                case URL_Answer_Incorrect_Point:
                {
                    return [self getAnswerIncorrectPoint:datas];
                }
                    break;
                case URL_Record_Question_Collection:
                {
                    return [self getRecordQuestionCollection:datas];
                }
                    break;
                case URL_Answer_Collection:
                {
                     return [self getAnswerCollection:datas];
                }
                    break;
                case URL_Answer_Collection_Point:
                {
                    return [self getAnswerCollectionPoint:datas];
                }
                    break;
                case URL_Athletics_Info:
                {
                    return [self getAthleticsInfo:datas];
                }
                    break;
                case URL_Athletics_Roomlist:
                {
                    return [self getAthleticsRoomlist:datas];
                }
                    break;
                case URL_Athletics_Historylist:
                {
                    return [self getAthleticsHistorylist:datas];
                }
                    break;
                case URL_Athletics_Ranking:
                {
                    return [self getAthleticsRanking:datas];
                }
                    break;
                case URL_Athletics_MyRanking:
                {
                    return [self getAthleticsMyRanking:datas];
                }
                    break;
                case URL_Athletics_Resulte:
                {
                    return [self getAthleticsResulte:datas];
                }
                    break;
                case URL_Athletics_Join:
                {
                    return [self getAthleticsJoin:datas];
                }
                    break;
                case URL_Athletics_Quit:
                {
                    return [self getAthleticsQuit:datas];
                }
                    break;
                case URL_Athletics_RefreshRoom:
                {
                    return [self getAthleticsRefreshRoom:datas];
                }
                    break;
                case URL_Athletics_Submit:
                {
                    return [self getAthleticsSubmit:datas];
                }
                    break;
                case URL_Athletics_Handin:
                {
                    return [self getAthleticsHandin:datas];
                }
                    break;
                default:
                    break;
                    
            }
        }
        NSLog(@"\n数据为空\n");
        return nil;
    }
    else
    {
        switch (conditionCode.intValue) {
            
            case -3:
            {
                NSLog(@"服务器异常");
            }
                break;
            case -6:
            {
                NSString * codeStr=[NSString stringWithFormat:@"%d",-6];
                return [self getRegisterOrLoginInfo:codeStr];
            }
                break;
            case -7:
            {
                NSString * codeStr=[NSString stringWithFormat:@"%d",-7];
                return [self getRegisterOrLoginInfo:codeStr];
            }
                break;
            case -9:
            {
                NSString * errorInfo=[jsonDic objectForKey:@"info"];
                return [self getAthleticsJoinError:errorInfo];
            }
                break;
            case -10:
            {
                NSString * errorInfo=[jsonDic objectForKey:@"info"];
                return [self getAthleticsJoinError:errorInfo];

            }
                break;
            default:
                break;
        }
    }


  
    return nil;
}

#pragma mark － 各个接口数据解析
//解析用户活动通知信息
-(id)getNoticeInfo:(id)datas
{
    NSString * rStr;
    for(NSDictionary * dic in datas)
    {
        rStr=[dic objectForKey:@"notice"];
    }
    
    return rStr;
}
//解析地区信息
-(id)getAreaInfo:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    for(NSDictionary * dic in datas)
    {
        NSString * areaID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"areaid"]).longLongValue];
        NSString * areaName=[dic objectForKey:@"areaname"];
       
        AreaModel * areaMoudel=[[AreaModel alloc]init];
        areaMoudel.areaID=areaID;
        areaMoudel.areaName=areaName;
        
        [rDatas addObject:areaMoudel];
    }
    return (id)rDatas;
}
//解析注册或登录返回信息
-(id)getRegisterOrLoginInfo:(id)datas
{
 
    if([datas isKindOfClass:[NSString class]])
    {
        return datas;
    }
    
    NSString * userID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"userid"]).longLongValue];
    NSString * key=[datas objectForKey:@"key"];
    NSString * areaID=[datas objectForKey:@"areaid"];
    NSString * userName=[datas objectForKey:@"username"];
    NSString * ua=[datas objectForKey:@"ua"];
    
    RegisterOrLoginInfoModel * regOrLoginModel=[[RegisterOrLoginInfoModel alloc]init];
    regOrLoginModel.userID=userID;
    regOrLoginModel.key=key;
    regOrLoginModel.areaID=areaID;
    regOrLoginModel.userName=userName;
    regOrLoginModel.ua=ua;
    
    return (id)regOrLoginModel;
}
//解析找回密码返回信息
-(id)getForgetPasswordInfo:(id)datas
{
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"success"]).intValue];
    return (id)success;
}
//解析登录页面综合分值返回信息
-(id)getAccessAbilityInfo:(id)datas
{
    NSString * synthetic=[datas objectForKey:@"synthetic"];
    NSString * commonsense=[datas objectForKey:@"commonsense"];
    NSString * language=[datas objectForKey:@"language"];
    NSString * quantityrel=[datas objectForKey:@"quantityrel"];
    NSString * inference=[datas objectForKey:@"inference"];
    NSString * dataanalysis=[datas objectForKey:@"dataanalysis"];
    NSString * othersability=[datas objectForKey:@"othersability"];
    NSString * defeatpercent=[datas objectForKey:@"defeatpercent"];
    NSString * totalquestionnum=[datas objectForKey:@"totalquestionnum"];
    
    AccessAbilityModel * accessAbilityModel=[[AccessAbilityModel alloc]init];
    accessAbilityModel.synthetic=synthetic;
    accessAbilityModel.commonsense=commonsense;
    accessAbilityModel.language=language;
    accessAbilityModel.quantityrel=quantityrel;
    accessAbilityModel.inference=inference;
    accessAbilityModel.dataanalysis=dataanalysis;
    accessAbilityModel.othersability=othersability;
    accessAbilityModel.defeatpercent=defeatpercent;
    accessAbilityModel.totalquestionnum=totalquestionnum;
    return (id)accessAbilityModel;
}
//解析登录页面走马灯返回信息
-(id)getPlatformMarqueeInfo:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    for(NSDictionary * dic in datas)
    {
        NSString * msgID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"msgid"]).intValue];
        NSString * usetype=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"usetype"]).intValue];
        NSString * title=[dic objectForKey:@"title"];
        NSString * content=[dic objectForKey:@"content"];
        NSString * creatTime=[dic objectForKey:@"creattime"];
        
        PlatformMarqueeModel * marqueeModel=[[PlatformMarqueeModel alloc]init];
        marqueeModel.msgID=msgID;
        marqueeModel.useType=usetype;
        marqueeModel.title=title;
        marqueeModel.content=content;
        marqueeModel.createTime=creatTime;
        
        [rDatas addObject:marqueeModel];
    }
    return (id)rDatas;

}
//消息列表信息
-(id)getMessageList:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    if([datas isKindOfClass:[NSArray class]])
    {
        NSArray * array=(NSArray *)datas;
        for(NSDictionary * dic in array)
        {
            NSString * msgID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"msgid"]).intValue];
            NSString * usetype=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"usetype"]).intValue];
            NSString * title=[dic objectForKey:@"title"];
            NSString * content=[dic objectForKey:@"content"];
            
            MessageListModel * messageModel=[[MessageListModel alloc]init];
            messageModel.msgID=msgID;
            messageModel.useType=usetype;
            messageModel.title=title;
            messageModel.content=content;
            
            [rDatas addObject:messageModel];
        }
        return (id)rDatas;

    }
   

    return nil;
}
//试题离线返回信息
-(id)getOfflineZiplist:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    NSDictionary * oriDic=(NSDictionary *)datas;
    NSDictionary * oriDatas;
    
    for (NSString * key in oriDic.allKeys) {
        oriDatas=[oriDic objectForKey:key];
        NSString * directoryName=key;
        NSString * fileName=[oriDatas objectForKey:@"filename"];
        NSString * size=[NSString stringWithFormat:@"%qi",((NSString *)[oriDatas objectForKey:@"size"]).longLongValue] ;
        NSString * url=[oriDatas objectForKey:@"url"];
        
        OfflineZiplistModel * offlineModel=[[OfflineZiplistModel alloc]init];
        offlineModel.fileName=fileName;
        offlineModel.size=size;
        offlineModel.url=url;
        offlineModel.directoryName=directoryName;
        
        [rDatas addObject:offlineModel];
        
    }
    
    return (id)rDatas;
    
}

//版本更新信息
-(id)getCheckupdate:(id)datas
{
    NSString * code=[datas objectForKey:@"code"];
    NSDictionary * dic=[datas objectForKey:@"data"];
    NSString * url=[dic objectForKey:@"url"];
    
    CheckUpdateModel * model=[[CheckUpdateModel alloc]init];
    model.code=code;
    model.url=url;
    return (id)model;
}

//意见反馈信息
-(id)getFeedBack:(id)datas
{
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"success"]).intValue];
    
    return (id)success;
}

//知识点树信息
-(id)getAccessPointMaster:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    NSDictionary * oriDic=(NSDictionary *)datas;
    for (NSString * key in oriDic.allKeys) {
        NSArray * array=[oriDic objectForKey:key];
        for (NSDictionary * dic in array) {
            PointMasterModel * model=[[PointMasterModel alloc]init];
            model.grade=[dic objectForKey:@"grade"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.name=[dic objectForKey:@"name"];
            model.doneQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"donequestion"]).longLongValue];
            model.accuracy=[dic objectForKey:@"accuracy"];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.isOpen=NO;
            [rDatas addObject:model];
        }

    }
    return rDatas;
}
//获取练习情况信息
-(id)getAccessPractice:(id)datas
{
    NSString * times=[datas objectForKey:@"times"];
    NSString * masterDegree=[datas objectForKey:@"masterdegree"];
    NSString * masterLevel=[datas objectForKey:@"masterlevel"];
    NSString * coverDegree=[datas objectForKey:@"coverdegree"];
    NSString * coverLevel=[datas objectForKey:@"coverlevel"];
    NSString * speedDegree=[datas objectForKey:@"speeddegree"];
    NSString * speedLevel=[datas objectForKey:@"speedlevel"];
    NSString * accuracyDegree=[datas objectForKey:@"accuracydegree"];
    NSString * accuracyLevel=[datas objectForKey:@"accuracylevel"];
    NSString * dailyFrequency=[datas objectForKey:@"dailyfrequency"];
    NSString * adviceFrequency=[datas objectForKey:@"advicefrequency"];
    NSString * dailyPaytime=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"dailypaytime"]).longLongValue];
    NSString * advicePaytime=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"advicepaytime"]).longLongValue];
    
    
    PracticeConditionModel * model=[[PracticeConditionModel alloc]init];
    model.times=times;
    model.masterLevel=masterLevel;
    model.masterDegree=masterDegree;
    model.coverDegree=coverDegree;
    model.coverLevel=coverLevel;
    model.speedDegree=speedDegree;
    model.speedLevel=speedLevel;
    model.accuracyDegree=accuracyDegree;
    model.accuracyLevel=accuracyLevel;
    model.dailyFrequency=dailyFrequency;
    model.adviceFrequency=adviceFrequency;
    model.dailyPaytime=dailyPaytime;
    model.advicePaytime=advicePaytime;
    return (id)model;
}
//获取备考建议信息
-(id)getAccessExam:(id)datas
{
    NSDictionary * times=[datas objectForKey:@"timescore"];
    NSString * averagetime=[datas objectForKey:@"averagetime"];
    NSString * commonsenseTime=[datas objectForKey:@"commonsense_time"];
    NSString * quantityrelTime=[datas objectForKey:@"quantityrel_time"];
    NSString * inferenceTime=[datas objectForKey:@"inference_time"];
    NSString * dataanalysisTime=[datas objectForKey:@"dataanalysis_time"];
    NSString * languateTime=[datas objectForKey:@"language_time"];

    ExamInfoModel * model=[[ExamInfoModel alloc]init];
    model.averageTime=averagetime;
    model.commonsenseTime=commonsenseTime;
    model.quantityRelTime=quantityrelTime;
    model.inferenceTime=inferenceTime;
    model.dataAnalysisTime=dataanalysisTime;
    model.languageTime=languateTime;
    
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:times.allKeys.count];
    for(NSString * key in times.allKeys)
    {
        NSString * value=[times objectForKey:key];
        [array addObject:value];
    }
    
    model.timesScore=array;
    
    return (id)model;

}

//获取每日训练知识点状态
-(id)getTrainPointInfo:(id)datas
{
    NSMutableArray * rDatas=[NSMutableArray array];
    for(NSDictionary * dic in datas)
    {
        NSString * finish=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"finish"]).intValue];
        NSString * masterLevel=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterlevel"]).intValue];
        NSString * pointID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"id"]).intValue];
        NSString * name=[dic objectForKey:@"name"];
        NSString * level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
        NSString * parentID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"parentid"]).intValue];
        
        
        TrainPointInfoModel * trainPointInfo=[[TrainPointInfoModel alloc]init];
        trainPointInfo.finish=finish;
        trainPointInfo.masterLevel=masterLevel;
        trainPointInfo.pointID=pointID;
        trainPointInfo.name=name;
        trainPointInfo.level=level;
        trainPointInfo.parentID=parentID;
        
        [rDatas addObject:trainPointInfo];
    }
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if (((TrainPointInfoModel *)obj1).pointID.intValue > ((TrainPointInfoModel *)obj2).pointID.intValue) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
         if (((TrainPointInfoModel *)obj1).pointID.intValue < ((TrainPointInfoModel *)obj2).pointID.intValue){
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortArray = [rDatas sortedArrayUsingComparator:cmptr];
    return (id)sortArray;
}

//获取每日训练用户设置是否成功
-(id)getTrainDailySetting:(id)datas
{
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"success"]).intValue];
    return (id)success;
}

//获取每日训练用户设置信息
-(id)getTrainDailySettingInfo:(id)datas
{
    NSString * dailyNum=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"dailynum"]).intValue];
    NSString * pointIDs=[datas objectForKey:@"pointids"];
    
    TrainSettingInfoModel * model=[[TrainSettingInfoModel alloc]init];
    model.dailyNum=dailyNum;
    if(pointIDs)
    {
        model.pointIDs=pointIDs;
        return (id)model;
    }
    return nil;
    
}

//获取每日训练题目信息
-(id)getDailyTrainQuestionInfo:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSString * parperID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"paperid"]).longLongValue];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
      
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"type"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=parperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [objs addObject:question];
    }
    return objs;
}

//获取每日训练答题结果
-(id)getDailyTrainAnswer:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;
}

//获取我猜你练数据信息
-(id)getForecastIntro:(id)datas
{
    NSDictionary * dic=datas;;

    NSString * totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
    NSString * rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
    NSString * forecastRight=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"forecastright"]).intValue];
    NSString * wrongNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"wrongnum"]).intValue];
    NSString * forecastWrong=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"forecastwrong"]).intValue];
    
    ForeCastInfoModel * forecast=[[ForeCastInfoModel alloc]init];
    forecast.totalNum=totalNum;
    forecast.rightNum=rightNum;
    forecast.forecastRight=forecastRight;
    forecast.wrongNum=wrongNum;
    forecast.forecastWrong=forecastWrong;
    
    return forecast;

}

//获取我猜你练抽题信息
-(id)getQuestionForecast:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSString * parperID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"paperid"]).longLongValue];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"type"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=parperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [objs addObject:question];
    }
    return objs;
}

//我猜你练交卷信息
-(id)getAnswerForecast:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;

}
//获得考点直击抽题内容
-(id)getQuestionPoint:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSString * parperID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"paperid"]).longLongValue];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"type"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=parperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [objs addObject:question];
    }
    return objs;
}
//获得考点直击交卷内容
-(id)getAnswerPoint:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;

}

//获取题目内容
-(id)getQuestionContent:(id)datas
{
    NSDictionary * dic=datas;
    NSData * jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString * qid=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"qid"]).longLongValue];
    NSString * stem=[dic objectForKey:@"stem"];
    NSString * question=[dic objectForKey:@"question"];
    NSString * type=[dic objectForKey:@"type"];
    NSArray * choices=[dic objectForKey:@"choice"];
    NSString * standardAnswer=[dic objectForKey:@"standanswer"];
    NSString * sourceYear=[dic objectForKey:@"sourceyear"];
    NSString * source=[dic objectForKey:@"source"];
    NSString * seqinpastPaper=[dic objectForKey:@"seqinpastPaper"];
    NSString * paperName=[dic objectForKey:@"papername"];

    QuestionContent * questionContent=[[QuestionContent alloc]init];
    questionContent.qID=qid;
    questionContent.stem=stem;
    questionContent.question=question;
    questionContent.type=type;
    questionContent.choice=choices;
    questionContent.standardAnswer=standardAnswer;
    questionContent.sourceYear=sourceYear;
    questionContent.source=source;
    questionContent.seqinpastPaper=seqinpastPaper;
    questionContent.paperName=paperName;
    questionContent.jsonStr=jsonStr;
    return questionContent;
}

//获取题目收藏信息
-(id)getCollectionInfo:(id)datas
{
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"success"]).intValue];
    
    return (id)success;
}

//获取题目纠错信息
-(id)getPlatformFeddBackInfo:(id)datas
{
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[datas objectForKey:@"success"]).intValue];
    
    return (id)success;
}

//单个试题答案解析
-(id)getQuestionAnalyze:(id)datas
{
    NSDictionary * dic=datas;
    NSData * jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString * qid=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"qid"]).longLongValue];
    NSString * userAnswer=[dic objectForKey:@"useranswer"];
    NSString * knowledgePoint=[dic objectForKey:@"knowledgepoint"];
    NSString * answerComment=[dic objectForKey:@"answercomment"];
    
    QuestionAnalyze * analyze=[[QuestionAnalyze alloc]init];
    analyze.qid=qid;
    analyze.userAnswer=userAnswer;
    analyze.knowledgePoint=knowledgePoint;
    analyze.answerComment=answerComment;
    analyze.jsonStr=jsonStr;
 
    return analyze;
}

//单个试题答案解析（题干＋解析）
-(id)getQuestionANalyzeAllInfo:(id)datas
{
    NSDictionary * dic=datas;
    NSData * jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString * qid=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"qid"]).longLongValue];
    NSString * userAnswer=[dic objectForKey:@"useranswer"];
    NSString * knowledgePoint=[dic objectForKey:@"knowledgepoint"];
    NSString * answerComment=[dic objectForKey:@"answercomment"];
//    NSString * source=[dic objectForKey:@"source"];
//    NSString * stem=[dic objectForKey:@"stem"];
//    NSString * type=[dic objectForKey:@"type"];
//    NSArray * choice=[dic objectForKey:@"choice"];
//    NSString * seqinPastPaper=[dic objectForKey:@"seqinpastpaper"];
//    NSString * question=[dic objectForKey:@"question"];
//    NSString * standAnswer=[dic objectForKey:@"standanswer"];
//    NSString * paperName=[dic objectForKey:@"papername"];
//    NSString * from=[dic objectForKey:@"from"];
//    NSString * sourceYear=[dic objectForKey:@"sourceyear"];
//    
    
    QuestionAnalyze * analyze=[[QuestionAnalyze alloc]init];
    analyze.qid=qid;
    analyze.userAnswer=userAnswer;
    analyze.knowledgePoint=knowledgePoint;
    analyze.answerComment=answerComment;
    analyze.jsonStr=jsonStr;
    
    return analyze;
}
//答题历史查询解析
-(id)getHistorySearch:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
   
    NSArray *array=(NSArray *)datas;
    for (NSDictionary * dic in array) {
        
        NSString * recordID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
        NSString * title=[dic objectForKey:@"title"];
        NSString * date=[dic objectForKey:@"date"];
        NSString * totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
        NSString * rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
        
        ExercisRecordModel * model=[[ExercisRecordModel alloc]init];
        model.recordID=recordID;
        model.title=title;
        model.date=date;
        model.totalNum=totalNum;
        model.rightNum=rightNum;
        
        [objs addObject:model];
    }
    return objs;
}

//答题记录详情
-(id)getRecordInfo:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;
}
//答题记录竞技练习详情
-(id)getRecordAthleticsInfo:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    
    //解析reward
    NSDictionary * rewardDic=[dic objectForKey:@"reward"];
    
    CompetRewardModel * competReward=[[CompetRewardModel alloc]init];
    competReward.userID=[NSString stringWithFormat:@"%qi",((NSString *)[rewardDic objectForKey:@"userid"]).longLongValue];
    competReward.nickName=[rewardDic objectForKey:@"nickname"];
    competReward.ranking=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"ranking"]).intValue];
    competReward.grade=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"grade"]).intValue];
    competReward.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"totalnum"]).intValue];
    competReward.finishNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"finishnum"]).intValue];
    competReward.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"rightnum"]).intValue];
    competReward.createTime=[rewardDic objectForKey:@"createtime"];
    
    
    [retDic setObject:competReward forKey:@"reward"];
    
    //解析rank
    NSDictionary * rankObjs=[dic objectForKey:@"rank"];
    NSMutableArray * ranks=[NSMutableArray array];
    if(rankObjs)
    {
        for(NSDictionary * dic in rankObjs)
        {
            CompetResultRankModel * competRank=[[CompetResultRankModel alloc]init];
            competRank.userID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"userid"]).longLongValue];
            competRank.nickName=[dic objectForKey:@"nickname"];
            competRank.ranking=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ranking"]).longLongValue];
            competRank.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            competRank.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            [ranks addObject:competRank];
        }
        
    }
    [retDic setObject:ranks forKey:@"rank"];
    
    return retDic;

}
//错题首页数据
-(id)getRecordErrorPointList:(id)datas
{
    
    NSMutableArray * objs=[NSMutableArray array];
    
    NSDictionary *dataDic=(NSDictionary *)datas;
    NSString * totalNum=[NSString stringWithFormat:@"%qi",((NSString *)[dataDic objectForKey:@"totalnum"]).longLongValue];
    NSArray * array=[dataDic objectForKey:@"errorlist"];
    for (NSDictionary * dic in array) {
        
        NSString * errorID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"id"]).intValue];
        NSString * errorNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"errornum"]).longLongValue];
        NSString * name=[dic objectForKey:@"name"];
        
        
        ErrorListModel * model=[[ErrorListModel alloc]init];
        model.errorID=errorID;
        model.name=name;
        model.errorNum=errorNum;
        model.totalNum=totalNum;
        [objs addObject:model];
    }
    return objs;
}

//错题抽题信息
-(id)getQuestionIncorrectInfo:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSString * parperID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"paperid"]).longLongValue];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"type"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=parperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [objs addObject:question];
    }
    return objs;

}

//收藏首页数据
-(id)getRecordCollectionPointList:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    
    NSDictionary *dataDic=(NSDictionary *)datas;
    NSString * totalNum=[NSString stringWithFormat:@"%qi",((NSString *)[dataDic objectForKey:@"totalnum"]).longLongValue];
    NSArray * array=[dataDic objectForKey:@"collectlist"];
    for (NSDictionary * dic in array) {
        
        NSString * favoriteID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"id"]).intValue];
        NSString * favoriteNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"collectnum"]).longLongValue];
        NSString * name=[dic objectForKey:@"name"];
        
        
        FavoriteListModel * model=[[FavoriteListModel alloc]init];
        model.favoriteID=favoriteID;
        model.name=name;
        model.favoriteNum=favoriteNum;
        model.totalNum=totalNum;
        [objs addObject:model];
    }
    return objs;
}

//错题库交卷信息
-(id)getAnswerIncorrect:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;
}

//错题库答案解析
-(id)getAnswerIncorrectPoint:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        NSString * from=[dic objectForKey:@"from"];
        NSString * isCollect=[dic objectForKey:@"iscollect"];
        NSString * questionID=[dic objectForKey:@"questionid"];
        NSString * questionType=[dic objectForKey:@"questiontype"];
        NSString * url=[dic objectForKey:@"url"];
        
        ErrorAnalyzeModel * model=[[ErrorAnalyzeModel alloc]init];
        model.from=from;
        model.isCollect=isCollect;
        model.questionID=questionID;
        model.questionType=questionType;
        model.url=url;
        
        [objs addObject:model];
    }
    return objs;
}

//收藏抽题接口
-(id)getRecordQuestionCollection:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSString * parperID=[NSString stringWithFormat:@"%qi",((NSString *)[datas objectForKey:@"paperid"]).longLongValue];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"type"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=parperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [objs addObject:question];
    }
    return objs;
}

//收藏夹交卷接口
-(id)getAnswerCollection:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    return retDic;
}

//收藏答案解析
-(id)getAnswerCollectionPoint:(id)datas
{
    NSMutableArray * objs=[NSMutableArray array];
    NSArray *array=[datas objectForKey:@"questions"];
    for (NSDictionary * dic in array) {
        NSString * questionID=[dic objectForKey:@"questionid"];
        NSString * questionType=[dic objectForKey:@"questiontype"];
        NSString * url=[dic objectForKey:@"url"];
        
        FavoriteAnalyzeModel * model=[[FavoriteAnalyzeModel alloc]init];
        model.questionID=questionID;
        model.questionType=questionType;
        model.url=url;
        
        [objs addObject:model];
    }
    return objs;

}

//竞技场基本情况解析
-(id)getAthleticsInfo:(id)datas
{
    NSDictionary *dic=(NSDictionary *)datas;
    
    NSString * onlineNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"onlinenum"]).longLongValue];
    NSString * roomNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"roomnum"]).longLongValue];
    NSString * freeRoom=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"freeroom"]).longLongValue];
    NSString * usingRoom=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"usingroom"]).intValue];
    CompetConditionModel * model=[[CompetConditionModel alloc]init];
    model.onlineNum=onlineNum;
    model.roomNum=roomNum;
    model.freeRoom=freeRoom;
    model.usingRoom=usingRoom;
    
    return model;
}

//竞技场房间列表
-(id)getAthleticsRoomlist:(id)datas
{
    
    NSMutableArray *objs=[NSMutableArray array];

    NSArray * array=(NSArray *)datas;
    for(NSDictionary * dic in array)
    {
        NSString * roomID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomid"]).intValue];
        NSString * roomCode=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomcode"]).intValue];
        NSString * curNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"curnum"]).intValue];
        NSString * maxNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"maxnum"]).intValue];
        NSString * examType=[dic objectForKey:@"examtype"];
        NSString * topicNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"topicnum"]).intValue];
        NSString * examTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"examtime"]).intValue];
        NSString * state=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"state"]).intValue];
       
        CompetRoomlistModel * model=[[CompetRoomlistModel alloc]init];
        model.roomID=roomID;
        model.roomCode=roomCode;
        model.curNum=curNum;
        model.maxNum=maxNum;
        model.examType=examType;
        model.topicNum=topicNum;
        model.examTime=examTime;
        model.state=state;
        
        [objs addObject:model];
    }
    return objs;
}

//竞技场记录列表
-(id)getAthleticsHistorylist:(id)datas
{
    NSMutableArray *objs=[NSMutableArray array];
    
    NSArray * array=(NSArray *)datas;
    for(NSDictionary * dic in array)
    {
        NSString * recordID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"recordid"]).longLongValue];
        NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"paperid"]).longLongValue];
        NSString * athleticsType=[dic objectForKey:@"athleticstype"];
        NSString * joinNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"joinnum"]).intValue];
        NSString * time=[dic objectForKey:@"time"];
        NSString * ranking=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"ranking"]).intValue];
        
        CompetHistorylistModel * model=[[CompetHistorylistModel alloc]init];
        model.recordID=recordID;
        model.paperID=paperID;
        model.athleticsType=athleticsType;
        model.joinNum=joinNum;
        model.time=time;
        model.ranking=ranking;
        
        [objs addObject:model];
    }
    return objs;
}

//竞技场总排行榜
-(id)getAthleticsRanking:(id)datas
{
    NSMutableArray *objs=[NSMutableArray array];
    
    NSArray * array=(NSArray *)datas;
    for(NSDictionary * dic in array)
    {
        NSString * userID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"userid"]).longLongValue];
        NSString * nickName=[dic objectForKey:@"nickname"];
        NSString * ranking=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ranking"]).longLongValue];
        NSString * athleticsNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ahtleticsnum"]).longLongValue];
        NSString * athleticsAvggrade=[NSString stringWithFormat:@"%f",((NSString *)[dic objectForKey:@"athleticsavggrade"]).doubleValue];
      
        
        CompetRankingModel * model=[[CompetRankingModel alloc]init];
        model.userID=userID;
        model.nickName=nickName;
        model.ranking=ranking;
        model.athleticsNum=athleticsNum;
        model.athleticsAvggrade=athleticsAvggrade;

        
        [objs addObject:model];
    }
    
    return objs;
}

//竞技场我的排行
-(id)getAthleticsMyRanking:(id)datas
{
    
    NSMutableArray *objs=[NSMutableArray array];
    
    NSArray * array=(NSArray *)datas;
    for(NSDictionary * dic in array)
    {
        NSString * userID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"userid"]).longLongValue];
        NSString * nickName=[dic objectForKey:@"nickname"];
        NSString * ranking=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ranking"]).longLongValue];
        NSString * athleticsNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ahtleticsnum"]).longLongValue];
        NSString * athleticsAvggrade=[NSString stringWithFormat:@"%f",((NSString *)[dic objectForKey:@"athleticsavggrade"]).doubleValue];
        
        CompetRankingModel * model=[[CompetRankingModel alloc]init];
        model.userID=userID;
        model.nickName=nickName;
        model.ranking=ranking;
        model.athleticsNum=athleticsNum;
        model.athleticsAvggrade=athleticsAvggrade;
        
        
        [objs addObject:model];
    }
    
    return objs;
}

//竞技场成绩查询
-(id)getAthleticsResulte:(id)datas
{
    NSMutableDictionary * retDic=[NSMutableDictionary dictionary];
    NSDictionary * dic=datas;
    dic=[dic objectForKey:@"map"];
    //解析basic
    NSDictionary * basicDic=[dic objectForKey:@"basic"];
    TrainAnswerBasic * answerBasic=[[TrainAnswerBasic alloc]init];
    if(basicDic)
    {
        answerBasic.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"totalnum"]).intValue];
        answerBasic.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"rightnum"]).intValue];
        answerBasic.payTime=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"paytime"]).intValue];
        answerBasic.speedNum=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"speednum"]).intValue];
        answerBasic.foreCast=[NSString stringWithFormat:@"%d",((NSString *)[basicDic objectForKey:@"forecast"]).intValue];
        answerBasic.createTime=[basicDic objectForKey:@"createtime"];
    }
    [retDic setObject:answerBasic forKey:@"basic"];
    
    //解析pointpromote
    NSDictionary * pointsDic=[[dic objectForKey:@"points"]objectForKey:@"pointpromote"];
    NSMutableArray * rDatas=[NSMutableArray array];
    for (NSString * key in pointsDic) {
        NSArray * array=[pointsDic objectForKey:key];
        for (NSDictionary * dic in array) {
            TrainAnswerPoint * model=[[TrainAnswerPoint alloc]init];
            model.pID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"id"]).longLongValue];
            model.name=[dic objectForKey:@"name"];
            model.level=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"level"]).intValue];
            model.parentID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"parentid"]).longLongValue];
            NSArray * childs=[dic objectForKey:@"childs"];
            NSMutableArray * parseChild=[NSMutableArray arrayWithCapacity:childs.count];
            for(NSString * value in childs)
            {
                NSString * childValue=[NSString stringWithFormat:@"%qi",((NSString *)value).longLongValue];
                [parseChild addObject:childValue];
            }
            model.childs=parseChild;
            model.totalQuestion=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"totalquestion"]).longLongValue];
            model.changeRate=[dic objectForKey:@"changerate"];
            model.masterDegree=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"masterdegree"]).intValue];
            model.isOpen=NO;
            [rDatas addObject:model];
        }
    }
    [retDic setObject:rDatas forKey:@"points"];
    
    //解析pointsummary
    NSArray * pointsummary=[[dic objectForKey:@"points"]objectForKey:@"pointsummary"];
    NSMutableArray * summarys=[NSMutableArray array];
    if(pointsummary)
    {
        for(NSDictionary * dic in pointsummary)
        {
            TrainAnswerPointSummary * answerSummary=[[TrainAnswerPointSummary alloc]init];
            answerSummary.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"totalnum"]).intValue];
            answerSummary.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            answerSummary.accuracy=[dic objectForKey:@"accuracy"];
            answerSummary.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            answerSummary.name=[dic objectForKey:@"name"];
            [summarys addObject:answerSummary];
        }
    }
    [retDic setObject:summarys forKey:@"pointsummary"];
    
    //解析sheet
    NSArray * sheetObjs=[[dic objectForKey:@"sheet"]objectForKey:@"answerlist"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[[dic objectForKey:@"sheet"]objectForKey:@"paperid"]).longLongValue];
    NSMutableArray * sheets=[NSMutableArray array];
    if(sheetObjs)
    {
        for(NSDictionary * dic in sheetObjs)
        {
            TrainAnswerSheet * answerSheet=[[TrainAnswerSheet alloc]init];
            answerSheet.paperID=paperID;
            answerSheet.index=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"index"]).intValue];
            answerSheet.questionID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questionid"]).intValue];
            answerSheet.status=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"status"]).intValue];
            answerSheet.answers=[dic objectForKey:@"answers"];
            answerSheet.url=[dic objectForKey:@"url"];
            answerSheet.isFavorite=((NSString *)[dic objectForKey:@"iscollect"]).boolValue;
            [sheets addObject:answerSheet];
        }
    }
    [retDic setObject:sheets forKey:@"sheet"];
    
    //解析reward
    NSDictionary * rewardDic=[dic objectForKey:@"reward"];

    CompetRewardModel * competReward=[[CompetRewardModel alloc]init];
    competReward.userID=[NSString stringWithFormat:@"%qi",((NSString *)[rewardDic objectForKey:@"userid"]).longLongValue];
    competReward.nickName=[rewardDic objectForKey:@"nickname"];
    competReward.ranking=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"ranking"]).intValue];
    competReward.grade=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"grade"]).intValue];
    competReward.totalNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"totalnum"]).intValue];
    competReward.finishNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"finishnum"]).intValue];
    competReward.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[rewardDic objectForKey:@"rightnum"]).intValue];
    competReward.createTime=[rewardDic objectForKey:@"createtime"];
    
    
    [retDic setObject:competReward forKey:@"reward"];

    //解析rank
    NSDictionary * rankObjs=[dic objectForKey:@"rank"];
    NSMutableArray * ranks=[NSMutableArray array];
    if(rankObjs)
    {
        for(NSDictionary * dic in rankObjs)
        {
            CompetResultRankModel * competRank=[[CompetResultRankModel alloc]init];
            competRank.userID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"userid"]).longLongValue];
            competRank.nickName=[dic objectForKey:@"nickname"];
            competRank.ranking=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"ranking"]).longLongValue];
            competRank.rightNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"rightnum"]).intValue];
            competRank.payTime=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"paytime"]).intValue];
            [ranks addObject:competRank];
        }
        
    }
    [retDic setObject:ranks forKey:@"rank"];
    
    return retDic;

}

//竞技场加入房间
-(id)getAthleticsJoin:(id)datas
{
    NSDictionary *dic=(NSDictionary *)datas;
    NSMutableDictionary * retData=[NSMutableDictionary dictionary];
    
    //解析房间信息
    NSString * curNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"curnum"]).intValue];
    NSString * startTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"starttime"]).longLongValue];
    NSString * waitingTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"waitingtime"]).longLongValue];
    NSString * roomID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomid"]).intValue];
    NSString * roomCode=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomcode"]).intValue];
    NSString * state=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"state"]).intValue];
    NSString * maxNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"maxnum"]).intValue];
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"success"]).intValue];
    NSString * countDown=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"countdown"]).intValue];
    NSString * examType=[dic objectForKey:@"examtype"];
    NSString * topicNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"topicnum"]).longLongValue];
    NSString * examTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"exatime"]).longLongValue];
    
    CompetRoomModel * roomModel=[[CompetRoomModel alloc]init];
    roomModel.curNum=curNum;
    roomModel.startTime=startTime;
    roomModel.waitTime=waitingTime;
    roomModel.roomID=roomID;
    roomModel.roomCode=roomCode;
    roomModel.state=state;
    roomModel.maxNum=maxNum;
    roomModel.success=success;
    roomModel.countDown=countDown;
    roomModel.examType=examType;
    roomModel.topicNum=topicNum;
    roomModel.examTime=examTime;
    
    [retData setObject:roomModel forKey:@"RoomInfo"];
    //解析竞技参与用户列表
    NSDictionary * users=[dic objectForKey:@"usermap"];
    NSMutableArray * examUsers=[NSMutableArray array];
    for(NSString * key in users.allKeys)
    {
        NSDictionary * user=[users objectForKey:key];
        NSString * userID=[NSString stringWithFormat:@"%qi",((NSString *)[user objectForKey:@"userid"]).longLongValue];
        NSString * userName=[user objectForKey:@"username"];
        NSString * athleticsNum=[NSString stringWithFormat:@"%qi",((NSString *)[user objectForKey:@"athleticsnum"]).longLongValue];
        NSString * averageScore=[NSString stringWithFormat:@"%.1f",((NSString *)[user objectForKey:@"averagescore"]).floatValue];
        
        CompetRoomUser * roomUser=[[CompetRoomUser alloc]init];
        roomUser.userID=userID;
        roomUser.userName=userName;
        roomUser.athleticsNum=athleticsNum;
        roomUser.averageScore=averageScore;
        
        [examUsers addObject:roomUser];
    }
   
    [retData setObject:examUsers forKey:@"UserList"];
    //解析试卷信息
    NSDictionary * paper=[dic objectForKey:@"paper"];
    NSString * paperID=[NSString stringWithFormat:@"%qi",((NSString *)[paper objectForKey:@"paperid"]).longLongValue];
    NSArray * array=[paper objectForKey:@"questions"];
    NSMutableArray * questions=[NSMutableArray array];
    for(NSDictionary * dic in array)
    {
        
        NSString * questionType=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"questiontype"]).intValue];
        NSString * questionID=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"questionid"]).longLongValue];
        NSString * standardAnswer=[dic objectForKey:@"standardanswer"];
        NSString * url=[dic objectForKey:@"url"];
        NSString * isCollect=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"iscollect"]).intValue];
        
        TrainQuestionInfo * question=[[TrainQuestionInfo alloc]init];
        question.paperID=paperID;
        question.questionID=questionID;
        question.questionType=questionType;
        question.standardAnswer=standardAnswer;
        question.url=url;
        question.isCollect=isCollect;
        [questions addObject:question];

    }
    
    [retData setObject:questions forKey:@"Questions"];
    
    return retData;

}

//竞技场加入房间错误信息
-(id)getAthleticsJoinError:(id)datas
{
    return datas;
}

//竞技场退出房间
-(id)getAthleticsQuit:(id)datas
{
    NSDictionary * dic=(NSDictionary *)datas;
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"success"]).intValue];
    return success;
}

//竞技场刷新房间
-(id)getAthleticsRefreshRoom:(id)datas
{
    NSDictionary *dic=(NSDictionary *)datas;
    NSMutableDictionary * retData=[NSMutableDictionary dictionary];
    
    //解析房间信息
    NSString * curNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"curnum"]).intValue];
    NSString * startTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"starttime"]).longLongValue];
    NSString * waitingTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"waitingtime"]).longLongValue];
    NSString * roomID=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomid"]).intValue];
    NSString * roomCode=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"roomcode"]).intValue];
    NSString * state=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"state"]).intValue];
    NSString * maxNum=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"maxnum"]).intValue];
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"success"]).intValue];
    NSString * countDown=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"countdown"]).intValue];
    NSString * examType=[dic objectForKey:@"examtype"];
    NSString * topicNum=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"topicnum"]).longLongValue];
    NSString * examTime=[NSString stringWithFormat:@"%qi",((NSString *)[dic objectForKey:@"exatime"]).longLongValue];
    
    CompetRoomModel * roomModel=[[CompetRoomModel alloc]init];
    roomModel.curNum=curNum;
    roomModel.startTime=startTime;
    roomModel.waitTime=waitingTime;
    roomModel.roomID=roomID;
    roomModel.roomCode=roomCode;
    roomModel.state=state;
    roomModel.maxNum=maxNum;
    roomModel.success=success;
    roomModel.countDown=countDown;
    roomModel.examType=examType;
    roomModel.topicNum=topicNum;
    roomModel.examTime=examTime;
    
    [retData setObject:roomModel forKey:@"RoomInfo"];
    //解析竞技参与用户列表
    NSDictionary * users=[dic objectForKey:@"usermap"];
    NSMutableArray * examUsers=[NSMutableArray array];
    for(NSString * key in users.allKeys)
    {
        NSDictionary * user=[users objectForKey:key];
        NSString * userID=[NSString stringWithFormat:@"%qi",((NSString *)[user objectForKey:@"userid"]).longLongValue];
        NSString * userName=[user objectForKey:@"username"];
        NSString * athleticsNum=[NSString stringWithFormat:@"%qi",((NSString *)[user objectForKey:@"athleticsnum"]).longLongValue];
        NSString * averageScore=[NSString stringWithFormat:@"%.1f",((NSString *)[user objectForKey:@"averagescore"]).floatValue];
        
        CompetRoomUser * roomUser=[[CompetRoomUser alloc]init];
        roomUser.userID=userID;
        roomUser.userName=userName;
        roomUser.athleticsNum=athleticsNum;
        roomUser.averageScore=averageScore;
        
        [examUsers addObject:roomUser];
    }
    
    [retData setObject:examUsers forKey:@"UserList"];
    //解析试卷信息
    
    return retData;
}

//竞技场单题提交
-(id)getAthleticsSubmit:(id)datas
{
    NSDictionary *dic=(NSDictionary *)datas;
    NSString * ranking=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"ranking"]).intValue];
    return ranking;
}

//竞技场主动交卷或退出
-(id)getAthleticsHandin:(id)datas
{
    NSDictionary *dic=(NSDictionary *)datas;
    NSString * success=[NSString stringWithFormat:@"%d",((NSString *)[dic objectForKey:@"success"]).intValue];
    return success;
}
@end
