
//
//  CollectionReusableView.m
//  CollectionView-Storyboard
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {

    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    self.title.textColor = [UIColor blackColor];
    [self addSubview:self.title];
  }
  return self;
}

@end
