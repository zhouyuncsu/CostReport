//
//  CommonUtilsHeader.h
//  UIKitNavTest
//
//  Created by 周贇 on 2013/01/17.
//  Copyright (c) 2013年 zhouyun. All rights reserved.
//

#ifndef UIKitNavTest_CommonUtilsHeader_h
#define UIKitNavTest_CommonUtilsHeader_h

#ifdef DEBUG

#define DebugLog(a, b)      NSLog(a, b)
#define DebugLogFunc()      NSLog(@"%s", __func__)
#define DebugLogNSString(a) NSLog(@"%@", a)

#elif

#define DebugLog(a, b)
#define DebugLogFunc()
#define DebugLogNSString(a)

#endif

#endif
