//
//  CostType.m
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "CostType.h"

#import "CommonUtilsHeader.h"

@interface CostType ()

@property (nonatomic) NSArray *costTypes;

@end

static CostType *sharedManager = nil;

@implementation CostType

#define CostTypeFilePath        @"settings"
#define CostTypeFile            @"costtype.txt"

@synthesize costTypes;

+ (CostType *)sharedManager
{
    DebugLogFunc();
    
    if (!sharedManager) {
        sharedManager = [[CostType alloc] init];
        
//        sharedManager.costTypes = [sharedManager loadCostTypeFromFile];
        if ((!(sharedManager.costTypes)) || ([sharedManager.costTypes count] == 0)) {
            sharedManager.costTypes = [sharedManager loadDefaultCostType];
        }
    }
    
    return sharedManager;
}

- (NSArray *)getCostTypes
{
    return costTypes;
}

- (NSArray *)getCostTypeImages
{
    NSArray *costTypeNames = @[@"food", @"drink", @"sweets", @"snack", @"gas", @"cloth", @"shoes", @"elec", @"else"];
    
    NSMutableArray *costTypeImages = nil;
    
    if (costTypeNames && ([costTypeNames count] > 0)) {
        costTypeImages = [NSMutableArray array];
        
        for (int i = 0; i < [costTypeNames count]; i ++) {
            [costTypeImages addObject:[UIImage imageNamed:[costTypeNames objectAtIndex:i]]];
        }
    }
    
    return costTypeImages;
}

- (UIImage *)getImageByType:(NSString *)type
{
    if ((!costTypes) || ([costTypes count] == 0)) {
        return nil;
    }
    
    NSUInteger index = [costTypes indexOfObject:type];
    
    if (index >= [costTypes count]) {
        return nil;
    }
    
    NSArray* images = [self getCostTypeImages];
    
    if ((!images) || ([images count] == 0)) {
        return nil;
    }
    
    return [images objectAtIndex:index];
}

//- (BOOL)saveCostTypes
//{
//    return [self saveCostTypes:costTypes];
//}

#pragma mark - private function

- (NSArray *)loadDefaultCostType
{
    return @[@"ご飯", @"飲料水", @"菓子", @"スナック", @"ガスなど", @"服装", @"靴", @"電子製品", @"その他"];
}

//- (NSArray *)loadCostTypeFromFile
//{
//    DebugLogFunc();
//    
//    NSMutableString *fileFullPath = [NSMutableString string];
//    
//    [fileFullPath appendFormat:@"%@", NSHomeDirectory()];
//    [fileFullPath appendFormat:@"/%@", CostTypeFilePath];
//    [fileFullPath appendFormat:@"/%@", CostTypeFile];
//    DebugLog(@"fileFullPath = %@", fileFullPath);
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    if (![fileManager fileExistsAtPath:fileFullPath]) {
//        return nil;
//    }
//    
//    NSArray *array = [NSArray arrayWithContentsOfFile:fileFullPath];
//    
//    return array;
//}
//
//- (BOOL)saveCostTypes:(NSArray *)array
//{
//    DebugLogFunc();
//    
//    if ((!array) || ([array count] == 0)) {
//        return NO;
//    }
//    
//    NSMutableString *fileFullPath = [NSMutableString string];
//    
//    [fileFullPath appendFormat:@"%@", NSHomeDirectory()];
//    [fileFullPath appendFormat:@"/%@", CostTypeFilePath];
//    DebugLog(@"fileFullPath = %@", fileFullPath);
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error = nil;
//    BOOL pathCreated = YES;
//    
//    if (![fileManager fileExistsAtPath:fileFullPath]) {
//        pathCreated = [fileManager createDirectoryAtPath:fileFullPath withIntermediateDirectories:YES attributes:nil error:&error];
//    }
//    
//    if ((!pathCreated) || (error)) {
//        DebugLog(@"%@", error.debugDescription);
//        
//        return NO;
//    }
//    
//    [fileFullPath appendFormat:@"/%@", CostTypeFile];
//    DebugLog(@"fileFullPath = %@", fileFullPath);
//    
//    BOOL fileSaved = [array writeToFile:fileFullPath atomically:YES];
//    
//    return fileSaved;
//}

@end
