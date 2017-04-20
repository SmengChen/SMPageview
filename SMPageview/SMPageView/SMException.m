//
//  SMException.m
//  SMPageview
//
//  Created by chenshimeng on 17/4/20.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMException.h"

@implementation SMException
+(void)exception:(NSString*)exceptionReason info:(NSDictionary*)exceptionInfo{
    
    NSString *exceptionName = @"HFException";
    if (![exceptionReason isKindOfClass:[NSString class]]) {
        return;
    }
    if (exceptionInfo) {
        if (![exceptionInfo isKindOfClass:[NSDictionary class]]) {
            return;
        }
    }
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionInfo];
    
    @throw exception;
}


+(NSString *)checkString:(id)object{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }else{
        return @"";
    }
}


@end
