# SMPageview
轮播控件
![](https://github.com/chenshimeng/SMPageview/blob/master/轮播图片.gif)


（1）简单使用方式：

    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMPageDefaultData" ofType:@"plist"]];

    UIView *imageView = [SMPageFactory getADKitFromAds:arr undercarriageImage:@"广告1" savePath:nil];
    
    [self.view addSubview:imageView];
    
    
（2）自定义轮播控件方式，则：1、自定义类，继承自SMPageView。实现此抽象类的接口。

    @interface SMHomeActivityCollectionView : SMPageView

    @end

    @implementation SMHomeActivityCollectionView


    -(void)configureDataSource:(NSArray *)imagesArray{
     for (int i = 0; i < imagesArray.count; i++) {
            SMHomeAcitivityItem *item = (SMHomeAcitivityItem *)imagesArray[i];
           if (![item isKindOfClass:[SMHomeAcitivityItem class]]) {
             [SMException exception:@"SMShopCollectionView数据源必须盛放SMHomeAcitivityItem类" info:nil];
          }
       }
    
     if (imagesArray.count <= 1) {
         [SMException exception:@"SMShopCollectionView数据源count必须大于1" info:nil];
     }
    }


    -(SMHomeActivityCollectionViewCell *)creatCell{
       return [[NSBundle mainBundle] loadNibNamed:@"SMHomeActivityCollectionViewCell" owner:nil options:nil].firstObject;
    }



    -(void)reloadCellContent:(SMHomeActivityCollectionViewCell *)imageView item:(SMHomeAcitivityItem *)item{
     imageView.item = item;
    }

    @end
    
  2、自定义工厂类
  
      @interface SMActivityFactory : SMPageFactory
        +(UIView *)getActicityKitFromData:(NSArray *)ads
                            frame:(CGRect)frame
                         savePath:(NSString *)path;
        @end

       @implementation SMActivityFactory

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
         
  在外界使用
  
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
