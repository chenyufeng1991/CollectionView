//
//  ViewController.m
//  CollectionView-Storyboard
//
//  Created by chenyufeng on 15/10/29.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "CollectionReusableView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(strong,nonatomic) NSMutableArray *arr;
@property(strong,nonatomic)CollectionReusableView *header;

@end

@implementation ViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  self.arr = [[NSMutableArray alloc] initWithCapacity:10];
  for (int i = 0 ; i < 9; i++) {
    [self.arr addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%d",i + 1]]];
  }
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Reusable"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  NSString *collectionCellIdentifier = @"MyCollectionCell";
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
  cell.imageView.image = [self.arr objectAtIndex:indexPath.row];
  return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 3;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

  UICollectionReusableView *reusableView = nil;
  if (kind == UICollectionElementKindSectionHeader) {
    self.header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Reusable" forIndexPath:indexPath];
    self.header.title.text = [[NSString alloc] initWithFormat:@"头部视图%ld",(long)indexPath.section ];
    
    reusableView = self.header;
  }
  return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  NSLog(@"第%ld个section，第%ld个cell被点击了",(long)indexPath.section,(long)indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
  return 10;
}

//下面的回调是必须的；
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  return CGSizeMake(200, 20);
}

@end
