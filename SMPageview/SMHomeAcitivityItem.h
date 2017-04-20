//
//  SMHomeAcitivityItem.h
//  
//
//  Created by chenshimeng on 17/3/2.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHomeAcitivityItem : NSObject
@property(nonatomic, copy) NSString *activityAddress;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *stringTime;
@property(nonatomic, copy) NSString *activityDesc;
@property(nonatomic, copy) NSString *outUrl;
@property(nonatomic, copy) NSString *activityImg;
@property(nonatomic, copy) NSString *activityName;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)homeAcitivityItemWithDict:(NSDictionary *)dict;
@end
