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
  NSString *rootTag = [rootObject objectForKey:@"___Entity_Name___"];
  
  NSMutableArray *items = [[NSMutableArray alloc] init];
  if ([rootTag isEqualToString:@"feed"]) { // Atom
    TTDASSERT([[rootObject objectForKey:@"entry"] isKindOfClass:[NSArray class]]);
    NSArray *entries = [rootObject objectForKey:@"entry"];
    
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSDictionary *element = nil;
    for (NSDictionary *entry in entries) {
      FeedItem *item = [[FeedItem alloc] init];
      
      // title
      element = [entry objectForKey:@"title"];
      item.title = [element objectForKey:@"___Entity_Value___"];
      
      // date
      element  = [entry objectForKey:@"updated"];
      if (_dateFormatter == nil) {
        item.date = [NSDate dateFromRFC3339String:[element objectForKey:@"___Entity_Value___"]];
      } else {
        item.date = [_dateFormatter dateFromString:[element objectForKey:@"___Entity_Value___"]];
      }
      
      // summary
      element = [entry objectForKey:@"summary"];
      item.description = [element objectForKey:@"___Entity_Value___"];
      
      // categories
      element = [entry objectForKey:@"category"];
      if (!element)
        element = [entry objectForKey:@"subcategory"];
      if ([element isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[element count]];
        [(NSArray *)element enumerateObjectsUsingBlock:
         ^(id obj, NSUInteger idx, BOOL *stop) {
           [array addObject:[[obj objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space]];
         }
         ];
        item.categories = [NSArray arrayWithArray:array];
      } else if ([element isKindOfClass:[NSDictionary class]]) {
        item.categories = [NSArray arrayWithObject:[element objectForKey:@"term"]];
      }
      
      // link
      element  = [entry objectForKey:@"link"];
      if ([element isKindOfClass:[NSArray class]]) {
        for (NSDictionary *link in element) {
          if (!item.link || [[link objectForKey:@"rel"] isEqualToString:@"alternate"])
            item.link = [link objectForKey:@"href"];
        }
      } else if ([element isKindOfClass:[NSDictionary class]]) {
          item.link = [element objectForKey:@"href"];
      }
      
      // image
      element  = [entry objectForKey:@"image"];
      item.image = [[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space];
      
      // guid
      element  = [entry objectForKey:@"id"];
      item.guid = [[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space];
      
      [items addObject:item];
    }
  } else if ([rootTag isEqualToString:@"rss"]) { // RSS
    TTDASSERT([[rootObject objectForKey:@"channel"] isKindOfClass:[NSDictionary class]]);
    NSDictionary *channel = [rootObject objectForKey:@"channel"];
    
    TTDASSERT([[channel objectForKey:@"item"] isKindOfClass:[NSArray class]]);
    NSArray *entries = [channel objectForKey:@"item"];
    
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSDictionary *element = nil;
    for (NSDictionary *entry in entries) {
      FeedItem *item = [[FeedItem alloc] init];
      
      // title
      element = [entry objectForKey:@"title"];
      item.title = [element objectForKey:@"___Entity_Value___"];
      
      // date
      element  = [entry objectForKey:@"pubDate"];
      if (_dateFormatter == nil) {
        item.date = [NSDate dateFromRFC822String:[element objectForKey:@"___Entity_Value___"]];
      } else {
        item.date = [_dateFormatter dateFromString:[element objectForKey:@"___Entity_Value___"]];
      }
      
      // summary
      element = [entry objectForKey:@"description"];
      item.description = [element objectForKey:@"___Entity_Value___"];
      
      // categories
      element = [entry objectForKey:@"category"];
      if (!element)
        element = [entry objectForKey:@"subcategory"];
      if ([element isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[element count]];
        [(NSArray *)element enumerateObjectsUsingBlock:
         ^(id obj, NSUInteger idx, BOOL *stop) {
           [array addObject:[[obj objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space]];
         }
        ];
        item.categories = [NSArray arrayWithArray:array];
      } else if ([element isKindOfClass:[NSDictionary class]]) {
        item.categories = [NSArray arrayWithObject:[[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space]];
      }
      
      // link
      element  = [entry objectForKey:@"link"];
      item.link = [[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space];
      
      // image
      element  = [entry objectForKey:@"image"];
      item.image = [[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space];
      
      // guid
      element  = [entry objectForKey:@"guid"];
      item.guid = [[element objectForKey:@"___Entity_Value___"] stringByTrimmingCharactersInSet:space];
      
      [items addObject:item];
    }
  }
  _items = items;
  
  _finished = YES;
  
  [super requestDidFinishLoad:request];
}

@end
