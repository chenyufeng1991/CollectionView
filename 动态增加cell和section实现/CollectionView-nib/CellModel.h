//
//  CellModel.h
//  CollectionView-nib
//
//  Created by chenyufeng on 15/12/1.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

//定义cell中的图片；
@property(nonatomic,strong) NSString *cellImage;
//定义cell中的描述文字；
@property(nonatomic,strong) NSString *cellDesc;

@end
