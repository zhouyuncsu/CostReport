//
//  CostManager.h
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Cost.h"

@interface CostManager : NSObject

+ (CostManager *)sharedManager;

- (NSArray *)getCosts;
- (BOOL)saveCosts;

- (void)insert:(Cost *)cost;
- (void)removeAtIndex:(NSInteger)index;
- (void)modifyCost:(NSString *)cost atIndex:(NSInteger)index;
- (void)modifyCostType:(NSString *)costType atIndex:(NSInteger)index;
- (void)modifyCost:(NSString *)cost costType:(NSString *)costType atIndex:(NSInteger)index;

@end
