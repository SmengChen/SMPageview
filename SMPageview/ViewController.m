//
//  ViewController.m
//  SMPageview
//
//  Created by chenshimeng on 17/4/20.
//  Copyright © 2017年 士猛. All rights reserved.
//

#import "ViewController.h"
#import "SMPageFactory.h"
#import "SMActivityFactory.h"
#import "SMHomeAcitivityItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPage];
    [self setupActivityPage];
    [self addObserver];
}

-(void)addObserver{
    //imageView的点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewClick:) name:@"SMImageViewClickNotifaication" object:nil];
    
    
    //活动的点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewClick:) name:@"SMHomeAcitivityViewClickNotifaication" object:nil];
}


- (void)setupDefaultPage {
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMPageDefaultData" ofType:@"plist"]];
    UIView *imageView = [SMPageFactory getADKitFromAds:arr undercarriageImage:@"广告1" savePath:nil];
    [self.view addSubview:imageView];
}


- (void)setupActivityPage {
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMPageActivityData" ofType:@"plist"]];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dict = arr[i];
        if([dict isKindOfClass:[NSDictionary class]]){
            SMHomeAcitivityItem *item = [SMHomeAcitivityItem homeAcitivityItemWithDict:dict];
            [items addObject:item];
        }
    }
    UIView *viewc = [SMActivityFactory getActicityKitFromData:items frame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 120) savePath:nil];
    [self.view addSubview:viewc];
}

-(void)imageViewClick:(NSNotification *)dic{
    NSMutableDictionary *data = (NSMutableDictionary *)dic.userInfo;
    NSLog(@"%@",data);
}
@end
