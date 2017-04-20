//
//  UIColor+Hex.h
//  颜色常识
//
//  Created by sm on 15/12/15.
//  Copyright © 2015年 sm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

 /*
 *传入十六进制字符串，支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *输出颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
