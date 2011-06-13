//
//  MyTableSubtitleItemCell.m
//  MyRssReader
//
//  Created by Ching on 2011/6/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyTableSubtitleItemCell.h"


@implementation MyTableSubtitleItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object
{
  TTTableSubtitleItem* item = object;
  
  CGFloat height = TTSTYLEVAR(tableFont).ttLineHeight + kTableCellVPadding*2;
  if (item.subtitle) {
    height += TTSTYLEVAR(font).ttLineHeight;
  }
  if (item.imageURL) {
    height = 60;
  }
  
  return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier
{
  self = [super initWithStyle:style reuseIdentifier:identifier];
  if (self) {
    self.textLabel.adjustsFontSizeToFitWidth = NO;
  }
  return self;
}

@end
