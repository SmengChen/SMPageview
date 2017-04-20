//
//  SMHomeActivityCollectionViewCell.m
//  
//
//  Created by chenshimeng on 17/3/2.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMHomeActivityCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SMHomeAcitivityItem.h"

@interface SMHomeActivityCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation SMHomeActivityCollectionViewCell

-(void)setItem:(SMHomeAcitivityItem *)item{
    _item = item;
    self.titleLabel.text = item.activityName;
    [self.imageV  sd_setImageWithURL:[NSURL URLWithString:item.activityImg] placeholderImage:[UIImage imageNamed:@"avatar64"] options:SDWebImageProgressiveDownload completed:nil];
    self.timeLabel.text = item.stringTime;
    self.locationLabel.text = item.activityAddress;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellclick)];
    [self addGestureRecognizer:ges];
}


-(void)cellclick{
    SMHomeAcitivityItem *item = self.item;
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
}


@end
