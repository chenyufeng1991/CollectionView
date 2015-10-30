
//
//  CollectionViewCell.m
//  CollectionView-PureCode
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3)];
    [self.imageView setUserInteractionEnabled:true];
    [self addSubview:self.imageView];
    
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3, 20)];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.descLabel];
    

  }
  return self;
}


@end
