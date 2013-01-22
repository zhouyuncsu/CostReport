//
//  InputChecker.h
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputChecker : NSObject

+ (BOOL)isInputANumber:(NSString *)string;
+ (NSString *)errorTitleWhenStringIsNotANumber;
+ (NSString *)errorMessageWhenStringIsNotANumber;

@end
