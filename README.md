# WZBCollectionView
一句话实现图片无限轮播

![image](https://github.com/WZBbiao/WZBCollectionView/blob/master/01.png?raw=true)
 
使用方法：
导入头文件

#import "WZBCollectionView.h"

实现一句话方法

```
/**
     *  一句话搞定无线轮播
     *  第一个参数是collectionView的frame
     *  第二个参数是需要轮播的图片数组，数组里装的是图片名
     *  第三个是切换图片的时间，这个根据实际情况而定
     *  第四个是图片滚动方向，一般都是水平方向的，也有的是垂直
     */
    [WZBCollectionView collectionViewWithFrame:CGRectMake(0, 0, 375, 300) imageNames:@[@"1",@"2",@"3"] timeInterVal:1 scrollDirection:UICollectionViewScrollDirectionHorizontal view:self.view];
```


 您还可以加入我们的群，大家庭期待您的加入！
 
 ![image](https://raw.githubusercontent.com/WZBbiao/WZBSwitch/master/IMG_1850.JPG)
