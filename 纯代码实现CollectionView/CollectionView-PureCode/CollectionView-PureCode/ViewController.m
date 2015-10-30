//
//  ViewController.m
//  CollectionView-PureCode
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "CollectionReusableView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic) UICollectionView *collectionView;

@property(strong,nonatomic) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //不要忘记初始化；
  self.arr = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < 9; i++) {
    [self.arr addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%d",i + 1]]];
  }
  

  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
  [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];
  
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.collectionView];
  
 
  
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  
  
  
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
  
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

  return self.arr.count;
  
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
  
  cell.imageView.image = [self.arr objectAtIndex:indexPath.row];
  cell.descLabel.text = [[NSString alloc] initWithFormat:@"{%ld,%ld}",indexPath.section,indexPath.row];
  
  return cell;
  
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

  return 3;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

  UICollectionReusableView *reusable = nil;
  
  if (kind == UICollectionElementKindSectionHeader) {
    CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    view.title.text = [[NSString alloc] initWithFormat:@"头部视图%ld",indexPath.section];
    reusable = view;
  }
  
  return reusable;
  
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

  NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击确定后执行的操作；
  }]];
  
  [self presentViewController:alert animated:true completion:^{
    //显示提示框后执行的事件；
  }];
  
}



#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3 + 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

  return UIEdgeInsetsMake(20, 20, 10, 20);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

  return CGSizeMake(300, 20);
}

/*

 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 */

@end

