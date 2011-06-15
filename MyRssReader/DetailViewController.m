//
//  DetailViewController.m
//  MyRssReader
//
//  Created by Ching on 2011/6/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+HTML.h"
#import "DDActionHeaderView.h"
#import "SHK.h"
#import "SHKFacebook.h"
#import "SHKTwitter.h"

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

- (void)buttonClick:(id)sender
{
  NSURL *url = [NSURL URLWithString:_item.link];
  SHKItem *item = [SHKItem URL:url title:_item.title];

  if (sender == browseButton) {
    TTOpenURL(_item.link);
  } else if (sender == facebookButton) {
    [SHKFacebook shareItem:item];
  } else if (sender == twitterButton) {
    [SHKTwitter shareItem:item];
  }
}

#pragma -
#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
  
  NSString *title = _item.title ? [_item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
  //NSString *desc = _item.description ? [_item.description stringByConvertingHTMLToPlainText] : @"[No Summary]";

  DDActionHeaderView *actionHeaderView = [[[DDActionHeaderView alloc] initWithFrame:self.view.bounds] autorelease];
  actionHeaderView.titleLabel.text = title;
  
  browseButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [browseButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
  [browseButton setImage:[UIImage imageNamed:@"safari"] forState:UIControlStateNormal];
  browseButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
  browseButton.imageEdgeInsets = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
  browseButton.center = CGPointMake(25.0f, 25.0f);

  facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [facebookButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
  [facebookButton setImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
  facebookButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
  facebookButton.imageEdgeInsets = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
  facebookButton.center = CGPointMake(75.0f, 25.0f);
  
  twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [twitterButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
  [twitterButton setImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
  twitterButton.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
  twitterButton.imageEdgeInsets = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
  twitterButton.center = CGPointMake(125.0f, 25.0f);
  
  actionHeaderView.items = [NSArray arrayWithObjects:browseButton, facebookButton, twitterButton, nil];
  [self.view addSubview:actionHeaderView];
  
  UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 20)];
  dateLabel.text = [_item.date formatRelativeTime];;
  dateLabel.textColor = [UIColor grayColor];
  [self.view addSubview:dateLabel];
  [dateLabel release];

  UIWebView *summaryView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
  //summary.adjustsFontSizeToFitWidth = YES;
  [summaryView loadHTMLString:_item.description baseURL:nil];
  [self.view addSubview:summaryView];
  [summaryView release];
  
  /*
  UITextView *summaryView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
  //summaryView.adjustsFontSizeToFitWidth = YES;
  summaryView.text = desc;
  //summaryView.editable = NO;
  summaryView.dataDetectorTypes = UIDataDetectorTypeAll;
  [self.view addSubview:summaryView];
  [summaryView release];
   */
}

@end
