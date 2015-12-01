
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

#import "SectionModel.h"
#import "CellModel.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

NS_ENUM(NSInteger,CellState){
  
  NormalState,
  DeleteState
  
};


@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,assign) enum CellState;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

//下面数组用来存放头部标题；
@property(strong,nonatomic) NSMutableArray *headerArray;

@property (nonatomic,strong) SectionModel *section;
@property (nonatomic,strong) NSMutableArray *dataSectionArray;//里面存放section对象，模型由SectionModel定义；
@property (nonatomic,strong) NSMutableArray *dataCellArray;

@property(nonatomic,strong) NSMutableArray *cellImageArr;
@property(nonatomic,strong) NSMutableArray *cellDescArr;


@end

@implementation SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //进行CollectionView和Cell的绑定
  [self.collectionView registerClass:[CollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  
  //加入头部视图；
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
  
  //一开始是正常状态；
  CellState = NormalState;
  
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  SectionModel *sec = [self.dataSectionArray objectAtIndex:section];
  
  return  sec.cellArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
  
//  SectionModel *sec = self.dataSectionArray[indexPath.section];
//  CellModel *cel = sec.cellArray[indexPath.row];
  
  
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
  CellModel *cel = [sec.cellArray objectAtIndex:indexPath.row];

  //要用的数据都从模型中取出来；
  cell.imageView.image = [UIImage imageNamed:cel.cellImage];
  cell.descLabel.text = cel.cellDesc;

  
  //设置close按钮
  // 点击编辑按钮触发事件
  if(CellState == NormalState)
  {
    //正常情况下，所有删除按钮都隐藏；
    cell.deleteButton.hidden = YES;
  }
  else{
    //编辑情况下：
    SectionModel *section = self.dataSectionArray[indexPath.section];
    if (indexPath.row != section.cellArray.count - 1)
    {
      cell.deleteButton.hidden = NO;
    }
    else
    {
      //最后一个是添加按钮，所以隐藏右上角的删除按钮；
      cell.deleteButton.hidden = YES;
    }
  }
  [cell.deleteButton addTarget:self action:@selector(deleteCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  return cell;
  
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  //有多少个一维数组；
  return self.dataSectionArray.count;
}

//加载头部标题；
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
  CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
  
  //就打印出当前section的值；
  view.title.text = [self.headerArray objectAtIndex:indexPath.section];
  
  return view;
  
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  return CGSizeMake((UISCREEN_WIDTH - 40) / 3, (UISCREEN_WIDTH - 40) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  
  return UIEdgeInsetsMake(0,20,0,20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  
  return CGSizeMake(self.collectionView.frame.size.width, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
  
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  
  return 0;
}

#pragma mark -- Lazy Load 懒加载
//要添加的图片从这里面选；
//这里进行的是懒加载，要先去判断，没有的话才去进行实例化;

- (NSMutableArray *)dataSectionArray{
  if (!_dataSectionArray){
    
    NSLog(@"1111111111111111");
    
    _dataSectionArray = [[NSMutableArray alloc] initWithCapacity:2];//1个；
    
    for (int i = 0; i < 2; i++) {
      _dataCellArray = [[NSMutableArray alloc] initWithCapacity:6];//2个；
      
      for (int j = 0; j < 6; j++) {
        CellModel *cellModel = [[CellModel alloc] init];
        cellModel.cellImage = self.cellImageArr[j];
        cellModel.cellDesc = self.cellDescArr[j];
        
        [_dataCellArray addObject:cellModel];
      }//for;
      
      SectionModel *sectionModel = [[SectionModel alloc] init];
      sectionModel.sectionName = self.headerArray[i];
      sectionModel.cellArray = _dataCellArray;
      
      [_dataSectionArray addObject:sectionModel];
    }//for;
    
  }
  
  return _dataSectionArray;
}

//这里标题的添加也使用懒加载；
- (NSMutableArray *)headerArray{
  
  if (!_headerArray) {
    self.headerArray = [[NSMutableArray alloc] initWithObjects:@"第一个",@"第二个", nil];
  }
  
  return _headerArray;
}

- (NSMutableArray *)cellImageArr{

  if (!_cellImageArr) {
    self.cellImageArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
  }
  
  return _cellImageArr;
}

- (NSMutableArray *)cellDescArr{

  if (!_cellDescArr) {
    self.cellDescArr = [[NSMutableArray alloc] initWithObjects:@"第0个",@"第1个",@"第2个",@"第3个",@"第4个",@"添加",nil];
  }
  
  return _cellDescArr;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  //取出是某一个section；
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
  
  if ((indexPath.row == sec.cellArray.count - 1)) {
    NSLog(@"点击最后一个cell，执行添加操作");
    
    
    CellModel *cel = [[CellModel alloc] init];
    cel.cellImage = @"1";
    cel.cellDesc = @"再来一个";

    self.dataCellArray = sec.cellArray;
    
    [self.dataCellArray insertObject:cel atIndex:self.dataCellArray.count - 1];
    
    [self.collectionView reloadData];
    
  }else{
    NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
  }
  
}

#pragma mark - 添加环境的按钮
- (IBAction)addEnvirnmentClick:(id)sender {
  
  self.dataCellArray = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < 6; i++) {
    
    CellModel *cell = [[CellModel alloc] init];
    cell.cellDesc = self.cellDescArr[i];
    cell.cellImage = self.cellImageArr[i];
    
    [self.dataCellArray addObject:cell];
    
  }
  
  [self popEnvirnmentNameDialog];
  
}

#pragma mark - 弹出输入环境名称的提示框
- (void)popEnvirnmentNameDialog{
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入Section名称" preferredStyle:UIAlertControllerStyleAlert];
  //以下方法就可以实现在提示框中输入文本；
  [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
    
    SectionModel *sec = [[SectionModel alloc] init];
    sec.sectionName = envirnmentNameTextField.text;
    sec.cellArray = self.dataCellArray;
    [self.dataSectionArray addObject:sec];
    
    
    [self.headerArray addObject:envirnmentNameTextField.text];
    
    [self.collectionView reloadData];
    
    NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
    
  }]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"请输入Section名称";
  }];
  [self presentViewController:alertController animated:true completion:nil];
  
}


- (IBAction)editButtonPressed:(id)sender {
  
  if (CellState == NormalState) {
    
    CellState = DeleteState;
    self.editButton.titleLabel.text = @"完成";
    
    for(CollectionViewCell *cell in self.collectionView.visibleCells)
    {
      NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
      SectionModel *section = self.dataSectionArray[indexPath.section];
      
      if (indexPath.row != section.cellArray.count - 1){
        [cell.deleteButton setHidden:false];
      }
    }
    
    
  }
  else if (CellState == DeleteState){
    
    CellState = NormalState;
    self.editButton.titleLabel.text = @"编辑";
  }
  [self.collectionView reloadData];
  
}

- (void)deleteCellButtonPressed: (id)sender
{
  CollectionViewCell *cell = (CollectionViewCell *)[sender superview];//获取cell
  
  NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];//获取cell对应的indexpath;
  
  //删除cell；
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexpath.section];
  [sec.cellArray removeObjectAtIndex:indexpath.row];
  
  [self.collectionView reloadData];
  
  
  NSLog(@"删除按钮，section:%ld ,   row: %ld",(long)indexpath.section,(long)indexpath.row);
}

@end











