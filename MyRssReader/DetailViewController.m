//
//  DetailViewController.m
//  MyRssReader
//
//  Created by Ching on 2011/6/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize item;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}
*/
- (id)initWithItem:(MWFeedItem *)aItem
{
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    self.item = aItem;
  }
  return self;
}

- (void)dealloc
{
  [item release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)buttonClick
{
   UIViewController *detailViewController = [[UIViewController alloc] init];
   UIWebView *webView = [[UIWebView alloc] init];
   
   detailViewController.title = item.title;
   detailViewController.view = webView;
   webView.scalesPageToFit = YES;
   [webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:item.link]]];
   [webView release];
   
   [self.navigationController pushViewController:detailViewController animated:YES];
   [detailViewController release];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
  //self.view.autoresizesSubviews = YES;

  NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
  NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
  
  UIButton *title = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  title.frame = CGRectMake(10, 10, 300, 30);
  //title.adjustsFontSizeToFitWidth = YES;
  title.backgroundColor = [UIColor clearColor];
  [title setTitle:itemTitle forState:UIControlStateNormal];
  [title addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:title];
  
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	[formatter setTimeStyle:NSDateFormatterNoStyle];
  
  UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 20)];
  //title.adjustsFontSizeToFitWidth = YES;
  date.text = [formatter stringFromDate:item.date];;
  date.textColor = [UIColor grayColor];
  [self.view addSubview:date];
  [date release];

  /*
  UIWebView *summary = [[UIWebView alloc] initWithFrame:CGRectMake(10, 70, 300, 100)];
  //summary.adjustsFontSizeToFitWidth = YES;
  [summary loadHTMLString:itemSummary baseURL:nil];
  [self.view addSubview:summary];
  [summary release];
   */
  UITextView *summary = [[UITextView alloc] initWithFrame:CGRectMake(10, 70, 300, 400)];
  //summary.adjustsFontSizeToFitWidth = YES;
  summary.text = itemSummary;
  //summary.editable = NO;
  summary.dataDetectorTypes = UIDataDetectorTypeAll;
  [self.view addSubview:summary];
  [summary release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
