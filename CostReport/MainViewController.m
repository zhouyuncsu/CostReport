//
//  MainViewController.m
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "MainViewController.h"

#import "CommonUtilsHeader.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    DebugLogFunc();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DebugLogFunc();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DebugLogFunc();
}

@end
