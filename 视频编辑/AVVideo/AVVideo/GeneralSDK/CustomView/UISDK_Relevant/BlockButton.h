//
//  BlockButton.h
//  GeneralFrame
//
//  Created by user on 14-4-17.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  BlockButton;
typedef void (^TouchButton)(BlockButton *);
@interface BlockButton : UIButton
@property(nonatomic,copy)TouchButton block;
@property(nonatomic,assign)BOOL underLine;
@end
