//
//  RootViewController.h
//  MyRssReader
//
//  Created by Ching on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser/MWFeedParser.h"

@interface RootViewController : UITableViewController {
  MWFeedParser *feedParser;
  NSMutableArray *parsedItems;

  NSDateFormatter *formatter;
  UIActivityIndicatorView *activityIndicator;
  NSArray *items;
}

@property (nonatomic, retain) NSArray *items;

@end
