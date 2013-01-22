//
//  AppDelegate.m
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "AppDelegate.h"

#import "CommonUtilsHeader.h"
#import "MainViewController.h"
#import "MainTableViewController.h"
#import "NotificationsHeader.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DebugLogFunc();
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainTableViewController *mainTableViewController = [[MainTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithRootViewController:mainTableViewController];
    
    self.window.rootViewController = mainViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    DebugLogFunc();
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    DebugLogFunc();
    
    NSNotification *n = [NSNotification notificationWithName:CostManager_saveCosts object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    DebugLogFunc();
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    DebugLogFunc();
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DebugLogFunc();
}

@end
