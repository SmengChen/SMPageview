//
//  SMPageFactory.m
//  
//
//  Created by chenshimeng on 17/4/11.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMPageFactory.h"
#import "SMImageCardImageView.h"
#import "SMPageView.h"
#import "SMException.h"

#define imageCardHeight screenWidth * 125 / 350
#define screenWidth [UIScreen mainScreen].bounds.size.width
@implementation SMPageFactory

#pragma mark --banner
+(UIView *)getADKitFromAds:(NSArray *)ads
        undercarriageImage:(NSString *)image
                  savePath:(NSString *)path{
    return [SMPageFactory getADKitFromAds:ads
                                  frame:CGRectMake(0, 0, screenWidth , imageCardHeight)
                     undercarriageImage:image
                               savePath:path];
}



+(UIView *)getADKitFromAds:(NSArray *)ads
                     frame:(CGRect)frame
        undercarriageImage:(NSString *)image
                  savePath:(NSString *)path{
    if (![ads isKindOfClass:[NSArray class]]) {
        return [SMPageFactory getSigleImageView:image frame:frame ads:@[@{}]];
    }
    NSMutableArray *adDataArr = [NSMutableArray array];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = (int)ads.count - 1; i >= 0 ; i--) {
        NSDictionary *dict = ads[i];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSString *imageUrl = [SMException checkString:[dict valueForKey:@"imagePath"]];
            if (![imageUrl isEqualToString:@""]) {
                [temp addObject:imageUrl];
                [adDataArr addObject:dict];
            }
        }
    }
    [adDataArr writeToFile:[SMException checkString:path] atomically:YES];
    if (temp.count > 0) {
        if (temp.count > 1) {
            SMPageView *pageView = [[SMPageView alloc] initViewWithFrame:frame autoPlayTime:2.0f imagesArray:temp clickCallBack:^(NSInteger index) {
                NSDictionary *dictItem = adDataArr[index];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:@"" forKey:@"name"];
                [dict setValue:[SMException checkString:[dictItem valueForKey:@"url"]] forKey:@"url"];
                [dict setValue:[SMException checkString:[dictItem valueForKey:@"longDesc"]] forKey:@"longDesc"];
                NSNotification *notification =[NSNotification notificationWithName:@"SMImageViewClickNotifaication" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
            return pageView;
        }else{//一张
            return [SMPageFactory getSigleImageView:temp[0] frame:frame ads:adDataArr];;
        }
    }else{//下架
        return [SMPageFactory getSigleImageView:image frame:frame ads:@[@{}]];
    }
}

+(UIImageView *)getSigleImageView:(NSString *)placeholderImage frame:(CGRect)frame ads:(NSArray *)adDataArr{
    SMImageCardImageView *imageView = [[SMImageCardImageView alloc] initWithFrame:frame];
    SMHomeItem *item = [[SMHomeItem alloc] initWithDict:adDataArr[0]];
    item.image = [SMException checkString:placeholderImage];
    imageView.item = item;
    imageView.userInteractionEnabled = YES;
    return imageView;
}



@end
