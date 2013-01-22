//
//  Cost.m
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "Cost.h"

#import "CommonUtilsHeader.h"
#import "InputChecker.h"

@interface Cost ()

@property (nonatomic) NSMutableArray *costArray;

@end

@implementation Cost

#define CostDateFormat      @"yyyy年MM月dd日HH時mm分ss秒"
#define CostDateYearRange   NSMakeRange(0, 4)
#define CostDateMonthRange  NSMakeRange(5, 2)
#define CostDateDayRange    NSMakeRange(8, 2)
#define CostDateHourRange   NSMakeRange(11, 2)
#define CostDateMinuteRange NSMakeRange(14, 2)
#define CostDateSecondRange NSMakeRange(17, 2)

typedef enum {
    CostArrayIndexCost,
    CostArrayIndexCostType,
    CostArrayIndexCostDate
} CostArrayIndex;

@synthesize costArray;

- (id)initWithCost:(NSString *)cost costType:(NSString *)costType
{
    return [self initWithCost:cost costType:costType date:[NSDate date]];
}

- (void)setCost:(NSString *)cost
{
    [costArray replaceObjectAtIndex:CostArrayIndexCost withObject:cost];
}

- (void)setCostType:(NSString *)costType
{
    [costArray replaceObjectAtIndex:CostArrayIndexCostType withObject:costType];
}

- (NSString *)getCost
{
    return [costArray objectAtIndex:CostArrayIndexCost];
}

- (NSString *)getCostType
{
    return [costArray objectAtIndex:CostArrayIndexCostType];
}

- (NSString *)getYearOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateYearRange];
}

- (NSString *)getMonthOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateMonthRange];
}

- (NSString *)getDayOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateDayRange];
}

- (NSString *)getHourOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateHourRange];
}

- (NSString *)getMinuteOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateMinuteRange];
}

- (NSString *)getSecondOfCost
{
    NSString *dateString = [costArray objectAtIndex:CostArrayIndexCostDate];
    
    return [dateString substringWithRange:CostDateSecondRange];
}

- (NSString *)getDateFormatString
{
    return CostDateFormat;
}

#pragma mark - cost utils

+ (NSString *)getYear:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSString *dateString = [Cost getStringFromDate:date];
    
    return [dateString substringWithRange:CostDateYearRange];
}

+ (NSString *)getMonth:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSString *dateString = [Cost getStringFromDate:date];
    
    return [dateString substringWithRange:CostDateMonthRange];
}

+ (NSString *)getDay:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSString *dateString = [Cost getStringFromDate:date];
    
    return [dateString substringWithRange:CostDateDayRange];
}

- (NSString *)forSave
{
    return [NSString stringWithFormat:@"%@_%@_%@年%@月%@日%@時%@分%@秒", [costArray objectAtIndex:CostArrayIndexCost], [costArray objectAtIndex:CostArrayIndexCostType], [self getYearOfCost], [self getMonthOfCost], [self getDayOfCost], [self getHourOfCost], [self getMinuteOfCost], [self getSecondOfCost]];
}

- (NSString *)description
{
    return [self forSave];
}

+ (Cost *)getCostFromSaveString:(NSString *)saveString
{
    DebugLogFunc();
    
    if ((!saveString) || ([saveString length] == 0)) {
        DebugLogNSString(@"saveStringがnil、若しくは、lengthが0");
        return nil;
    }
    
    NSArray* array = [saveString componentsSeparatedByString:@"_"];
    if ((!array) || ([array count] != 3)) {
        DebugLogNSString(@"_で分解されたメンバーは8ではない、若しくは、分解失敗");
        return nil;
    }
    
    NSString *cost = [array objectAtIndex:CostArrayIndexCost];
    NSString *costType = [array objectAtIndex:CostArrayIndexCostType];
    NSMutableString *dateString = [array objectAtIndex:CostArrayIndexCostDate];
    
    Cost *costObject = [[Cost alloc] initWithCost:cost costType:costType dateString:dateString];
    
    return costObject;
}

#pragma mark - private function

+ (NSString * )getStringFromDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:CostDateFormat];
    return [formatter stringFromDate:date];
}

- (id)initWithCost:(NSString *)cost costType:(NSString *)costType date:(NSDate *)date
{
    self = [super init];
    if (self) {
        costArray = [NSMutableArray arrayWithObjects:cost, costType, [Cost getStringFromDate:date], nil];
        DebugLog(@"costArray = %@", costArray.debugDescription);
    }
    
    return self;
}

- (id)initWithCost:(NSString *)cost costType:(NSString *)costType dateString:(NSString *)dateString
{
    self = [super init];
    if (self) {
        costArray = [NSMutableArray arrayWithObjects:cost, costType, dateString, nil];
        DebugLog(@"costArray = %@", costArray.debugDescription);
    }
    
    return self;
}

@end
