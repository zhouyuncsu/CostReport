//
//  InsertViewController.h
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *costTypePickerView;

- (IBAction)costGoButtonPushed:(id)sender;
- (IBAction)insertFinishedButtonPushed:(id)sender;

@end
