//
//  BlockButton.m
//  GeneralFrame
//
//  Created by user on 14-4-17.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "BlockButton.h"
#import <QuartzCore/QuartzCore.h>
@interface BlockButton()
@property(nonatomic,assign)BOOL isSelected;
@end

@implementation BlockButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.isSelected=NO;

        [self setExclusiveTouch:YES];
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchAction:(id)sender{
    
    if(self.block)
    {
        self.block(self);
    }
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if(self.underLine)
    {
        UIColor * color=self.titleLabel.textColor;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineWidth(context, 1.0f);
        CGContextMoveToPoint(context, 0, self.bounds.size.height - 1);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - 1);
        CGContextStrokePath(context);
    }

    [super drawRect:rect];
}

-(void)dealloc
{
    self.block=nil;
}
@end
