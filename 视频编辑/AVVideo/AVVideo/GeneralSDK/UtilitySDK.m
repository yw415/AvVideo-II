//
//  UtilitySDK.m
//  GeneralFrame
//
//  Created by user on 14-4-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "UtilitySDK.h"
#import "ZipArchive.h"
#import "FMDB.h"
#import "AppDelegate.h"
#import "NSData+AES.h"
#import "GTMBase64.h"
#import "NSArray+objectAtIndexSafe.h"
@implementation UtilitySDK
///单例模式
+(UtilitySDK *)Instance
{
    static UtilitySDK * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

///获取设备号
-(NSString *)get_imei
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

///获取设备信息
- (NSString*) get_ua
{
    NSString* ua = [NSString stringWithFormat:@"%@-%@%@",
					[UIDevice currentDevice].model,
					[UIDevice currentDevice].systemName,
					[UIDevice currentDevice].systemVersion];
	return ua;
}

/**
 *获取工程中html文件中的html文本内容
 *@pragma fileName 相关文件名 如 aaa.html
 *@return Nsstring html文件中所包含的html文本
 */
- (NSString *)getHtmlFileContent:(NSString *) fileName
{
    NSBundle * bundle=[NSBundle mainBundle];
    NSString * resPath=[bundle resourcePath];
    NSString * filePath=[resPath stringByAppendingPathComponent:fileName];
    NSString * htmlStr=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return htmlStr;
}

/**
 *通过谓词与正则进行验证
 *@pragma regex 正则表达式
 *@pragma str 要匹配的文本
 *@return BOOL 文本是否匹配正则
 */
-(BOOL)validateRegex:(NSString *)regex str:(NSString *)str
{
    NSPredicate * test=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:str];
}

/**
 *根据色值构造图片
 *@pargm color 颜色
 *@pargm rect 图片大小
 *@return UIImage 构造的图片
 */
-(UIImage *)getImageFromColor:(UIColor *)color rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}

/**
 *截屏
 *@pargm view 要截屏的view
 *@return UIImage 截取的图片
 */
-(UIImage *)capture :(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *创建文件夹
 *@pargm directory 要创建的文件夹名称
 *@return NSString 所创建的文件夹的绝对路径
 */
-(NSString *)creatDirectiory :(NSString *)directory
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndexSafe:0];
    path=[path stringByAppendingPathComponent:directory];
    if(![[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    return path;
}

/**
 *获取文件夹大小
 *@pargm directory 所要查看的文件夹
 *@return CGFloat 文件夹大小
 */
-(CGFloat)getDirectiorySize:(NSString *)directory
{
    BOOL isDir;
    CGFloat size=0.0;
    if(([[NSFileManager defaultManager]fileExistsAtPath:directory isDirectory:&isDir] && isDir))
    {
        NSArray * contents=nil;
        NSString * filePath=nil;
        contents=[[NSFileManager defaultManager]subpathsAtPath:directory];
        NSEnumerator * enumerator=[contents objectEnumerator];
        while (filePath=[enumerator nextObject])
        {
            NSString * path=[directory stringByAppendingPathComponent:filePath];
            NSDictionary *fileAttributeDic=[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        
        
    }
    return size;
}

/**
 *获取文件夹下的所有文件名
 *@pargm directory 所要查看的文件夹
 *@return NSArray 文件夹名集合
 */
-(NSArray *)getFilesInDirectory:(NSString *)directory
{
    return [[NSFileManager defaultManager]contentsOfDirectoryAtPath:directory error:nil];
}

/**
 *删除已有文件
 *@pargm filePath 所要删除的文件
 *@return Bool 是否成功删除
 */
-(BOOL)deleteFile:(NSString *)filePath
{

    return [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];

}

/**
 *删除已有文件夹
 *@pargm directory 所要删除的文件夹
 *@return Bool 是否成功删除
 */
-(BOOL)deleteDirectory:(NSString *)directory
{
    BOOL isDir;
    if(([[NSFileManager defaultManager]fileExistsAtPath:directory isDirectory:&isDir] && isDir))
    {
        return [[NSFileManager defaultManager]removeItemAtPath:directory error:nil];
    }
    return NO;
}


/**：
 *判断文件是否已存在
 *@pargm fileName 文件名
 *@pargm directory 文件夹名
 *@return Bool 是否存在
 */
-(BOOL)fileHaveExist:(NSString*)fileName atDirectory:(NSString *)directory
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndexSafe:0];
    path=[path stringByAppendingPathComponent:directory];
    path=[path stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager]fileExistsAtPath:path];
}

/**
 *将已有文件拷贝进指定路径：
 *@pargm filePath 已有文件路径
 *@pargm savePath 保存文件路径
 *@return Bool 是否成功
 */
-(BOOL)saveFile:(NSString *)filePath
     toSavePath:(NSString *)savePath
{
    NSData * data=[NSData dataWithContentsOfFile:filePath];
    if(data)
    {
         return [data writeToFile:savePath atomically:YES];
    }
    else
    {
        return NO;
    }
}

/**
 *判断文件夹是否已存在：
 *@pargm directory 文件夹名
 *@return Bool 是否存在
 */
-(BOOL)directoryHaveExist:(NSString *)directory
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndexSafe:0];
    path=[path stringByAppendingPathComponent:directory];
    return [[NSFileManager defaultManager]fileExistsAtPath:path];
}

