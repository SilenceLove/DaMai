//
//  AppDelegate.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "AppDelegate.h"
#import "RecommendViewController.h"
#import "ShowViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h" 
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [Tools addSqliteList];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[RecommendViewController alloc] init]];
    nav1.tabBarItem.title = @"推荐";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"icon_tab1_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab1_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[ShowViewController alloc] init]];
    nav2.tabBarItem.title = @"演出";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"icon_tab2_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab2_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[[DiscoverViewController alloc] init]];
    nav3.tabBarItem.title = @"发现";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"icon_tab3_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab3_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:[[MeViewController alloc] init]];
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [[UIImage imageNamed:@"icon_tab4_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab4_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#D33B47"]} forState:UIControlStateSelected];
    tabBarController.viewControllers = @[nav1,nav2,nav3,nav4];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
