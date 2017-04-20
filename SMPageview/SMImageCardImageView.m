//
//  SMImageCardImageView.m
//  
//
//  Created by chenshimeng on 17/1/17.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMImageCardImageView.h"
#import "UIImageView+WebCache.h"

@implementation SMImageCardImageView

-(void)setItem:(SMHomeItem *)item{
    _item = item;
    if ([item.image containsString:@"http"]) {
        UIImage *placeholderImage;
        if ([self.placeholderImage isKindOfClass:[UIImage class]]) {
            placeholderImage = self.placeholderImage;
        }else{
            placeholderImage = [UIImage imageNamed:@"avatar750"] ;
        }
        [self sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:placeholderImage options:SDWebImageProgressiveDownload completed:nil];
    }else{
        UIImage *image =  [UIImage imageNamed:item.image];
        if ([image isKindOfClass:[UIImage class]]) {
            self.image = image;
        }else{
            if ([self.placeholderImage isKindOfClass:[UIImage class]]) {
                self.image = self.placeholderImage;
            }else{
                self.image = [UIImage imageNamed:@"avatar750"] ;
            }
        }
    }
    UITapGestureRecognizer *ger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
    [self addGestureRecognizer:ger];
}


// 图片轻敲手势事件
- (void)imageViewClicked:(UITapGestureRecognizer *)tap
{
    SMImageCardImageView *view = (SMImageCardImageView *)tap.view;
    SMHomeItem *item = view.item;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:item.name forKey:@"name"];
    [dict setValue:item.url forKey:@"url"];
    [dict setValue:item.longDesc forKey:@"longDesc"];
    NSNotification *notification =[NSNotification notificationWithName:@"SMImageViewClickNotifaication" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