/**
 *解压zip包到指定的文件夹
 *@pargm pathArrays 解压缩文件存法路径结合
 *@pargm directory 解压至的文件夹
 *@pargm progressBlock 解压缩进度回调块
 */
-(void)unzipFile:(NSArray*)pathArrays
       directory:(NSArray *)directory
   progressBlock:(void(^)(int percentage, int filesProcessed, unsigned long numFiles,NSInteger queueTag))progressBlock
{
    //构建解压队列
    dispatch_queue_t unzipQueue=dispatch_queue_create("com.SerialQueue", NULL);
  
    for (int i =0;i<pathArrays.count;i++) {
        dispatch_async(unzipQueue, ^{
            NSString * zipPath=[pathArrays objectAtIndexSafe:i];
            NSString * unzipPath=[directory objectAtIndexSafe:i];
            ZipArchive * zip=[[ZipArchive alloc]init];
            zip.queueTag=i;
            zip.progressBlock=progressBlock;
            if([zip UnzipOpenFile:zipPath])
            {
                [zip UnzipFileTo:unzipPath overWrite:YES];
            }
        });
    }

}

/**
 *获取平台信息
 *@return NSString 平台信息
 */
-(NSString*)getPlatform
{
#ifdef JALBREAK_VERSION
	NSString* sid= @"iosx";
	return sid;
#else
	NSString* sid= @"ios";
	return sid;
#endif
}


/**
 *于源字符串中反向搜索目标字符串
 *@pargm target 目标字符串
 *@pargm source 源字符串
 *@return NSRange 所搜索到的目标字符串于源字符串中的位置
 */
- (NSRange)searchString:(NSString *)target from:(NSString *)source
{
    return [source rangeOfString:target options:NSBackwardsSearch];
}

/**
 *于源字符串中获得目标字符串之后的所有文字
 *@pargm target 目标字符串
 *@pargm source 源字符串
 *@return NSString 所获取的文字
 */
- (NSString *)searchBackString:(NSString *)target from:(NSString *)source
{
    NSRange range=[self searchString:target from:source];
    NSInteger rangeLoc=range.location+range.length;
    NSInteger rangeLen=source.length-rangeLoc;
   return  [source substringWithRange:NSMakeRange(rangeLoc,rangeLen)];
}

/**
 *于源字符串中获得目标字符串之前的所有文字
 @pargm target 目标字符串
 @pargm source 源字符串
 @return NSString 所获取的文字
 */
