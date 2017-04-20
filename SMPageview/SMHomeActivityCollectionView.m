//
//  SMHomeActivityCollectionView.m
//  
//
//  Created by chenshimeng on 17/3/2.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMHomeActivityCollectionView.h"
#import "SMHomeActivityCollectionViewCell.h"
#import "SMException.h"
#import "SMHomeAcitivityItem.h"


@interface SMHomeActivityCollectionView ()<UIScrollViewDelegate>

@end

@implementation SMHomeActivityCollectionView


-(void)configureDataSource:(NSArray *)imagesArray{
    for (int i = 0; i < imagesArray.count; i++) {
        SMHomeAcitivityItem *item = (SMHomeAcitivityItem *)imagesArray[i];
        if (![item isKindOfClass:[SMHomeAcitivityItem class]]) {
            [SMException exception:@"SMShopCollectionView数据源必须盛放SMHomeAcitivityItem类" info:nil];
        }
    }
    
    if (imagesArray.count <= 1) {
        [SMException exception:@"SMShopCollectionView数据源count必须大于1" info:nil];
    }
}


-(SMHomeActivityCollectionViewCell *)creatCell{
    return [[NSBundle mainBundle] loadNibNamed:@"SMHomeActivityCollectionViewCell" owner:nil options:nil].firstObject;
}



-(void)reloadCellContent:(SMHomeActivityCollectionViewCell *)imageView item:(SMHomeAcitivityItem *)item{
    imageView.item = item;
}

@end
