//
//  SectionModel.h
//  CollectionView-nib
//
//  Created by chenyufeng on 15/11/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject

@property(nonatomic,copy) NSString *sectionName;

@property(nonatomic,strong) NSMutableArray *cellArray;
@end
