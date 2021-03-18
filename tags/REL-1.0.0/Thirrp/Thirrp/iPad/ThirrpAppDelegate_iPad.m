//
//  ThirrpAppDelegate_iPad.m
//  Thirrp
//
//  Created by Chris Bluethman on 5/7/11.
//  Copyright 2011 Parastride Holdings, LLC. All rights reserved.
//

#import "ThirrpAppDelegate_iPad.h"


@implementation ThirrpAppDelegate_iPad


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Override point for customization after application launch.
  
  [super application:application didFinishLaunchingWithOptions:launchOptions];
  self.window.rootViewController = self.tbc;
  
  return ( YES );
}

- (void)dealloc
{
  [super dealloc];
}


@end
