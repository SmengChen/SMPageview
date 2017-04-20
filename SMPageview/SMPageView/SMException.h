//
//  SMException.h
//  SMPageview
//
//  Created by chenshimeng on 17/4/20.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMException : NSObject
+(NSString *)checkString:(id)object;
+(void)exception:(NSString*)exceptionReason info:(NSDictionary*)exceptionInfo;
@end
