//
//  CostManager.m
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "CostManager.h"

#import "CommonUtilsHeader.h"
#import "NotificationsHeader.h"

@interface CostManager ()

@property (nonatomic) NSMutableArray *costsArray;

@end

static CostManager *sharedManager = nil;

@implementation CostManager

#define CostManagerFilePath         @"costs"
#define CostManagerFile             @"costs.txt"
#define CostManagerFileEncoding     NSUTF8StringEncoding

@synthesize costsArray;

+ (CostManager *)sharedManager
{
    if (!sharedManager) {
        sharedManager = [[CostManager alloc] init];
        
        sharedManager.costsArray = [sharedManager loadCostsTodayFromFile];
        if (!sharedManager.costsArray) {
            sharedManager.costsArray = [NSMutableArray array];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedManager selector:@selector(saveCosts) name:CostManager_saveCosts object:nil];
    }
    
    return sharedManager;
}

- (NSArray *)getCosts
{
    return costsArray;
}

- (BOOL)saveCosts
{
    DebugLogFunc();
    
    return [self saveCosts:costsArray];
}

- (void)insert:(Cost *)cost
{
    if (!cost) {
        DebugLogNSString(@"error:insert object cost = nil");
        return;
    }
    
    [costsArray insertObject:cost atIndex:0];
}

- (void)removeAtIndex:(NSInteger)index
{
    if (index >= [costsArray count]) {
        DebugLog(@"error:remove index = %d\n", index);
        DebugLog(@"error:costsArray count = %d\n", [costsArray count]);
        return;
    }
    
    [costsArray removeObjectAtIndex:index];
}

- (void)modifyCost:(NSString *)cost atIndex:(NSInteger)index
{
    if (index >= [costsArray count]) {
        DebugLog(@"error:modify index = %d\n", index);
        DebugLog(@"error:costsArray count = %d\n", [costsArray count]);
        return;
    }
    
    Cost *costObject = [costsArray objectAtIndex:index];
    [costObject setCost:cost];
    
    [costsArray replaceObjectAtIndex:index withObject:costObject];
}

- (void)modifyCostType:(NSString *)costType atIndex:(NSInteger)index
{
    if (index >= [costsArray count]) {
        DebugLog(@"error:modify index = %d\n", index);
        DebugLog(@"error:costsArray count = %d\n", [costsArray count]);
        return;
    }
    
    Cost *costObject = [costsArray objectAtIndex:index];
    [costObject setCostType:costType];
    
    [costsArray replaceObjectAtIndex:index withObject:costObject];
}

- (void)modifyCost:(NSString *)cost costType:(NSString *)costType atIndex:(NSInteger)index
{
    if (index >= [costsArray count]) {
        DebugLog(@"error:modify index = %d\n", index);
        DebugLog(@"error:costsArray count = %d\n", [costsArray count]);
        return;
    }
    
    Cost *costObject = [costsArray objectAtIndex:index];
    [costObject setCost:cost];
    [costObject setCostType:costType];
    
    [costsArray replaceObjectAtIndex:index withObject:costObject];
}

#pragma mark - private function

- (NSMutableArray *)arrayWithContentsOfFile:(NSString *)file
{
    if (!file) {
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:file]) {
        return nil;
    }
    
    NSMutableString *string = [NSMutableString string];
    NSError *error = nil;
    
    [string appendFormat:@"%@",[NSString stringWithContentsOfFile:file encoding:CostManagerFileEncoding error:&error]];
    
    if (error) {
        DebugLogNSString(error.debugDescription);
        return nil;
    }
    
    DebugLogNSString(string);
    string = (NSMutableString *)[string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    DebugLogNSString(string);
    
    string = (NSMutableString *)[[string componentsSeparatedByString:@"("] objectAtIndex:1];
    string = (NSMutableString *)[[string componentsSeparatedByString:@")"] objectAtIndex:0];
    
    NSArray *stringArray = [string componentsSeparatedByString:@","];
    
    if ((!stringArray) || ([stringArray count] == 0)) {
        return nil;
    }
    
    NSMutableArray *costArray = [NSMutableArray array];
    for (int i = 0; i < [stringArray count]; i ++) {
        Cost *cost = [Cost getCostFromSaveString:[stringArray objectAtIndex:i]];
        if (cost) {
            [costArray insertObject:cost atIndex:[costArray count]];
        }
    }
    
    return costArray;
}

- (NSMutableArray *)loadCostsTodayFromFile
{
    DebugLogFunc();
    
    NSDate *date = [NSDate date];
    
    NSString *filePathYear = [Cost getYear:date];
    NSString *filePathMonth = [Cost getMonth:date];
    NSString *filePathDay = [Cost getDay:date];
    
    if ((!filePathYear) || (!filePathMonth) || (!filePathDay)) {
        return nil;
    }
    
    NSMutableString *fileFullPath = [NSMutableString string];
    
    [fileFullPath appendFormat:@"%@", NSHomeDirectory()];
    [fileFullPath appendFormat:@"/%@", CostManagerFilePath];
    [fileFullPath appendFormat:@"/%@", filePathYear];
    [fileFullPath appendFormat:@"/%@", filePathMonth];
    [fileFullPath appendFormat:@"/%@", filePathDay];
    [fileFullPath appendFormat:@"/%@", CostManagerFile];
    DebugLog(@"fileFullPath = %@", fileFullPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fileFullPath]) {
        return nil;
    }
    
    NSMutableArray *array = [self arrayWithContentsOfFile:fileFullPath];
    
    return array;
}

