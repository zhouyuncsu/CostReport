//
//  CostType.h
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CostType : NSObject

+ (CostType *)sharedManager;

- (NSArray *)getCostTypes;
- (NSArray *)getCostTypeImages;
- (UIImage *)getImageByType:(NSString *)type;

//- (BOOL)saveCostTypes;

@end
