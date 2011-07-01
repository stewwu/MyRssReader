//
//  FeedItem.h
//  MyRssReader
//
//  Created by Ching on 2011/6/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedItem : NSObject {
  NSString *_title;
  NSDate *_date;
  NSString *_description;
  NSArray *_categories;
  NSString *_link;
  NSString *_image;
  NSString *_guid;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSArray *categories;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *guid;

@end
