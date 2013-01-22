//
//  MainMenu.m
//  UIKitNavTest
//
//  Created by 周贇 on 2013/01/17.
//  Copyright (c) 2013年 zhouyun. All rights reserved.
//

#import "MainMenu.h"

#import "CommonUtilsHeader.h"

static MainMenu *sharedManager = nil;

@implementation MainMenu

+ (MainMenu *)sharedManager
{
    if (!sharedManager) {
        sharedManager = [[MainMenu alloc] init];
    }
    
    return sharedManager;
}

- (NSArray *)getSectionHeaders
{
    return @[@"レポート", @"記録", @"設定"];
}

- (NSArray *)getRowTitlesBySection:(int)section
{
    switch (section) {
        case 0:
            return @[@"月ごと", @"周ごと"];
            
        case 1:
            return @[@"追加", @"今日のまとめ"];
            
        case 2:
            return @[@"記録タイプ"];
            
        default:
            return nil;
    }
}

- (NSArray *)getRowImagesBySection:(int)section
{
    NSArray *imageNames;
    
    switch (section) {
        case 0:
            imageNames = @[@"main_tableview_00", @"main_tableview_01"];
            break;
            
        case 1:
            imageNames =  @[@"main_tableview_10", @"main_tableview_11"];
            break;
            
        case 2:
            imageNames =  @[@"main_tableview_20"];
            break;
            
        default:
            imageNames =  nil;
    }
    
    NSMutableArray *images = nil;
    
    if (imageNames && ([imageNames count] > 0)) {
        images = [NSMutableArray array];
        
        for (int i = 0; i < [imageNames count]; i ++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
    }
    
    return images;
}

@end
