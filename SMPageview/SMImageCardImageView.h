//
//  SMImageCardImageView.h
//  
//
//  Created by chenshimeng on 17/1/17.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMHomeItem.h"

@interface SMImageCardImageView : UIImageView
@property(nonatomic,strong) SMHomeItem *item;
@property(nonatomic,strong) UIImage *placeholderImage;
@end
