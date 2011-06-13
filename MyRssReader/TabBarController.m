//
//  TabBarController.m
//  MyRssReader
//
//  Created by Ching on 2011/6/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [self setTabURLs:[NSArray arrayWithObjects:
                      @"tt://feeds/1",
                      @"tt://feeds/2",
                      @"tt://feeds/3",
                      nil]];
}

@end