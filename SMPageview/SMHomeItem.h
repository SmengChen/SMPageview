//
//  SMHomeItem.h
//  
//
//  Created by chenshimeng on 17/1/16.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHomeItem : NSObject
@property(nonatomic, strong) NSString *memo;
@property(nonatomic, strong) NSString *model_pkno;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *subName;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *longDesc;//适配广告
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)homeItemWithDict:(NSDictionary *)dict;
@end
