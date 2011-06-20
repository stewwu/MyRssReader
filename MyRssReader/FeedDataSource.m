//
//  FeedDataSource.m
//  MyRssReader
//
//  Created by Ching on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+HTML.h"

#import "FeedDataSource.h"
#import "FeedItem.h"
#import "MyTableSubtitleItemCell.h"


@implementation FeedDataSource

- (id)initWithUrl:(NSString *)url category:(NSString *)category dateFormatter:(NSDateFormatter *)dateFormatter
{
  self = [super init];
  if (self) {
    _feedModel = [[FeedModel alloc] initWithUrl:url dateFormatter:dateFormatter];
    _category = [category retain];
  }
  return self;
}

- (void)delloc
{
  TT_RELEASE_SAFELY(_category);
  TT_RELEASE_SAFELY(_feedModel);
  [super dealloc];
}

- (id<TTModel>)model
{
  return _feedModel;
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
  TTNavigator *navigator = [TTNavigator navigator];
  TTURLMap *map = navigator.URLMap;

  NSMutableArray *items = [[NSMutableArray alloc] init];
  NSInteger n = 0;
  for (FeedItem *item in _feedModel.items) {
    if (_category != nil) {
      if (![item.categories containsObject:_category])
        continue;
    }
    NSString *title = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    NSString *date = [item.date formatRelativeTime];
    /*
    NSString *desc = item.description ? [item.description stringByConvertingHTMLToPlainText] : @"[No Description]";
     */
    NSString *url = [NSString stringWithFormat:@"tt://summary/%x/%d", [_feedModel.url hash], n];

    TTTableSubtitleItem *cell = [TTTableSubtitleItem itemWithText:title subtitle:date imageURL:item.image defaultImage:nil URL:url accessoryURL:nil];
    [items addObject:cell];

    NSString *objUrl = [NSString stringWithFormat:@"tt://objects/%x/%d", [_feedModel.url hash], n];
    [map setObject:item forURL:objUrl];
    
    n++;
  }
  _items = items;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
  if ([object isKindOfClass:[TTTableSubtitleItem class]]) {  
		return [MyTableSubtitleItemCell class];  
	}
	return [super tableView:tableView cellClassForObject:object];
}

@end