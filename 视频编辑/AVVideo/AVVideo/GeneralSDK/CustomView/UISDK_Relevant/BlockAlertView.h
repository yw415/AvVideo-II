//
//  BlockAlertView.h
//  GeneralFrame
//
//  Created by user on 14-4-20.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ConfirmBlock)(void);
typedef void (^ConcelBlock)(void);
@interface BlockAlertView : UIAlertView<UIAlertViewDelegate>
@property(nonatomic,copy)ConfirmBlock confirmBlock;
@property(nonatomic,copy)ConcelBlock concelBlock;
-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
        confirmStr:(NSString *)confirmStr
      confirmBlock:(ConfirmBlock )confirmBlock
         concelStr:(NSString *)concelStr
       concelBlock:(ConcelBlock )concelBlock
     singleOrMulti:(BOOL)singleOrMulti;

@end
