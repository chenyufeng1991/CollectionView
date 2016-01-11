//
//  ViewController.m
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property(strong,nonatomic) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 20)];
  [self.button setTitle:@"跳转到CollectionView" forState:UIControlStateNormal];
  [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.button setUserInteractionEnabled:true];
  [self.view addSubview:self.button];
  
  [self.button addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)clickButton:(id)sender{

  [self presentViewController:[[SecondViewController alloc] init] animated:true completion:^{
    //跳转完成后执行的操作；
  }];
}

@end
