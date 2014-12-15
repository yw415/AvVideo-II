//
//  TestViewController.m
//  AVVideo
//
//  Created by user on 14-12-14.
//  Copyright (c) 2014年 ios. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGRect rect=CGRectMake(10, 10, 50, 50);
    [[UISDK Instance]addButton:rect title:@"Test" color:[UIColor redColor] hcolor:nil font:nil bgImg:nil selImg:nil block:^(UIButton *but) {
        
    } view:self.view];
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 预览开始
    self.view.layer.borderWidth=3;
    self.view.layer.borderColor=[UIColor redColor].CGColor;
}

@end
