//
//  DetailViewController.h
//  MyRssReader
//
//  Created by Ching on 2011/6/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface DetailViewController : UIViewController {
  MWFeedItem *item;
}

@property (nonatomic, retain) MWFeedItem *item;

- (id)initWithItem:(MWFeedItem *)aItem;

@end
