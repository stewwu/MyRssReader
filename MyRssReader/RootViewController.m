//
//  RootViewController.m
//  MyRssReader
//
//  Created by Ching on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FeedDataSource.h"
#import "RootViewController.h"

@implementation RootViewController

- (id)initWithType:(NSInteger)type
{
  self = [super init];
  if (self) {
    if (type == 1) {
      self.title = @"Blog";
    } else if (type == 2) {
      self.title = @"Forum";
    } else {
      self.title = @"東森新聞";
    }
    //UIImage* image = [UIImage imageNamed:@"tab.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:nil tag:0] autorelease];
    
    self.variableHeightRows = YES;
  }
  return self;
}

- (void)createModel
{
  if ([self.title isEqualToString:@"Blog"]) {
    self.dataSource = [[[FeedDataSource alloc] initWithUrl:@"http://feeds.feedburner.com/inside-blog-taiwan" dateFormatter:nil] autorelease];
  } else if ([self.title isEqualToString:@"Forum"]) {
    self.dataSource = [[[FeedDataSource alloc] initWithUrl:@"http://forum.inside.com.tw/rss.php?auth=0" dateFormatter:nil] autorelease];
  } else {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    self.dataSource = [[[FeedDataSource alloc] initWithUrl:@"http://news.ebc.net.tw/rss/" dateFormatter:dateFormatter] autorelease];
    
    TT_RELEASE_SAFELY(dateFormatter);
  }
}

@end
