//
//  BlockMAlertView.h
//  AVVideoExample
//
//  Created by user on 14-9-10.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BlockMAlertViewConfirmBlock)(int tag);
typedef void (^BlockMAlertViewCancelBlock)();
@interface BlockMAlertView : UIAlertView<UIAlertViewDelegate>
@property(nonatomic,copy)BlockMAlertViewConfirmBlock confirmBlock;
@property(nonatomic,copy)BlockMAlertViewCancelBlock cancelBlock;
-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
       cancelTitle:(NSString *)cancelTitle
       cancelBlock:(void(^)(void))cancelBlock
      confirmBlock:(BlockMAlertViewConfirmBlock )confirmBlock
          butTitle:(NSArray *)butTitles;
@end
