//
//  SMPageView.m
//
//
//  Created by sm on 15/1/5.
//  Copyright © 2015年 士猛. All rights reserved.
//
#import "SMPageView.h"
#import "UIImageView+WebCache.h"
#import "SMException.h"
#import "UIColor+Hex.h"

//宏定义scrollview的宽高
#define view_WIDTH self.frame.size.width
#define view_HEIGHT self.frame.size.height

@interface SMPageView () <UIScrollViewDelegate>
//scrollView
@property(nonatomic, strong) UIScrollView * scrollView;
//pageControl
@property(nonatomic, strong) UIPageControl *pageControl;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation SMPageView
{
    ///滚动的时间间隔
    NSTimeInterval _delayTime;
    ///存放3个UIImageView的数组
    NSMutableArray *_imageViews;
    //数据源
    NSArray *_imagesArray;
}



#pragma mark - 初始化轮播器控件

- (instancetype)initViewWithFrame:(CGRect)frame autoPlayTime:(NSTimeInterval)playTime imagesArray:(NSArray *)imagesArray clickCallBack:(void (^)(NSInteger))clickCallBack
{
    
    if (self = [super initWithFrame:frame]) {
        _delayTime = playTime;
        //要给block赋值,不然点击图片没有反应,block是空的,不会执行block
        self.clickBlcok = clickCallBack;
        
        [self configureDataSource:imagesArray];
        _imagesArray = imagesArray;
        
        [self creatUI];
        [self startTimer];
        
    }
    
    return self;
    
}

-(void)configureDataSource:(NSArray *)imagesArray{
    if (imagesArray.count <= 1) {
        [SMException exception:@"SMPageView数据源count必须大于1" info:nil];
    }
}

#pragma mark - 初始化scrollview/分页控件/imageview
- (void)creatUI
{
    //初始化scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(view_WIDTH * 3, view_HEIGHT);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentOffset = CGPointMake(view_WIDTH, 0);
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    
    
    //初始化imageview
    _imageViews = [NSMutableArray array];
    //创建三个imageView作为循环复用的载体，图片将循环加载在这三个imageView上面
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [self creatCell];
        imageView.frame = CGRectMake(view_WIDTH * i, 0, view_WIDTH,view_HEIGHT);
        NSInteger index = 0;
        if (i == 0) index = _imagesArray.count - 1;
        if (i == 1) index = 0;
        if (i == 2) index = 1;
        
        imageView.tag = index;
        imageView.userInteractionEnabled = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
        [imageView addGestureRecognizer:tap];
        
        //设置imageView上的image图片
        [self setImageView:imageView atIndex:index];
        //将imageView加入数组中，方便随后取用
        [_imageViews addObject:imageView];
        [self.scrollView addSubview:imageView];
        
    }
    
    
    //初始化pageControl,最后添加,这样它会显示在最前面,不会被遮挡
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 30, view_WIDTH, 30)];
    self.pageControl.numberOfPages = _imagesArray.count;
    self.pageControl.currentPage = 0;
    // 1.单页的时候是否隐藏pageControl
    self.pageControl.hidesForSinglePage = YES;
    
    // 2.设置pageControl的样式
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#44a4f8"];
    [self addSubview:self.pageControl];
    
    
}

-(UIImageView *)creatCell{
    return [[UIImageView alloc] init];;
}


// 图片轻敲手势事件
- (void)imageViewClicked:(UITapGestureRecognizer *)tap
{
    int index = (int)tap.view.tag;
    if (_clickBlcok) _clickBlcok(index);
}


- (void)setImageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    NSString *image = (NSString *)_imagesArray[index];
    [self reloadCellContent:imageView item:image];
    
}

-(void)reloadCellContent:(UIImageView *)imageView item:(NSString *)image{
    if ([image containsString:@"http"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"avatar750"] options:SDWebImageProgressiveDownload completed:nil];
    }else{
        imageView.image = [UIImage imageNamed:image];
    }
}


//定时器调用的方法
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake(view_WIDTH * 2, 0) animated:YES];
}

//停止定时器
- (void)stopTimer {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

//开启定时器
- (void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //加入NSRunLoopCommonModes运行模式,这样可以让定时器无论是在默认还是拖拽模式下都可以正常运作
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}


#pragma mark - <UIScrollViewDelegate代理方法>

//用户开始拖拽,停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    
}

//用户停止拖拽,开启定时器
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
    
}

//人为拖拽停止并且减速完全停止时会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //在已经减速结束的时候进行图片更新，pagecontrol的更新
    [self updateImageViewsAndPageControl];
}

//在调用setContentOffset方法的时候，会触发此代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //在调用setContentOffset方法的时候，会触发此代理方法（避免在定时器控制偏移量的时候不刷新UI）
    [self updateImageViewsAndPageControl];
    
}


#pragma mark - 更新图片和分页控件的当前页
- (void)updateImageViewsAndPageControl {
    //先判断出scrollview的操作行为是向左向右还是不动
    //定义一个flag,目前是让scrollview向左向右滑动的时候索引对应的+1或者-1
    int flag = 0;
    if (self.scrollView.contentOffset.x > view_WIDTH)
    {//手指向左滑动
        flag = 1;
    }
    else if (self.scrollView.contentOffset.x == 0)//原本偏移量是一个宽度,现在==0了,那么就是手指向右滑动了
    {//手指向右滑动
        flag = -1;
    }
    else
    {//除了向左向右之外就是没有移动,那么不需要任何操作，直接返回
        return;
    }
    
    for (UIImageView *imageView in _imageViews) {

        NSInteger index = imageView.tag + flag ;
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        [self setImageView:imageView atIndex:index];
    }
    self.pageControl.currentPage = [_imageViews[1] tag];
    self.scrollView.contentOffset = CGPointMake(view_WIDTH, 0);
}





//控制器销毁的时候移除定时器
- (void)dealloc {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
