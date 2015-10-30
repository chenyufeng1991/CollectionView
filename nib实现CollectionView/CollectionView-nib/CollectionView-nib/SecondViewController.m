
//
//  SecondViewController.m
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "SecondViewController.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "CollectionReusableView.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *arr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //进行CollectionView和Cell的绑定
  [self.collectionView registerClass:[CollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  
  self.arr = [[NSMutableArray alloc] initWithCapacity:10];
  for (int i = 0; i < 9; i++) {
    [self.arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i + 1]]];
  }
  
  //千万不要忘了设置delegate
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  
  
  
  
  //注册CollectionReusableView；
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
  
  
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

  return self.arr.count;
  
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
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

  
  NSString *message = [[NSString alloc] initWithFormat:@"您点击第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击确定按钮后的响应事件；
    
  }]];
  
  
  [self presentViewController:alert animated:true completion:^{

    //显示提示框后执行的事件；
    
  }];
  
  
  
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

  return CGSizeMake((UISCREEN_WIDTH - 80) / 3, (UISCREEN_WIDTH - 80) / 3 + 20);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

  return UIEdgeInsetsMake(10,20,10,20);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

  
  return CGSizeMake(self.collectionView.frame.size.width, 50);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

  return 1.f;
}




@end











