//
//  SMHomeItem.m
//  
//
//  Created by chenshimeng on 17/1/16.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "SMHomeItem.h"
#import "SMException.h"

@implementation SMHomeItem

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.memo = [SMException checkString:[dict valueForKey:@"memo"]];
            self.model_pkno = [SMException checkString:[dict valueForKey:@"model_pkno"]];
            self.name = [SMException checkString:[dict valueForKey:@"name"]];
            self.subName =  [SMException checkString:[dict valueForKey:@"subName"]];
            self.image = [SMException checkString:[dict valueForKey:@"image"]];
            self.url = [SMException checkString:[dict valueForKey:@"url"]];
            
            self.longDesc = [SMException checkString:[dict valueForKey:@"longDesc"]];
        }
    }
    return self;
}

+(instancetype)homeItemWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


/*
 //广告
 {
 advertisingPkno = "eaefdaf7-feb6-42f5-8222-fdefdc04bf59";
 advertisingTime = "2017-02-28 17:10";
 completeImgUrl = "http://ulife.be-linker.com/cb/data2/var/upload/imgs/advertising/1479719683962.png";
 imagePath = "http://ulife.be-linker.com/cb/showImage.do?imgAddress=/data2/var/upload/imgs/advertising/1479719683962.png";
 img = "1479719683962.png";
 inputTime = "2016-11-21 17:14";
 isdeleteFlag = N;
 isupdown = N;
 longDesc = "\U6807\U51c6\U5e7f\U544a194";
 url = "";
 }
 */


/*
 {
 image = "http://appimage.huafatech.com/data2/var/upload/imgs/functionCard/1490173863546.png";
 memo = "";
 modulePkno = undefined;
 name = "\U4f18\U7ba1\U5bb6";
 subName = "\U4f18\U7ba1\U5bb6";
 url = "class:/cn/blk/app/guanjia";
 }
 */
@end
