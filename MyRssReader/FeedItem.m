//
//  FeedItem.m
//  MyRssReader
//
//  Created by Ching on 2011/6/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FeedItem.h"


@implementation FeedItem

@synthesize title=_title;
@synthesize date=_date;
@synthesize description=_description;
@synthesize categories=_categories;
@synthesize link=_link;
@synthesize image=_image;
@synthesize guid=_guid;

- (void)dealloc
{
  TT_RELEASE_SAFELY(_title);
  TT_RELEASE_SAFELY(_date);
  TT_RELEASE_SAFELY(_description);
  TT_RELEASE_SAFELY(_categories);
  TT_RELEASE_SAFELY(_link);
  TT_RELEASE_SAFELY(_image);
  TT_RELEASE_SAFELY(_guid);
  
  [super dealloc];
}

@end
