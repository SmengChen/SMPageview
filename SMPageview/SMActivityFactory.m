//
//  SMctivityFactory.m
//  SMPageview
//
//  Created by chenshimeng on 17/4/20.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMActivityFactory.h"
#import "SMHomeActivityCollectionViewCell.h"
#import "SMHomeActivityCollectionView.h"
#import "SMHomeAcitivityItem.h"
#import "SMException.h"

@implementation SMActivityFactory
#pragma mark --活动日历
+(UIView *)getActicityKitFromData:(NSArray *)ads
                            frame:(CGRect)frame
                         savePath:(NSString *)path{
    if (![ads isKindOfClass:[NSArray class]]) {return [[UIView alloc] init];}
    if (ads.count == 0) {return [[UIView alloc] init];}
    if (ads.count > 1) {
        SMHomeActivityCollectionView *viewc = [[SMHomeActivityCollectionView alloc] initViewWithFrame:frame autoPlayTime:4.0 imagesArray:ads clickCallBack:^(NSInteger index) {
            SMHomeAcitivityItem *item = ads[index];
            if (![item isKindOfClass:[SMHomeAcitivityItem class]]) {
                return;
            }
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:item.activityName forKey:@"longDesc"];
            if (![item.outUrl isEqualToString:@""]) {
                [dict setValue:item.outUrl forKey:@"url"];
            }else{
                [dict setValue:@"" forKey:@"url"];
                [dict setValue:item.activityDesc forKey:@"activityDesc"];
            }
            
            NSNotification *notification =[NSNotification notificationWithName:@"SMHomeAcitivityViewClickNotifaication" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }];
        return viewc;
    }else{
        SMHomeActivityCollectionViewCell *viewc = [[NSBundle mainBundle] loadNibNamed:@"SMHomeActivityCollectionViewCell" owner:nil options:nil].firstObject;
        viewc.item = ads[0];
        viewc.frame = frame;
        viewc.autoresizingMask = UIViewAutoresizingNone;
        return viewc;
    }
}
@end
