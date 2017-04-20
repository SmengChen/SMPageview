//
//  HFHomeAcitivityItem.m
//  
//
//  Created by chenshimeng on 17/3/2.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMHomeAcitivityItem.h"
#import "SMException.h"

@implementation SMHomeAcitivityItem
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.activityAddress = [SMException checkString:[dict valueForKey:@"activityAddress"]];
            
            NSString *startTime = [dict valueForKey:@"startTime"];
            if ([startTime isKindOfClass:[NSNumber class]]) {
                startTime = [NSString stringWithFormat:@"%@",startTime];
            }
            self.startTime = [SMException checkString:startTime];
            self.stringTime = [self timestampSwitchTime:self.startTime.integerValue / 1000];
            self.stringTime  = [self.stringTime stringByAppendingString:@"~"];
            
            NSString *endTime = [dict valueForKey:@"endTime"];
            if ([endTime isKindOfClass:[NSNumber class]]) {
                endTime = [NSString stringWithFormat:@"%@",endTime];
            }
            self.endTime = [SMException checkString:endTime];
            self.stringTime = [self.stringTime stringByAppendingString: [self timestampSwitchTime:self.endTime.integerValue / 1000]];
            
            self.activityDesc = [SMException checkString:[dict valueForKey:@"activityDesc"]];
            self.outUrl = [SMException checkString:[dict valueForKey:@"outUrl"]];
            self.activityImg = [SMException checkString:[dict valueForKey:@"imagePath"]];
            self.activityName = [SMException checkString:[dict valueForKey:@"activityName"]];
        }
    }
    return self;
}


-(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月d日"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

+(instancetype)homeAcitivityItemWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

@end
