//
//  SMctivityFactory.h
//  SMPageview
//
//  Created by chenshimeng on 17/4/20.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMPageFactory.h"

@interface SMActivityFactory : SMPageFactory
+(UIView *)getActicityKitFromData:(NSArray *)ads
                            frame:(CGRect)frame
                         savePath:(NSString *)path;
@end
