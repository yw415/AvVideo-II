//
//  UISDK.m
//  GeneralFrame
//
//  Created by user on 14-4-11.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "UISDK.h"
#import "MBProgressHUD.h"
#import "BlockButton.h"
#import "BlockAlertView.h"
#import "BlockMAlertView.h"
#import "UtilitySDK.h"
@implementation UISDK
///初始化
-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

///单例
+(UISDK *)Instance
{
    static UISDK * instance=nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    
    return instance;
}

/**
 *获取图片,以便有特殊需求时可以统一修改 比如日夜间模式切换
 *@pargm path 相关图片路径
 *@return UIImage 根据路径所获取到的相关图片
 */
-(UIImage *)getImg:(NSString *)path
{
    NSString * bundlePath=[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]bundlePath],path];
    UIImage * img=[UIImage imageWithContentsOfFile:bundlePath];
    return img;
}

/**
 *获取大量重用图片,以imageNamed获取 通过苹果内部缓存优化 不适合用于大图片 否则会有泄漏
 *@pargm path 相关图片路径
 *@return UIImage 根据路径所获取到的相关图片
 */
-(UIImage *)getMImg:(NSString *)path
{
    UIImage * img=[UIImage imageNamed:path];
    return img;
}

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
           view:(UIView *)view
{
    UILabel * label=[[UILabel alloc]initWithFrame:rect];
    label.font=font;
    label.textAlignment=alignment;
    label.text=text;
    label.numberOfLines=0;

    [label setTextColor:color];
    label.backgroundColor=[UIColor clearColor];
    if(view)
    {
        [view addSubview:label];
    }

    return label;
}


/**：
 *显示等待框
 *@pargm str 等待框所要显示的文字
 *@pargm view 要添加等待框的视图
 */
-(void)showWait:(NSString *)str view:(UIView *)view
{
    MBProgressHUD * hud=[[MBProgressHUD alloc]initWithView:view];
    [view addSubview:hud];
    hud.labelText=str;
    [hud show:YES];
}

/**
 *隐藏等待框
 *@pargm view 等待框所在的视图
 */
-(void)hideWait:(UIView *)view
{
    MBProgressHUD * hud;
    for(UIView * subView in view.subviews)
    {
        if([subView class]==[MBProgressHUD class])
        {
            hud=(MBProgressHUD *)subView;
        
        }
    }
    [hud hide:YES];
    [hud removeFromSuperview];
    
}

/**
 *显示文字提示框
 *@pargm str 提示框所要显示的文字
 *@pargm view 提示框所在的视图
 */
-(void)showTextHud:(NSString *)str view:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = str;
	hud.margin = 20.f;
	hud.yOffset = 10.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:1.8];
}

/**
 *构造文本视图textView
 *@pargm rect 视图大小
 *@pargm view textView父视图
 *@pargm delegate textView委托
 *@return UITextView 所构建的文本视图
 */
-(UITextView *)addTextView:(CGRect)rect view:(UIView *)view delegate:(id)delegate
{
    UITextView * textView=[[UITextView alloc]initWithFrame:rect];
    textView.backgroundColor=[UIColor clearColor];
    textView.delegate=delegate;
    [view addSubview:textView];
    return textView;
}

/**
 *构造导航栏文字按钮
 *@pargm text 导航栏按钮所要显示的文字
 *@pargm block 点击事件
 *@return UIBarButtonItem 导航栏上的按钮
 */
