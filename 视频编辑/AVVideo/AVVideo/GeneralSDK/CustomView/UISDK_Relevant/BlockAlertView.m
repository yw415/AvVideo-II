//
//  BlockAlertView.m
//  GeneralFrame
//
//  Created by user on 14-4-20.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "BlockAlertView.h"

@implementation BlockAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
        confirmStr:(NSString *)confirmStr
      confirmBlock:(ConfirmBlock )confirmBlock
         concelStr:(NSString *)concelStr
       concelBlock:(ConcelBlock )concelBlock
     singleOrMulti:(BOOL)singleOrMulti
{
   if(singleOrMulti)
   {
       if(confirmStr)
       {
            self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:confirmStr otherButtonTitles:nil];
       }
       else
       {
            self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
       }
       
   }
   else
   {
       if(confirmStr&&concelStr)
       {
          self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:confirmStr otherButtonTitles:concelStr, nil];
       }
       else
       {
          self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
       }
       
   }
 
   if(self)
   {
       self.confirmBlock=confirmBlock;
       self.concelBlock=concelBlock;
   }

    return self;
}

#pragma mark - AlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
       if(self.confirmBlock)
       {
           self.confirmBlock();
       }
    }
    else
    {
        if(self.concelBlock)
        {
            self.concelBlock();
        }
    }
}

-(void)dealloc
{
    self.confirmBlock=nil;
    self.concelBlock=nil;
}

@end
