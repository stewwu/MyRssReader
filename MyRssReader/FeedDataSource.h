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
}

- (id)initWithUrl:(NSString *)url dateFormatter:(NSDateFormatter *)dateFormatter;

@end
