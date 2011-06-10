//
//  FeedDataSource.m
//  MyRssReader
//
//  Created by Ching on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FeedDataSource.h"

@implementation FeedDataSource

@synthesize url=_url;
@synthesize parsedItems=_parsedItems;

- (id)initWithUrl:(NSString *)theUrl
{
  self = [super init];
  if (self) {
    self.url = theUrl;
    self.parsedItems = [[NSMutableArray alloc] init];
    
    _feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:_url]];
    _feedParser.delegate = (id)self;
    _feedParser.feedParseType = ParseTypeFull;
    //_feedParser.connectionType = ConnectionTypeAsynchronously;
    _feedParser.connectionType = ConnectionTypeSynchronously;
    [_feedParser parse];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateStyle:NSDateFormatterMediumStyle];
    [_formatter setTimeStyle:NSDateFormatterNoStyle];
  }
  return self;
}

- (void)delloc
{
  TT_RELEASE_SAFELY(_formatter);
  TT_RELEASE_SAFELY(_feedParser);
  TT_RELEASE_SAFELY(_parsedItems);
  TT_RELEASE_SAFELY(_url);
  [super dealloc];
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
  TTNavigator *navigator = [TTNavigator navigator];
  TTURLMap *map = navigator.URLMap;

  NSMutableArray *items = [[NSMutableArray alloc] init];
  NSInteger n = 0;
  for (MWFeedItem *item in _parsedItems) {
    NSString *title = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    NSString *date = [_formatter stringFromDate:item.date];
    NSString *summary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
    NSString *url = [NSString stringWithFormat:@"tt://summary/%x/%d", [_url hash], n];
    
    TTTableSubtitleItem *tableItem = [TTTableSubtitleItem itemWithText:title subtitle:date imageURL:nil defaultImage:nil URL:url accessoryURL:nil];
    [items addObject:tableItem];

    NSString *objUrl = [NSString stringWithFormat:@"tt://objects/%x/%d", [_url hash], n];
    [map setObject:item forURL:objUrl];
        
    n++;
  }  
  self.items = items;
  TT_RELEASE_SAFELY(items);
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser
{
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
	NSLog(@"Parsed Feed Info: “%@”", info.title);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item)
    [_parsedItems addObject:item];	
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
  NSLog(@"Finished Parsing %@", (parser.stopped ? @" (Stopped)" : @""));
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
	NSLog(@"Finished Parsing With Error: %@", error);
	[_parsedItems removeAllObjects];
}

@end
