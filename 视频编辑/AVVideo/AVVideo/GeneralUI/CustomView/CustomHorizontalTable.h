//
//  CustomHorizontalTable.h
//  AVVideoExample
//
//  Created by user on 14-9-5.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomHorizontalTableDelegate <NSObject>
-(int)itemCount;
-(float)itemMargin;
-(UIView *)itemView:(int)index;
-(void)selectedItem:(UIView *)selectedView index:(int)selectedIndex;
@end

@interface CustomHorizontalTable : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,assign)id<CustomHorizontalTableDelegate>delegate;
//根据数据配置各项
-(void)reloadData;
@end
