//
//  FeedDataSource.h
//  MyRssReader
//
//  Created by Ching on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser/MWFeedParser.h"

@interface FeedDataSource : TTListDataSource {
  NSString* _url;
  NSMutableArray *_parsedItems;

  MWFeedParser *_feedParser;
  NSDateFormatter *_formatter;
}

@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) NSMutableArray *parsedItems;

- (id)initWithUrl:(NSString *)theUrl;

@end
