//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/20.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *navVCmain = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = navVCmain;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSNotification* n = [NSNotification notificationWithName:@"applicationDidEnterBackground" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSNotification* n = [NSNotification notificationWithName:@"applicationWillEnterForeground" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{

}


- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
