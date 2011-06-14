//
//  MyRssReaderAppDelegate.m
//  MyRssReader
//
//  Created by Ching on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyRssReaderAppDelegate.h"
#import "TabBarController.h"
#import "RootViewController.h"
#import "DetailViewController.h"

@implementation MyRssReaderAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Override point for customization after application launch.
  // Add the navigation controller's view to the window and display.

  [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
  
  TTNavigator* navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;
  navigator.window = self.window;
  
  TTURLMap* map = navigator.URLMap;
  [map from:@"*" toViewController:[TTWebController class]];
  [map from:@"tt://tabs" toSharedViewController:[TabBarController class]];
  [map from:@"tt://feeds/(initWithType:)" toSharedViewController:[RootViewController class]];
  [map from:@"tt://summary/(initWithFeedDigest:)/(item:)" toViewController:[DetailViewController class]];
  
  if (! [navigator restoreViewControllers]) {
    [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabs"]];
  }
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
