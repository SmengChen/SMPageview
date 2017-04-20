//
//  SMPageFactory.h
//  
//
//  Created by chenshimeng on 17/4/11.
//  Copyright © 2017年 士猛. All rights reserved.
//  注意事项：(1)AD数据源item必须为包含@{@"imagePath":image,@"url":@"..."}的数组，若url为空，不跳转，若有值，则在下发给首页进行跳转。

#import <UIKit/UIKit.h>

@interface SMPageFactory : NSObject
+(UIView *)getADKitFromAds:(NSArray *)ads
            undercarriageImage:(NSString *)image
                            savePath:(NSString *)path;

+(UIView *)getADKitFromAds:(NSArray *)ads
                                frame:(CGRect)frame
            undercarriageImage:(NSString *)image
                            savePath:(NSString *)path;

@end
