//
//  WZBCollectionView.h
//  一句话实现无线轮播
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZBCollectionView : UICollectionView

// 提供给外界的方法
+ (void)collectionViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames timeInterVal:(CGFloat)timeInterVal scrollDirection:(UICollectionViewScrollDirection)scrollDirection view:(UIView *)view;
@end
