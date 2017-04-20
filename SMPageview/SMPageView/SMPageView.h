//
//  SMPageView.h
//
//
//  Created by sm on 15/1/5.
//  Copyright © 2015年 士猛. All rights reserved.
//  使用方式请遵循生命周期：1、创建轮播器；2、自定义cell；3、刷新
//  注意事项： (1)数据源必须大于等于2，不然抛异常。(2)一个和多个不同的机制，具体实现请参照源码

#import <UIKit/UIKit.h>

typedef void (^clickCallBack) (NSInteger index);
@interface SMPageView : UIView

/** 点击图片回调的block */
@property (nonatomic, copy) clickCallBack clickBlcok;

//创建轮播器，其中imagesArray.conut>=2
- (instancetype)initViewWithFrame:(CGRect)frame
                     autoPlayTime:(NSTimeInterval)playTime
                      imagesArray:(NSArray *)imagesArray
                    clickCallBack:(clickCallBack)clickCallBack;

//轮播器的自定义控件，默认UIImageView
-(UIImageView *)creatCell;

//仅供校验数据源
-(void)configureDataSource:(NSArray *)imagesArray;

//自定义控件刷新，默认给UIImageView的image属性赋值
-(void)reloadCellContent:(UIImageView *)imageView item:(NSString *)image;
@end
