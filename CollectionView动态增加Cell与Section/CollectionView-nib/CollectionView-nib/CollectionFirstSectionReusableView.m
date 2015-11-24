//
//  CollectionFirstSectionReusableView.m
//  CollectionView-nib
//
//  Created by chenyufeng on 15/11/24.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionFirstSectionReusableView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation CollectionFirstSectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, 300, 20)];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 150)];
    [self.imageView setImage:[UIImage imageNamed:@"home"]];
    
    
    
    
    [self addSubview:self.title];
    [self addSubview:self.imageView];
    
    
  }
  return self;
}

@end
