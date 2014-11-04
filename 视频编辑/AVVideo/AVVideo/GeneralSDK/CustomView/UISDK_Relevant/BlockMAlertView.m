//
//  BlockMAlertView.m
//  AVVideoExample
//
//  Created by user on 14-9-10.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "BlockMAlertView.h"

@implementation BlockMAlertView

#define D_INITWITHTITLE()

-(id)initWithTitle:(NSString *)title
           message:(NSString *)message
       cancelTitle:(NSString *)cancelTitle
       cancelBlock:(void(^)(void))cancelBlock
      confirmBlock:(BlockMAlertViewConfirmBlock )confirmBlock
          butTitle:(NSArray *)butTitles

{
    

    self=[super initWithTitle:title
                      message:message
                     delegate:self
            cancelButtonTitle:cancelTitle
            otherButtonTitles:nil];

    for(NSString * title in butTitles)
    {
        [self addButtonWithTitle:title];
    }
    
    if(self)
    {
        self.confirmBlock=confirmBlock;
        self.cancelBlock=cancelBlock;
    }
    
    
    return self;
}

#pragma mark - AlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if(self.cancelBlock)
        {
            self.cancelBlock();
        }
    }
    else
    {
        if(self.confirmBlock)
        {
            self.confirmBlock((int)buttonIndex);
        }
    }
}

-(void)dealloc
{
    self.confirmBlock=nil;
    self.cancelBlock=nil;
}




@end
