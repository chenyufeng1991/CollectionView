//
//  CollectionViewCell.h
//  CollectionView-nib
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

//cell中的图片；
@property(strong,nonatomic) UIImageView *imageView;
//cell中的描述文本；
@property(strong,nonatomic) UILabel *descLabel;
//cell右上角的删除按钮；
@property(nonatomic,strong)UIButton *deleteButton;
@end


