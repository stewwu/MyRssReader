//
//  FeedModel.m
//  MyRssReader
//
//  Created by Ching on 2011/6/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+InternetDateTime.h"

#import "FeedModel.h"
#import "FeedItem.h"


@implementation FeedModel

@synthesize url=_url;
@synthesize dateFormatter=_dateFormatter;
@synthesize items=_items;
@synthesize finished=_finished;

- (id)initWithUrl:(NSString *)url dateFormatter:(NSDateFormatter *)dateFormatter
{
  self = [super init];
  if (self) {
    self.url = url;
    self.dateFormatter = dateFormatter;
    _items = [[NSMutableArray array] retain];
  }
  return self;
}

- (void)dealloc
{
  TT_RELEASE_SAFELY(_dateFormatter);
  TT_RELEASE_SAFELY(_url);
  TT_RELEASE_SAFELY(_items);
  [super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
  if (!self.isLoading) {
    if (!more) {
      _finished = NO;
      [_items removeAllObjects];
    }
    
    TTURLRequest *request = [TTURLRequest requestWithURL:_url delegate:self];
    request.cachePolicy = cachePolicy;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    TTURLXMLResponse *response = [[TTURLXMLResponse alloc] init];
    response.isRssFeed = YES;
    request.response = response;
    TT_RELEASE_SAFELY(response);
    
    [request send];
  }
}

- (void)requestDidFinishLoad:(TTURLRequest *)request
{
  TTURLXMLResponse *response = request.response;
  
  TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
  NSDictionary *rootObject = response.rootObject;
  
  TTDASSERT([[rootObject objectForKey:@"channel"] isKindOfClass:[NSDictionary class]]);
  NSDictionary *channel = [rootObject objectForKey:@"channel"];
  
  TTDASSERT([[channel objectForKey:@"item"] isKindOfClass:[NSArray class]]);
  NSArray *entries = [channel objectForKey:@"item"];
  
  NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[entries count]];
  for (NSDictionary* entry in entries) {
    FeedItem *item = [[FeedItem alloc] init];
    NSDictionary *title = [entry objectForKey:@"title"];
    item.title = [title objectForKey:@"___Entity_Value___"];
    NSDictionary *pubDate  = [entry objectForKey:@"pubDate"];
    if (_dateFormatter == nil) {
      item.date = [NSDate dateFromInternetDateTimeString:[pubDate objectForKey:@"___Entity_Value___"] formatHint:DateFormatHintRFC822];
    } else {
      item.date = [_dateFormatter dateFromString:[pubDate objectForKey:@"___Entity_Value___"]];
    }
    NSDictionary *desc = [entry objectForKey:@"description"];
    item.description = [desc objectForKey:@"___Entity_Value___"];
    NSDictionary *link  = [entry objectForKey:@"link"];
    item.link = [[link objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSDictionary *image  = [entry objectForKey:@"image"];
    item.image = [[image objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [items addObject:item];
  }
  _items = items;
  
  _finished = YES;
  
  [super requestDidFinishLoad:request];
}

@end
