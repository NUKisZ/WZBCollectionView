//
//  WZBCollectionView.m
//  一句话实现无线轮播
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WZBCollectionView.h"
#import "WZBCollectionViewCell.h"


#define WZBScreenW [UIScreen mainScreen].bounds.size.width
#define WZBScreenH 300

#define WZBCollectionViewCellID @"WZBCollectionViewCellID"

@interface WZBCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat timeInterVal;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) CGSize collectionViewSize;

@property (nonatomic, strong) UIPageControl *page;

@end

@implementation WZBCollectionView

+ (void)collectionViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames timeInterVal:(CGFloat)timeInterVal scrollDirection:(UICollectionViewScrollDirection)scrollDirection view:(UIView *)view{
    // 实例化流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置共同的属性  如滚动方向
    flowLayout.scrollDirection = scrollDirection;
    
    // 设置item的大小
    flowLayout.itemSize = CGSizeMake(WZBScreenW, WZBScreenH);
    
    // 设置最小行和列间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    // 设置内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 实例化collectionView
    WZBCollectionView *collectionView = [[WZBCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor = [UIColor grayColor];
    
    // 给全局属性赋值
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageName in imageNames) {
        
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    collectionView.imageArray = imageArray;
    collectionView.timeInterVal = timeInterVal;
    
    // 添加定时器
    [collectionView addTimer];
    
    UIPageControl *page = [[UIPageControl alloc] init];
    page.currentPage = 0;
    page.numberOfPages = imageArray.count;
    page.pageIndicatorTintColor = [UIColor redColor];
    page.currentPageIndicatorTintColor = [UIColor yellowColor];
    CGSize pageSize = [page sizeForNumberOfPages:imageArray.count];
    
    page.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    page.center = CGPointMake(collectionView.center.x, CGRectGetMaxY(collectionView.frame) - 20);
    [view addSubview:collectionView];
    [view addSubview:page];
    collectionView.page = page;
    collectionView.collectionViewSize = frame.size;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    //滚动条取消
    self.showsVerticalScrollIndicator = NO;
    
    self.showsHorizontalScrollIndicator = NO;
    
    //弹簧效果
    self.bounces = NO;
    
    //翻页效果
    self.pagingEnabled = YES;
    
    //设置代理和数据源
    self.dataSource = self;
    
    self.delegate = self;
    
    //注册cell 一般cell我们自定义
    [self registerClass:[WZBCollectionViewCell class] forCellWithReuseIdentifier:WZBCollectionViewCellID];
    
    self.index = 10000;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    
    //默认一开始滚动到第10000张图片的位置
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


- (void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterVal target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    self.timer = timer;
}

// 计时器的方法  自动滚动图片
- (void)scrollImage{
    // 调用计时器方法是 1.让图片索引＋＋ 2.滚动图片
    self.index++;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    self.page.currentPage = self.index%self.imageArray.count;
}

- (void)deleteTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 无限大才叫无限滚动嘛
    return 10000*1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WZBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WZBCollectionViewCellID forIndexPath:indexPath];
    
    // 取出图片赋值给cell
    [cell setupImage:self.imageArray[indexPath.row%self.imageArray.count] withImageSize:self.collectionViewSize];
    return cell;
}

// 当手指拖动图片时,停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self deleteTimer];
}

// 滚动结束后发送通知  让控制器接收通知 设置page的当前页数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.index = index;
    self.page.currentPage = self.index%self.imageArray.count;
    [self addTimer];
}
@end
