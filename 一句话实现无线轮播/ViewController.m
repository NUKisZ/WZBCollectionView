//
//  ViewController.m
//  一句话实现无线轮播
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WZBCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  一句话搞定无线轮播
     *  第一个参数是collectionView的frame
     *  第二个参数是需要轮播的图片数组，数组里装的是图片名
     *  第三个是切换图片的时间，这个根据实际情况而定
     *  第四个是图片滚动方向，一般都是水平方向的，也有的是垂直
     */
    [WZBCollectionView collectionViewWithFrame:CGRectMake(0, 0, 375, 300) imageNames:@[@"1",@"2",@"3"] timeInterVal:1 scrollDirection:UICollectionViewScrollDirectionHorizontal view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
