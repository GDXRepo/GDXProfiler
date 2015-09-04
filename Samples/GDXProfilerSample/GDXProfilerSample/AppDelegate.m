//
//  AppDelegate.m
//  GDXProfilerSample
//
//  Created by Георгий Малюков on 22.08.15.
//  Copyright (c) 2015 Georgiy Malyukov. All rights reserved.
//

#import "AppDelegate.h"
#import "SingleViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [SingleViewController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
