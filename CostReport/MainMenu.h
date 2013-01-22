//
//  MainMenu.h
//  UIKitNavTest
//
//  Created by 周贇 on 2013/01/17.
//  Copyright (c) 2013年 zhouyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMenu : NSObject

+ (MainMenu *)sharedManager;

- (NSArray *)getSectionHeaders;
- (NSArray *)getRowTitlesBySection:(int)section;
- (NSArray *)getRowImagesBySection:(int)section;

@end
