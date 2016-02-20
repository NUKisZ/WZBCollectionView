//
//  WZBCollectionViewCell.m
//  一句话实现图片无限轮播
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WZBCollectionViewCell.h"

#define WZBScreenWidth [UIScreen mainScreen].bounds.size.width

@interface WZBCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation WZBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setupImage:(UIImage *)image withImageSize:(CGSize)imageSize{
    self.imageView.image = image;
    self.imageSize = imageSize;
}

// 设置界面
- (void)setUpUI{
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.imageSize.width;
    CGFloat imageH = self.imageSize.height;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
}

@end
