//
//  InputChecker.m
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "InputChecker.h"

@implementation InputChecker

+ (BOOL)isInputANumber:(NSString *)string
{
    if ((!string) || ([string length] == 0)) {
        return NO;
    }
    
    char c;
    
    for (int i = 0; i < [string length]; i ++) {
        c = [string characterAtIndex:i];
        
        if ((c < '0') || (c > '9')) {
            return NO;
        }
    }
    
    return YES;
}

+ (NSString *)errorTitleWhenStringIsNotANumber
{
    return @"エラー";
}

+ (NSString *)errorMessageWhenStringIsNotANumber
{
    return @"数字を入力してください";
}

@end
