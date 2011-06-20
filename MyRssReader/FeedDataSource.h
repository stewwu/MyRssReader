//
//  FeedDataSource.h
//  MyRssReader
//
//  Created by Ching on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedModel.h"

@interface FeedDataSource : TTListDataSource {
  FeedModel *_feedModel;
  NSString *_category;
}

- (id)initWithUrl:(NSString *)url category:(NSString *)category dateFormatter:(NSDateFormatter *)dateFormatter;

@end
