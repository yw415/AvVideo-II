//
//  UtilitySDK.h
//  GeneralFrame
//
//  Created by user on 14-4-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
///功能SDK 包含一些开发中常用的操作
@interface UtilitySDK : NSObject
///单例方法
+(UtilitySDK *)Instance;
///获取设备号
-(NSString *)get_imei;
///获取设备信息
- (NSString*) get_ua;


/**
 *获取工程中html文件中的html文本内容
 *@pargm fileName 相关文件名 如 aaa.html
 *@return Nsstring html文件中所包含的html文本
*/
- (NSString *)getHtmlFileContent:(NSString *) fileName;

/**
 *通过谓词与正则进行验证
 *@pargm regex 正则表达式
 *@pargm str 要匹配的文本
 *@return BOOL 文本是否匹配正则
*/
-(BOOL)validateRegex:(NSString *)regex str:(NSString *)str;

/**
 *根据色值构造图片
 *@pargm color 颜色
 *@pargm rect 图片大小
 *@return UIImage 构造的图片
*/
-(UIImage *)getImageFromColor:(UIColor *)color rect:(CGRect)rect;

/**
 *截屏
 *@pargm view 要截屏的view
 *@return UIImage 截取的图片
*/
-(UIImage *)capture :(UIView *)view;

/**
 *创建文件夹
 *@pargm directory 要创建的文件夹名称
 *@return NSString 所创建的文件夹的绝对路径
*/
-(NSString *)creatDirectiory :(NSString *)directory;

/**
 *获取文件夹大小
 *@pargm directory 所要查看的文件夹
 *@return CGFloat 文件夹大小
*/
-(CGFloat)getDirectiorySize:(NSString *)directory;

/**
 *获取文件夹下的所有文件名
 *@pargm directory 所要查看的文件夹
 *@return NSArray 文件夹名集合
*/
-(NSArray *)getFilesInDirectory:(NSString *)directory;

/**
 *删除已有文件
 *@pargm filePath 所要删除的文件
 *@return Bool 是否成功删除
 */
-(BOOL)deleteFile:(NSString *)filePath;

/**
 *删除已有文件夹
 *@pargm directory 所要删除的文件夹
 *@return Bool 是否成功删除
*/
-(BOOL)deleteDirectory:(NSString *)directory;

/**：
 *判断文件是否已存在
 *@pargm fileName 文件名
 *@pargm directory 文件夹名
 *@return Bool 是否存在
 */
-(BOOL)fileHaveExist:(NSString*)fileName atDirectory:(NSString *)directory;

/**
 *判断文件夹是否已存在：
 *@pargm directory 文件夹名
 *@return Bool 是否存在
 */
-(BOOL)directoryHaveExist:(NSString *)directory;

/**
 *将已有文件拷贝进指定路径：
 *@pargm filePath 已有文件路径
 *@pargm savePath 保存文件路径
 *@return Bool 是否成功
 */
-(BOOL)saveFile:(NSString *)filePath
     toSavePath:(NSString *)savePath;

/**
 *解压zip包到指定的文件夹
 *@pargm pathArrays 解压缩文件存法路径结合
 *@pargm directory 解压至的文件夹
 *@pargm progressBlock 解压缩进度回调块
 */
-(void)unzipFile:(NSArray*)pathArrays
       directory:(NSArray *)directory
   progressBlock:(void(^)(int percentage, int filesProcessed, unsigned long numFiles,NSInteger queueTag))progressBlock;

/**
 *获取平台信息
 *@return NSString 平台信息
*/
- (NSString*)getPlatform;

/**
 *于源字符串中反向搜索目标字符串
 *@pargm target 目标字符串
 *@pargm source 源字符串
 *@return NSRange 所搜索到的目标字符串于源字符串中的位置
 */
- (NSRange)searchString:(NSString *)target from:(NSString *)source;

/**
 *于源字符串中获得目标字符串之后的所有文字
 *@pargm target 目标字符串
 *@pargm source 源字符串
 *@return NSString 所获取的文字
*/
- (NSString *)searchBackString:(NSString *)target from:(NSString *)source;

/**
 *于源字符串中获得目标字符串之前的所有文字
 @pargm target 目标字符串
 @pargm source 源字符串
 @return NSString 所获取的文字
*/
- (NSString *)searchForwardString:(NSString *)target from:(NSString *)source;

/**
 *将object插入数据库持久保存
 @pargm object 要插入的object
 @pargm table 表名
 @pargm key 标示名
 @return Bool 是否正确插入
 */
- (BOOL)insertObject:(NSObject *)object toTable:(NSString *)table forKey:(NSString *)key;

/**
 *从数据库中查找object
 @pargm table 要查找的表名
 @pargm key 唯一标识key
 @return NSArray 寻找到的相关集合
 */
-(NSArray *)searchObjectFromDataTable:(NSString *)table forKey:(NSString *)key;

/**
 *从数据库中查找所有object
 @pargm table 要查找的表名
 @return NSArray 寻找到的相关集合
 */
-(NSArray *)searchObjectFromDataTable:(NSString *)table;

/**
 *从数据库中删除相关的object
 @pargm table 要查找的表名
 @pargm key 唯一标识key
 @return Bool 是否成功删除
 */
-(BOOL)deleteObjectFromDataTable:(NSString *)table forKey:(NSString *)key;

/**
 *从数据库中删除所有的object
 @pargm table 要查找的表名
 @return Bool 是否成功删除
 */
-(BOOL)deleteObjectFromDataTable:(NSString *)table;

/**
 *将对象归档到缓存文件夹
 @pargm object 要归档的对象
 @pargm key 归档文件的标示
 @return Bool 是否成功删除
*/
- (BOOL)insertObject:(id)object forKey:(NSString *)key;

/**
 *从缓存文件夹中搜索指定文件
 @pargm key 归档文件的标示
 @return id 搜索到的对象
 */
-(id)searchObjectFromArchive:(NSString *)key;

/**
 *计算字符串所占大小
 @pargm str 要被计算的字符串
 @pargm font 要被计算的字符串字体
 @pargm size 限制区域
 @return CGSize 字符串大小
 */
-(CGSize)calculateStr:(NSString *)str font:(UIFont *)font size:(CGSize)size;

/**
  *AES解密
  @pargm str 要解密的字符串
  @pargm key 解密key
  @return NSString 解密字符串
 */
-(NSString *)aesDecryp:(NSString *)str WithKey:(NSString *)key;

/**
 *Base64加密
 @pargm str 要加密的字符串
 @return NSString 加密字符串
*/
-(NSString *)base64Encode:(NSString *)str;

/**
 *获取当前时间戳
 @return NSString 当前时间戳
*/
-(NSString *)getTimeStamp;

/**
 *获取当前年月日
 @return NSString 当前年月日字符串
 */
-(NSString *)getCurrentYearMonthDay;
@end
