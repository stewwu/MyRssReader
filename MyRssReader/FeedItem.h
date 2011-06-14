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
  NSString *_link;
  NSString *_image;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *image;

@end
