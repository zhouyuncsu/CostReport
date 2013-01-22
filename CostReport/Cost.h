//
//  Cost.h
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cost : NSObject

- (id)initWithCost:(NSString *)cost costType:(NSString *)costType;

- (void)setCost:(NSString *)cost;
- (void)setCostType:(NSString *)costType;

- (NSString *)getCost;
- (NSString *)getCostType;

- (NSString *)getYearOfCost;
- (NSString *)getMonthOfCost;
- (NSString *)getDayOfCost;
- (NSString *)getHourOfCost;
- (NSString *)getMinuteOfCost;
- (NSString *)getSecondOfCost;

- (NSString *)getDateFormatString;

+ (NSString *)getYear:(NSDate *)date;
+ (NSString *)getMonth:(NSDate *)date;
+ (NSString *)getDay:(NSDate *)date;

- (NSString *)forSave;
+ (Cost *)getCostFromSaveString:(NSString *)saveString;

@end
