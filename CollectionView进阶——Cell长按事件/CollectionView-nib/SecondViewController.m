
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

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *image;
@property (weak, nonatomic) IBOutlet UIButton *addButtonPressed;
//开始使用二维数组进行数据结构设计；
@property (nonatomic, strong)NSArray *defaultArray;//有defaultArray()方法；
@property (nonatomic, strong)NSMutableArray *dataArray;//有一个方法的名称也是dataArray();
//下面数组用来存放头部标题；
@property(strong,nonatomic) NSMutableArray *headerArray;

@end

@implementation SecondViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  //***动态设置collectionView/ScrollView高度；
  self.collectionView.frame = CGRectMake(0, 150, SCREEN_WIDTH, self.collectionView.frame.size.height + SCREEN_HEIGHT / 2);
  self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.collectionView.frame.size.height + SCREEN_HEIGHT / 2);
  self.addButtonPressed.frame = CGRectMake(0, self.collectionView.frame.size.height + 150, SCREEN_WIDTH, 30);
  
  //进行CollectionView和Cell的绑定
  [self.collectionView registerClass:[CollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  
  //第二个以后的Header；
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];

  //创建长按手势监听
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(myHandleTableviewCellLongPressed:)];
  longPress.minimumPressDuration = 1.0;
  //将长按手势添加到需要实现长按操作的视图里
  [self.collectionView addGestureRecognizer:longPress];
}

//长按事件的手势监听实现方法
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {

  CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {

    NSLog(@"UIGestureRecognizerStateBegan");
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
    if (indexPath == nil) {
      NSLog(@"空");
    }else{
      NSLog(@"Section = %ld,Row = %ld",(long)indexPath.section,(long)indexPath.row);
    }
  }
  if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
    NSLog(@"UIGestureRecognizerStateChanged");
  }
  if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
    NSLog(@"UIGestureRecognizerStateEnded");
  }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return [[self.dataArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
  //  cell.imageView.image = [UIImage imageNamed:[[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
  //找到cell中的button；
  UIButton *deviceImageButton = cell.imageButton;
  [deviceImageButton addTarget:self action:@selector(deviceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  //给每一个cell加边框；
  cell.layer.borderColor = [UIColor grayColor].CGColor;
  cell.layer.borderWidth = 0.3;

  [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
  cell.descLabel.text = @"文本";
  
  return cell;
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  //有多少个一维数组；
  return self.dataArray.count;
}

//加载头部标题；
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

  CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
  view.title.text = [self.headerArray objectAtIndex:indexPath.section];
  
  return view;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake((SCREEN_WIDTH) / 3, (SCREEN_WIDTH) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  return UIEdgeInsetsMake(0,0,0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  return CGSizeMake(self.collectionView.frame.size.width, SCREEN_HEIGHT / 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  return 0;
}

#pragma mark -- Lazy Load 懒加载
//要添加的图片从这里面选；
//这里进行的是懒加载，要先去判断，没有的话才去进行实例化；
- (NSArray *)defaultArray{
  if (!_defaultArray){
    
    NSArray *firstRowDefault = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",nil];
    NSArray *secondRowDefault = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",nil];
    self.defaultArray = [[NSArray alloc] initWithObjects:firstRowDefault,secondRowDefault, nil];
  }
  return _defaultArray;
}

- (NSMutableArray *)dataArray{
  if (!_dataArray){
    
    NSMutableArray *firstRow = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
    NSMutableArray *secondRow = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:firstRow,secondRow, nil];
  }
  return _dataArray;
}

//这里标题的添加也使用懒加载；
- (NSMutableArray *)headerArray{
  if (!_headerArray) {
    self.headerArray = [[NSMutableArray alloc] initWithObjects:@"第一个",@"第二个", nil];
  }
  return _headerArray;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  if ((indexPath.row == ([[self.dataArray objectAtIndex:indexPath.section] count] - 1))) {

      NSLog(@"添加操作");
    NSString *tempImageName = @"1";
    //每当增加一个cell同时增加一行的时候，CollectionView和ScrollView高度和位置要发生变化；button的位置要发生变化；
    if (indexPath.row % 3 == 2 && indexPath.row != 2) {
      
      //***重新设置collectionView的高度；
      self.collectionView.frame = CGRectMake(0, 150, SCREEN_WIDTH, self.collectionView.frame.size.height+ (SCREEN_WIDTH / 3) );
      //重新设置scrollView的高度
      self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.collectionView.frame.size.height + (SCREEN_WIDTH / 3) * 2);
      //重新设置button的位置；
      self.addButtonPressed.frame = CGRectMake(0, self.collectionView.frame.size.height + 150, SCREEN_WIDTH, 30);
    }else{
      //不用更新UI；
    }
    //这里需要在最后一个位置增加设备；
    [[self.dataArray objectAtIndex:indexPath.section] insertObject:tempImageName atIndex:[[self.dataArray objectAtIndex:indexPath.section] count]-1];
    [self.collectionView reloadData];
    
  }else{
    NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
  }
}

#pragma mark - 点击按钮操作
- (void)deviceButtonPressed:(id)sender{

  UIView *v = [sender superview];//获取父类view
  CollectionViewCell *cell = (CollectionViewCell *)[v superview];//获取cell
  NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];//获取cell对应的indexpath;
  NSLog(@"设备图片按钮被点击:%ld        %ld",(long)indexpath.section,(long)indexpath.row);
}

#pragma mark - 添加环境的按钮
- (IBAction)addEnvirnmentClick:(id)sender {
  
  NSMutableArray *addRow = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
  [self.dataArray insertObject:addRow atIndex:[self.dataArray count]];
  //  [self.collectionView reloadData];
  [self popEnvirnmentNameDialog];
}

#pragma mark - 弹出输入环境名称的提示框
- (void)popEnvirnmentNameDialog{
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入Section名称" preferredStyle:UIAlertControllerStyleAlert];
  //以下方法就可以实现在提示框中输入文本；
  [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
    //插入到headerArray数组中
    [self.headerArray insertObject:envirnmentNameTextField.text atIndex:self.headerArray.count];
    //此时更新界面；
    [self.collectionView reloadData];
    //*** 重新设置collectionView的高度；
    self.collectionView.frame = CGRectMake(0, 150, SCREEN_WIDTH, self.collectionView.frame.size.height + (SCREEN_WIDTH / 3) * 2 + SCREEN_HEIGHT / 10 );
    //重新设置scrollView的高度,这个是正确的；
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.collectionView.frame.size.height + (SCREEN_WIDTH / 3) * 2);
    //重新设置button的位置；
    self.addButtonPressed.frame = CGRectMake(0, self.collectionView.frame.size.height + 150 , SCREEN_WIDTH, 30);
    NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
  }]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"请输入Section名称";
  }];
  [self presentViewController:alertController animated:true completion:nil];
}

@end