- (NSString *)searchForwardString:(NSString *)target from:(NSString *)source
{
    NSRange range=[self searchString:target from:source];
    NSInteger rangeLoc=0;
    NSInteger rangeLen=range.location;
    return  [source substringWithRange:NSMakeRange(rangeLoc,rangeLen)];
}


/**
 *将object插入数据库持久保存
 @pargm object 要插入的object
 @pargm table 表名
 @pargm key 标示名
 @return Bool 是否正确插入
 */
- (BOOL)insertObject:(NSObject *)object toTable:(NSString *)table forKey:(NSString *)key
{
    NSString * dataBasePath=[self creatDirectiory:DataBasePah];
    NSString * sqlStr=nil;
    dataBasePath=[dataBasePath stringByAppendingPathComponent:@"DataBase.db"];
    //创建数据库
    FMDatabase * db=[FMDatabase databaseWithPath:dataBasePath];
    if(![db open])
    {
        return NO;
    }
    //创建表
    if(![db tableExists:table])
    {
        sqlStr=[NSString stringWithFormat:@"create table %@(ID integer primary key autoincrement, name nvarchar(64),content BLOB)",table];
        if(![db executeUpdate:sqlStr])
        {
            NSLog(@"创建表失败");
            return NO;
        }
    }
    //插入对象
    NSData * data=[NSKeyedArchiver archivedDataWithRootObject:object];
    sqlStr=[NSString stringWithFormat:@"insert into %@ (name,content) values(?,?)",table];
    if([db executeUpdate:sqlStr,key,data])
    {
        NSLog(@"插入数据成功");
        return YES;
    }
    else
    {
        NSLog(@"插入数据失败");
        return NO;
    }

    return YES;
}

/**
 *从数据库中查找object
 @pargm table 要查找的表名
 @pargm key 唯一标识key
 @return NSArray 寻找到的相关集合
 */
-(NSArray *)searchObjectFromDataTable:(NSString *)table forKey:(NSString *)key
{
    NSMutableArray * array=[NSMutableArray array];
    NSString * dataBasePath=[self creatDirectiory:DataBasePah];
    NSString * sqlStr=[NSString stringWithFormat:@"select * from %@ where name =%@",table,key];
    dataBasePath=[dataBasePath stringByAppendingPathComponent:@"DataBase.db"];
    //创建数据库
    FMDatabase * db=[FMDatabase databaseWithPath:dataBasePath];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        return nil;
    }
    FMResultSet *rs = [db executeQuery:sqlStr];
    
    while ([rs next]) {
        NSData * data=[rs dataForColumn:@"content"];
        NSObject * obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:obj];
    }
    
    return array;
}

/**
 *从数据库中查找所有object
 @pargm table 要查找的表名
 @return NSArray 寻找到的相关集合
 */
-(NSArray *)searchObjectFromDataTable:(NSString *)table
{
    NSMutableArray * array=[NSMutableArray array];
    NSString * dataBasePath=[self creatDirectiory:DataBasePah];
    NSString * sqlStr=[NSString stringWithFormat:@"select * from %@ ",table];
    dataBasePath=[dataBasePath stringByAppendingPathComponent:@"DataBase.db"];
    //创建数据库
    FMDatabase * db=[FMDatabase databaseWithPath:dataBasePath];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        return nil;
    }
    FMResultSet *rs = [db executeQuery:sqlStr];
    
    while ([rs next]) {
        NSData * data=[rs dataForColumn:@"content"];
        NSObject * obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:obj];
    }
    
    return array;
}

/**
 *从数据库中删除相关的object
 @pargm table 要查找的表名
 @pargm key 唯一标识key
 @return Bool 是否成功删除
 */
