//
//  CustomToolBar.h
//  AVVideoExample
//
//  Created by user on 14-9-4.
//  Copyright (c) 2014年 ios. All rights reserved.
//

@protocol CustomToolBarDelegate <NSObject>
-(int)itemCount;
-(UIView *)itemView:(int)index;
-(void)selectedItem:(UIView *)selectedView index:(int)selectedIndex;
@optional
-(void)unselectedItem:(UIView *)unselectedView index:(int)unselectedIndex;
@end

#import <UIKit/UIKit.h>
@interface CustomToolBar : UIView
-(void)reloadData;
-(void)selectedItem:(int)index;
@property(nonatomic,assign)id<CustomToolBarDelegate>delegate;
@end
