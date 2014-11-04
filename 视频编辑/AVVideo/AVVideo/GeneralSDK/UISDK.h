//
//  UISDK.h
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
///此API负责所有UI相关操作
@interface UISDK : NSObject

///单例
+(UISDK *)Instance;

/**
  *获取图片,以便有特殊需求时可以统一修改 比如日夜间模式切换
  *@pargm path 相关图片路径
  *@return UIImage 根据路径所获取到的相关图片
*/
-(UIImage *)getImg:(NSString *)path;

/**
 *获取大量重用图片,以imageNamed获取 通过苹果内部缓存优化 不适合用于大图片 否则会有泄漏
 *@pargm path 相关图片路径
 *@return UIImage 根据路径所获取到的相关图片
 */
-(UIImage *)getMImg:(NSString *)path;

/**
  *添加标签文字
  *@pargm rect 标签所在位置以及大小
  *@pargm font 标签使用的字体
  *@pargm color 标签使用的文字颜色
  *@pargm text 标签呈现的文字
  *@pargm alignment 标签的对齐方式
  *@pargm view 标签所要添加到的视图
  *@return UILabel 所构建的标签
*/
-(UILabel *)addLabel:(CGRect) rect
           font:(UIFont *) font
          color:(UIColor *)color
           text:(NSString *)text
      alignment:(NSTextAlignment) alignment
           view:(UIView *)view;

/**：
  *显示等待框
  *@pargm str 等待框所要显示的文字
  *@pargm view 要添加等待框的视图
*/
-(void)showWait:(NSString *)str view:(UIView *)view;

/**
  *隐藏等待框
  *@pargm view 等待框所在的视图
*/
-(void)hideWait:(UIView *)view;

/**
  *显示文字提示框
  *@pargm str 提示框所要显示的文字
  *@pargm view 提示框所在的视图
*/
-(void)showTextHud:(NSString *)str view:(UIView *)view;

/**
 *构造文本视图textView
 *@pargm rect 视图大小
 *@pargm view textView父视图
 *@pargm delegate textView委托
 *@return UITextView 所构建的文本视图
 */
-(UITextView *)addTextView:(CGRect)rect view:(UIView *)view delegate:(id)delegate;

/**
  *构造导航栏文字按钮
  *@pargm text 导航栏按钮所要显示的文字
  *@pargm block 点击事件
  *@return UIBarButtonItem 导航栏上的按钮
*/
-(UIBarButtonItem *)textBarButton:(NSString *)text block:(void(^)(UIButton *))block;

/**
 *构造导航栏图片按钮
 *@pargm bgImg 导航栏按钮背景图片
 *@pargm selImg 导航栏按钮高亮背景图片
 *@pargm text 导航栏按钮所要显示的文字
 *@pargm block 点击事件
 *@pargm leftOrRight 按钮在左边还是右边
 *@return UIBarButtonItem 导航栏上的按钮
 */
-(UIBarButtonItem *)imgBarButton:(UIImage *)bgImg
                          selImg:(UIImage *)selImg
                            text:(NSString *)text
                           block:(void(^)(UIButton * but))block
                     leftOrRight:(int)leftOrRight;


/**
 *构造背景块
 *@pargm img 背景图片
 *@pargm rect 位置大小
 *@pargm view 背景块父视图
 *@return UIImageView 所构造的imgView
 */
-(UIImageView *)addBackGround:(UIImage *)img rect:(CGRect)rect view:(UIView *)view;

/**
  *构造文字输入框
  *@pargm rect 位置大小
  *@pargm delegate 相关委托对象
  *@pargm text 输入框中要显示的默认值
  *@pargm font 文本字体
  *@pargm secure 是否输入密码
  *@pargm view 输入框父视图
  *@return UITetField 构造的文字框指针
*/
-(UITextField *)addTextField:(CGRect)rect
                    delegate:(id)delegate
                        text:(NSString *)text
                        font:(UIFont *) font
                      secure:(BOOL) secure
                        view:(UIView *)view;

/**
 *构造按钮
 *@pargm rect 位置大小
 *@pargm title 按钮标题
 *@pargm color 按钮标题颜色
 *@pargm hcolor 按钮标题高亮颜色
 *@pargm font 标题字体
 *@pargm bgImg 按钮背景
 *@pargm selImg 按钮点击背景
 *@pargm block 点击后执行事件
 *@pargm view 按钮父视图
 *@return UIButton 构造的按钮指针
*/
-(UIButton *)addButton:(CGRect)rect
           title:(NSString *) title
           color:(UIColor *)color
          hcolor:(UIColor *)hcolor
            font:(UIFont *)font
           bgImg:(UIImage *)bgimg
          selImg:(UIImage *)selImg
           block:(void(^)(UIButton * but))block
            view:(UIView *)view;

/**
 *构造文字按钮
 *@pargm rect 位置大小
 *@pargm title 按钮标题
 *@pargm color 按钮标题颜色
 *@pargm hcolor 按钮标题高亮颜色
 *@pargm font 标题字体
 *@pargm underLine 是否带下划线
 *@pargm block 点击后执行事件
 *@pargm view 按钮父视图
*/
-(void)addTextButton:(CGRect)rect
               title:(NSString *) title
               color:(UIColor *)color
              hcolor:(UIColor *)hcolor
                font:(UIFont *)font
           underLine:(BOOL)underLine
               block:(void(^)(UIButton * but))block
                view:(UIView *)view;

/**
 *构造确认取消提示框
 *@pargm title 标题文本
 *@pargm message 提示内容
 *@pargm confrimStr 确认按钮文本
 *@pargm confirmBlock 确认块
 *@pargm concel 取消按钮文本
 *@pargm concelBlock 取消块
 *@pargm singleOrMulti 单个按钮还是多个按钮
 *@return UIAlertView 构造的UIAlertView指针
*/
-(UIAlertView *)showAlert:(NSString *)title
         message:(NSString *)message
      confirmStr:(NSString *)confirmStr
    confirmBlock:(void(^)(void))confirmBlock
       concelStr:(NSString *)concelStr
     concelBlock:(void(^)(void))concelBlock
   singleOrMulti:(BOOL)singleOrMulti;

/**
 *构造多按钮提示框
 *@pargm title 标题文本
 *@pargm message 提示内容
 *@pargm cancelTitle 取消文本
 *@pargm cancelBlock 取消回调
 *@pargm confirmBlock 确认回调
 *@pargm butTitles 按钮标题
 */
-(UIAlertView *)showMAlert:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
               cancelBlock:(void(^)(void))cancelBlock
              confirmBlock:(void(^)(int tag))confirmBlock
                 butTitles:(NSArray *) titles;

/**
 *调用CoreGraph函数绘制圆形
 *@pargm rect 圆的尺寸
 *@pargm ctx 图形上下文
 *@pargm borderColor 圆的边框颜色
 *@pargm backGroundColor 圆的填充颜色
*/
-(void)drawCircle:(CGRect)rect
          context:(CGContextRef)ctx
      borderColor:(UIColor *)borderColor
  backGroundColor:(UIColor *)backGroundColor;

@end