-(UIBarButtonItem *)textBarButton:(NSString *)text block:(void(^)(UIButton *))block
{
    BlockButton * button=[BlockButton buttonWithType:UIButtonTypeCustom];
   
    UIFont * font=[UIFont systemFontOfSize:13.0];
    button.layer.borderWidth=1;
    button.layer.borderColor=[UIColor blackColor].CGColor;
    button.layer.cornerRadius=7;
    button.titleLabel.font=font;
    button.block=block;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    
   
    CGSize size= [text sizeWithFont:font];
    //ios6与7导航按钮左边距不相同 故统一处理 在ios6中截图重新编辑
    if(!IOS7_OR_LATER)
    {
        [button setFrame:CGRectMake(10, 10, size.width+30, 22)];
        CGRect bounds=button.bounds;
        bounds.size.width+=15;
        UIGraphicsBeginImageContextWithOptions(bounds.size, button.opaque, 0.0);
        [button.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * img=UIGraphicsGetImageFromCurrentImageContext();
        [button setBackgroundImage:img forState:UIControlStateNormal];
        button.layer.borderWidth=0;
        UIGraphicsEndImageContext();
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        [button setFrame:CGRectMake(10, 10, size.width+15, 24)];
       
    }
    UIBarButtonItem * barBut=[[UIBarButtonItem alloc]initWithCustomView:button];
    return barBut;
}

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
                     leftOrRight:(int)leftOrRight
{
    BlockButton * button=[BlockButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10, 10, 33, 24)];
    [button setImage:bgImg forState:UIControlStateNormal];
    [button setImage:selImg forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    if(leftOrRight==0)
    {
        if(IOS7_OR_LATER)
        {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        }
        else
        {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        }
    }
    else
    {
        if(IOS7_OR_LATER)
        {
             [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        }
        else
        {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        }
    }
    
    button.titleLabel.font=[UIFont systemFontOfSize:8.0];
    button.block=block;
    UIBarButtonItem * barBut=[[UIBarButtonItem alloc]initWithCustomView:button];
    return barBut;
}

/**
 *构造背景块
 *@pargm img 背景图片
 *@pargm rect 位置大小
 *@pargm view 背景块父视图
 *@return UIImageView 所构造的imgView
 */
-(UIImageView *)addBackGround:(UIImage *)img rect:(CGRect)rect view:(UIView *)view
{
    UIImageView * imgView=[[UIImageView alloc]initWithFrame:rect];
    
    if(img)
    {
        imgView.image=img;
    }
    else
    {
    
        imgView.layer.borderColor=[[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]CGColor];
        imgView.layer.borderWidth=1;
        imgView.layer.cornerRadius=8.0;
        imgView.backgroundColor=[UIColor whiteColor];
    }
    
    [view addSubview:imgView];
    
    return imgView;
}

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
               view:(UIView *)view
{
    UITextField * textField=[[UITextField alloc]initWithFrame:rect];
    textField.placeholder=text;
    textField.delegate=delegate;
    textField.font=font;
    textField.secureTextEntry=secure;
    [view addSubview:textField];
    return textField;
}


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
           block:(void(^)(UIButton *))block
            view:(UIView *)view
{
    BlockButton * button=[BlockButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:hcolor forState:UIControlStateHighlighted];
    if(bgimg)
    {
        [button setBackgroundImage:bgimg forState:UIControlStateNormal];
        [button setBackgroundImage:selImg forState:UIControlStateHighlighted];
    }
    else
    {
        button.layer.borderWidth=1;
        button.layer.borderColor=[[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
        button.layer.cornerRadius=8.0;
        button.layer.masksToBounds=YES;
        [button setAdjustsImageWhenHighlighted:NO];
        UIColor * color=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        UIImage * img=[[UtilitySDK Instance]getImageFromColor:color rect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setBackgroundImage:img forState:UIControlStateHighlighted];
        
    }
    button.titleLabel.font=font;
    button.block=block;
    [view addSubview:button];
    return button;
}

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
                view:(UIView *)view
{
    BlockButton * button=[BlockButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:hcolor forState:UIControlStateHighlighted];
    if(underLine)
    {
        button.underLine=YES;
    }
    else
    {
        button.underLine=NO;
    }
    button.titleLabel.font=font;
    button.block=block;
    [view addSubview:button];
}

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

{
    
    BlockAlertView * blockAlertView=[[BlockAlertView alloc]initWithTitle:title
                                                                 message:message
                                                              confirmStr:confirmStr
                                                            confirmBlock:confirmBlock
                                                             concelStr:concelStr
                                                             concelBlock:concelBlock
                                                             singleOrMulti:singleOrMulti];
    [blockAlertView show];
    return blockAlertView;
}

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
                 butTitles:(NSArray *) titles
{
    
    BlockMAlertView * blockAlertView=[[BlockMAlertView alloc]initWithTitle:title
                                                                   message:message
                                                               cancelTitle:cancelTitle
                                                               cancelBlock:cancelBlock
                                                              confirmBlock:confirmBlock
                                                                  butTitle:titles];
    [blockAlertView show];
    return blockAlertView;
}


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
  backGroundColor:(UIColor *)backGroundColor
{
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, backGroundColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
}


@end
