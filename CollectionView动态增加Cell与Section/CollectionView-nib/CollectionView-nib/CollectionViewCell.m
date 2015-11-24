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

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    

    //这里需要初始化ImageView；
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40) / 3, (SCREEN_WIDTH - 40) / 3)];
    [self addSubview:self.imageView];
    [self.imageView setUserInteractionEnabled:true];
    
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 40) / 3, (SCREEN_WIDTH - 40) / 3, 20)];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.descLabel];
    
    
  }
  return self;
}

@end