- (BOOL)saveCosts:(NSArray *)array
{
    if ((!array) || ([array count] == 0)) {
        return NO;
    }
    
    NSArray *arraySeparatedByDay = [self separateCostsArrayByDay:array];
    
    if ((!arraySeparatedByDay) || ([arraySeparatedByDay count] == 0)) {
        return NO;
    }
    
    BOOL saveResult = YES;
    BOOL tmp;
    
    for (NSArray *costArray in arraySeparatedByDay) {
        if ((!costArray) || ([costArray count] == 0)) {
            return NO;
        }
        
        Cost *cost = [costArray objectAtIndex:0];
        
        tmp = [self saveCosts:costArray byYear:[cost getYearOfCost] month:[cost getMonthOfCost] day:[cost getDayOfCost]];
        
        if (!tmp) {
            saveResult = NO;
        }
    }
    
    return saveResult;
}

- (NSArray *)separateCostsArrayByDay:(NSArray *)array
{
    if ((!array) || ([array count] == 0)) {
        return nil;
    }
    
    NSMutableArray *arraySeparated = [NSMutableArray array];
    NSMutableArray *arrayOfCost = nil;
    
    NSString *year = nil;
    NSString *month = nil;
    NSString *day = nil;
    
    for (Cost *cost in array) {
        if ((!year) && (!month) && (!day) && (!arrayOfCost)) {
            year = [cost getYearOfCost];
            month = [cost getMonthOfCost];
            day = [cost getDayOfCost];
            
            arrayOfCost = [NSMutableArray array];
            DebugLog(@"before insert, arrayOfCost = %@", arrayOfCost.debugDescription);
            [arrayOfCost insertObject:cost atIndex:[arrayOfCost count]];
            DebugLog(@"after insert, arrayOfCost = %@", arrayOfCost.debugDescription);
        } else if (([year isEqualToString:[cost getYearOfCost]]) && ([month isEqualToString:[cost getMonthOfCost]]) && ([day isEqualToString:[cost getDayOfCost]])) {
            DebugLog(@"before insert, arrayOfCost = %@", arrayOfCost.debugDescription);
            [arrayOfCost insertObject:cost atIndex:[arrayOfCost count]];
            DebugLog(@"after insert, arrayOfCost = %@", arrayOfCost.debugDescription);
        } else {
            if ((!arrayOfCost) || ([arrayOfCost count] > 0)) {
                [arraySeparated insertObject:arrayOfCost atIndex:[arraySeparated count]];
            }
            
            year = [cost getYearOfCost];
            month = [cost getMonthOfCost];
            day = [cost getDayOfCost];
            
            arrayOfCost = [NSMutableArray array];
            DebugLog(@"before insert, arrayOfCost = %@", arrayOfCost.debugDescription);
            [arrayOfCost insertObject:cost atIndex:[arrayOfCost count]];
            DebugLog(@"after insert, arrayOfCost = %@", arrayOfCost.debugDescription);
        }
    }
    
    if (arrayOfCost) {
        [arraySeparated insertObject:arrayOfCost atIndex:[arraySeparated count]];
    }
    
    return arraySeparated;
}

- (BOOL)saveCosts:(NSArray *)array byYear:(NSString *)year month:(NSString *)month day:(NSString *)day
{
    DebugLogFunc();
    
    if ((!year) || (!month) || (!day) || (!array) || ([array count] == 0)) {
        return NO;
    }
    
    NSMutableString *fileFullPath = [NSMutableString string];
    
    [fileFullPath appendFormat:@"%@", NSHomeDirectory()];
    [fileFullPath appendFormat:@"/%@", CostManagerFilePath];
    [fileFullPath appendFormat:@"/%@", year];
    [fileFullPath appendFormat:@"/%@", month];
    [fileFullPath appendFormat:@"/%@", day];
    DebugLog(@"fileFullPath = %@", fileFullPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL pathCreated = YES;
    
    if (![fileManager fileExistsAtPath:fileFullPath]) {
        pathCreated = [fileManager createDirectoryAtPath:fileFullPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    if ((!pathCreated) || (error)) {
        DebugLog(@"%@", error.debugDescription);
        
        return NO;
    }
    
    [fileFullPath appendFormat:@"/%@", CostManagerFile];
    DebugLog(@"fileFullPath = %@", fileFullPath);
    
    DebugLogNSString(array.debugDescription);
    BOOL fileSaved = [array.debugDescription writeToFile:fileFullPath atomically:YES encoding:CostManagerFileEncoding error:&error];
    if ((!fileSaved) || (error)) {
        DebugLog(@"%@", error.debugDescription);
    }
    
    return fileSaved;
}

@end
