//
//  FeedModel.h
//  MyRssReader
//
//  Created by Ching on 2011/6/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedItem.h"


@interface FeedModel : TTURLRequestModel {
  NSString *_url;
  NSDictionary *_params;
  NSDateFormatter *_dateFormatter;
  NSMutableArray *_items;
  BOOL _finished;
}

@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, readonly) BOOL finished;

- (id)initWithUrl:(NSString *)url dateFormatter:(NSDateFormatter *)dateFormatter;

- (id)initWithUrl:(NSString *)url params:(NSDictionary *)params dateFormatter:(NSDateFormatter *)dateFormatter;

@end