-(BOOL)deleteObjectFromDataTable:(NSString *)table forKey:(NSString *)key;
{
    NSString * dataBasePath=[self creatDirectiory:DataBasePah];
    NSString * sqlStr=[NSString stringWithFormat:@"delete from %@ where name =%@",table,key];
    dataBasePath=[dataBasePath stringByAppendingPathComponent:@"DataBase.db"];
    //创建数据库
    FMDatabase * db=[FMDatabase databaseWithPath:dataBasePath];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    if(![db executeUpdate:sqlStr])
    {
        NSLog(@"%@数据删除失败",key);
        return NO;
    }
    else
    {
        NSLog(@"%@数据已删除",key);
        return YES;
    }
    
    return NO;
}

/**
 *从数据库中删除所有的object
 @pargm table 要查找的表名
 @return Bool 是否成功删除
 */
-(BOOL)deleteObjectFromDataTable:(NSString *)table
{
    NSString * dataBasePath=[self creatDirectiory:DataBasePah];
    NSString * sqlStr=[NSString stringWithFormat:@"delete from %@",table];
    dataBasePath=[dataBasePath stringByAppendingPathComponent:@"DataBase.db"];
    //创建数据库
    FMDatabase * db=[FMDatabase databaseWithPath:dataBasePath];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    if(![db executeUpdate:sqlStr])
    {
        NSLog(@"%@数据删除失败",table);
        return NO;
    }
    else
    {
        NSLog(@"%@数据已删除",table);
        return YES;
    }
    
    return NO;
}

/**
 *将对象归档到缓存文件夹
 @pargm object 要归档的对象
 @pargm key 归档文件的标示
 @return Bool 是否成功删除
 */
- (BOOL)insertObject:(id )object forKey:(NSString *)key
{
    NSString * filePath=[self creatDirectiory:CacheDirectory];
    filePath=[filePath stringByAppendingPathComponent:key];
    return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

/**
 *从缓存文件夹中搜索指定文件
 @pargm key 归档文件的标示
 @return id 搜索到的对象
 */
-(id)searchObjectFromArchive:(NSString *)key
{
    NSString * filePath=[self creatDirectiory:CacheDirectory];
    filePath=[filePath stringByAppendingPathComponent:key];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

/**
 *计算字符串所占大小
 @pargm str 要被计算的字符串
 @pargm font 要被计算的字符串字体
 @pargm size 限制区域
 @return CGSize 字符串大小
 */
-(CGSize)calculateStr:(NSString *)str font:(UIFont *)font size:(CGSize)size
{
    return [str sizeWithFont:font
           constrainedToSize:size
               lineBreakMode:NSLineBreakByCharWrapping];
}

/**
 *AES解密
 @pargm str 要解密的字符串
 @pargm key 解密key
 @return NSString 解密字符串
 */
-(NSString *)aesDecryp:(NSString *)str WithKey:(NSString *)key
{
    NSData * data=[GTMBase64 decodeString:str];
    data = [data AES256DecryptWithKey:key];
    NSString * value=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return value;
}

/**：
 *Base64加密
 @pargm str 要加密的字符串
 @return NSString 加密字符串
 */
-(NSString *)base64Encode:(NSString *)str
{
    NSData * data=[str dataUsingEncoding:NSUTF8StringEncoding];
    NSData * enCodeData=[GTMBase64 encodeData:data];
    NSString * value=[[NSString alloc]initWithData:enCodeData encoding:NSUTF8StringEncoding];
    return value;

}

/**
 *获取当前时间戳
 @return NSString 当前时间戳
 */
-(NSString *)getTimeStamp
{
    NSDate * date=[NSDate date];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    return timeSp;
}

/**
 *获取当前年月日
 @return NSString 当前年月日字符串
 */
-(NSString *)getCurrentYearMonthDay
{
    NSDate * date=[NSDate date];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * comps=[[NSDateComponents alloc]init];
    NSInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    comps=[calendar components:unitFlags fromDate:date];
    int year=(int)[comps year];
    int month=(int)[comps month];
    int day=(int)[comps day];
    NSString * dateStr=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    return dateStr;
}
@end
