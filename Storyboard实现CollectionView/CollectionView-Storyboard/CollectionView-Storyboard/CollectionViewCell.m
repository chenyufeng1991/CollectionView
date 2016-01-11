//
//  CollectionViewCell.m
//  CollectionView-Storyboard
//
//  Created by chenyufeng on 15/10/29.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionViewCell.h"
#import "AppDelegate.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    //initial;
    //在这里我设置图片的大小，我设置成正方形；
    self.imageView.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 80)/3, (SCREEN_WIDTH - 80)/3);
  }
  return self;
}

@end
