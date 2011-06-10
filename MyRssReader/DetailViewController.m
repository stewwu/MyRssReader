//
//  DetailViewController.m
//  MyRssReader
//
//  Created by Ching on 2011/6/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize item=_item;

/*
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query
{
  self = [super init];
  if (self) {
    self.item = [query objectForKey:@"item"];
  }
  return self;
}
 */

- (id)initWithFeedDigest:(NSString *)feedDigest item:(NSInteger)theItem
{
  self = [super init];
  if (self) {
    TTNavigator *nagivator = [TTNavigator navigator];
    TTURLMap *map = nagivator.URLMap;
  
    NSString *url = [NSString stringWithFormat:@"tt://objects/%@/%d", feedDigest, theItem];
    self.item = [map objectForURL:url];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateStyle:NSDateFormatterMediumStyle];
    [_formatter setTimeStyle:NSDateFormatterNoStyle];
  }
  return self;
}

- (void)dealloc
{
  [_formatter release];
  [_item release];
  [super dealloc];
}

- (void)buttonClick
{
  TTOpenURL(_item.link);
}

#pragma -
#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
  
  NSString *title = _item.title ? [_item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
  NSString *date = [_formatter stringFromDate:_item.date];
  NSString *summary = _item.summary ? [_item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";

  UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  titleButton.frame = CGRectMake(10, 10, 300, 30);
  //titleButton.adjustsFontSizeToFitWidth = YES;
  titleButton.backgroundColor = [UIColor clearColor];
  [titleButton setTitle:title forState:UIControlStateNormal];
  [titleButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:titleButton];
  
  UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 20)];
  dateLabel.text = [_formatter stringFromDate:date];;
  dateLabel.textColor = [UIColor grayColor];
  [self.view addSubview:dateLabel];
  [dateLabel release];

  /*
  UIWebView *summary = [[UIWebView alloc] initWithFrame:CGRectMake(10, 70, 300, 100)];
  //summary.adjustsFontSizeToFitWidth = YES;
  [summary loadHTMLString:itemSummary baseURL:nil];
  [self.view addSubview:_item.summary];
  [summary release];
   */
  UITextView *summaryView = [[UITextView alloc] initWithFrame:CGRectMake(10, 70, 300, 300)];
  //summaryView.adjustsFontSizeToFitWidth = YES;
  summaryView.text = summary;
  //summaryView.editable = NO;
  summaryView.dataDetectorTypes = UIDataDetectorTypeAll;
  [self.view addSubview:summaryView];
  [summaryView release];
}

@end
