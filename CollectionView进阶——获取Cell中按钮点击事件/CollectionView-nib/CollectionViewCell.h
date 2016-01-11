//
//  CollectionViewCell.h
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

//每一个cell就是一个UIView,一个cell里面包含了一个图片和文本；
//@property(nonatomic,strong)UIView *cellView;
@property(strong,nonatomic) UIButton *imageButton;
@property(strong,nonatomic) UILabel *descLabel;

@end
