//
//  InsertViewController.m
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "InsertViewController.h"

#import "CommonUtilsHeader.h"
#import "InputChecker.h"
#import "CostType.h"
#import "Cost.h"
#import "CostManager.h"

@interface InsertViewController ()

@property (nonatomic) CostType *manager;
@property (nonatomic) UIAlertView *numberCheckerAlertView;
@property (nonatomic) UIAlertView *continueToInsertAlertView;

@end

@implementation InsertViewController

@synthesize costTextField;
@synthesize costTypePickerView;
@synthesize numberCheckerAlertView;
@synthesize continueToInsertAlertView;

@synthesize manager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    DebugLogFunc();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DebugLogFunc();
    
    if (!manager) {
        manager = [CostType sharedManager];
    }
    
    [costTypePickerView setDelegate:self];
    [costTypePickerView setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    DebugLogFunc();
    
    manager = nil;
}

- (IBAction)costGoButtonPushed:(id)sender {
    DebugLogFunc();
    
    if (![InputChecker isInputANumber:costTextField.text]) {
        numberCheckerAlertView = [[UIAlertView alloc] initWithTitle:[InputChecker errorTitleWhenStringIsNotANumber]
                                                            message:[InputChecker errorMessageWhenStringIsNotANumber]
                                                           delegate:self
                                                  cancelButtonTitle:@"分かりました"
                                                  otherButtonTitles:nil];
        [numberCheckerAlertView show];
    } else {
        [costTextField resignFirstResponder];
    }
}

- (IBAction)insertFinishedButtonPushed:(id)sender {
    DebugLogFunc();
    
    if (![InputChecker isInputANumber:costTextField.text]) {
        numberCheckerAlertView = [[UIAlertView alloc] initWithTitle:[InputChecker errorTitleWhenStringIsNotANumber]
                                                            message:[InputChecker errorMessageWhenStringIsNotANumber]
                                                           delegate:self
                                                  cancelButtonTitle:@"分かりました"
                                                  otherButtonTitles:nil];
        [numberCheckerAlertView show];
    } else {
        NSInteger selectedRow = [costTypePickerView selectedRowInComponent:0];
        NSString * costType = [[manager getCostTypes] objectAtIndex:selectedRow];
        
        Cost *cost = [[Cost alloc] initWithCost:costTextField.text costType:costType];
        DebugLog(@"year = %@\n", [cost getYearOfCost]);
        DebugLog(@"month = %@\n", [cost getMonthOfCost]);
        DebugLog(@"day = %@\n", [cost getDayOfCost]);
        
        CostManager *costManager = [CostManager sharedManager];
        [costManager insert:cost];
        
        costTextField.text = @"";
        
        continueToInsertAlertView = [[UIAlertView alloc] initWithTitle:@"入力完了"
                                                            message:@"どうします？"
                                                           delegate:self
                                                  cancelButtonTitle:@"戻る"
                                                  otherButtonTitles:@"継続入力", nil];
        [continueToInsertAlertView show];
    }
    
    
}

#pragma mark - alertview

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DebugLogFunc();
    
    if (alertView == numberCheckerAlertView) {
        if (buttonIndex == 0) {
            costTextField.text = @"";
            [costTextField becomeFirstResponder];
        }
    } else if (alertView == continueToInsertAlertView) {
        if (buttonIndex == 0) {
            //戻る
            [self.navigationController popViewControllerAnimated:YES];
        } else if (buttonIndex == 1) {
            //継続入力
            [costTextField becomeFirstResponder];
        }
    }
}

#pragma mark - pickerview

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [[manager getCostTypes] count];
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [[manager getCostTypes] objectAtIndex:row];
    } else {
        return nil;
    }
}

@end
