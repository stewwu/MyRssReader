//
//  DetailViewController.h
//  MyRssReader
//
//  Created by Ching on 2011/6/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface DetailViewController : TTViewController {
  MWFeedItem *_item;
  
  NSDateFormatter *_formatter;
}

@property (nonatomic, retain) MWFeedItem *item;

- (id)initWithFeedDigest:(NSString *)feedDigest item:(NSInteger)theItem;

@end
