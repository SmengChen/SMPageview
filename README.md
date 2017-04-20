# SMPageview
轮播控件
![](https://github.com/chenshimeng/SMPageview/blob/master/轮播图片.gif)


使用方式：

    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SMPageDefaultData" ofType:@"plist"]];

    UIView *imageView = [SMPageFactory getADKitFromAds:arr undercarriageImage:@"广告1" savePath:nil];
    
    [self.view addSubview:imageView];
    
    
若想自定义轮播控件：则自定义类，继承自SMPageView。实现此抽象类的接口。

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
