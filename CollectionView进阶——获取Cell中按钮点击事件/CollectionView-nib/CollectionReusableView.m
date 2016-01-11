
//
//  CollectionReusableView.m
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionReusableView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 20, SCREEN_WIDTH, SCREEN_HEIGHT / 20)];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
  }
  return self;
}

@end
