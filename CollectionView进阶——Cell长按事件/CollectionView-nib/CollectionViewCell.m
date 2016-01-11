//
//  CollectionViewCell.m
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    //这里需要初始化ImageView；
    self.imageButton = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width - 32) / 2, (self.bounds.size.width - 32) / 2, 32, 32)];
    self.imageButton.tag = 100;
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 100) / 2, (self.bounds.size.width - 32) / 2 + 30, 100, 20)];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.font=[UIFont systemFontOfSize:10];
    self.descLabel.tag = 101;
    
    [self.contentView addSubview:self.imageButton];
    [self.contentView addSubview:self.descLabel];
  }
  return self;
}

@end
