# RoundedCornerButton
给Button添加特定个数的圆角

#### 前言
写代码的时候遇到一个问题，需要给一个按钮设置左边两个圆角，右边为直角，网上找了一些资料，发现有些确实是可以自定义圆角的位置的。

比如：大部分资料都是，`使用UIBezierPath和CAShapeLayer来设置view的mask`
```
UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120,10,80,80)];
view2.backgroundColor = [UIColor redColor];
[self.view addSubview:view2];

UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];

CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
maskLayer.frame = view2.bounds;
maskLayer.path = maskPath.CGPath;
view2.layer.mask = maskLayer;

```
但是有一点，我在项目中是使用[Masonry](https://github.com/SnapKit/Masonry)来添加约束的，前面代码有效果的前提是：**view的frame需要在添加之前就确定下来！**，而Masonry则是使用block回调来约束的，所以:***使用Masonry的UI代码，上面的是没有效果的！！！***

经过查阅资料，原来：
**使用masonry的实质还是调用了ios7以后的`autolayout`，如果要更新frame，需要调用`layoutIfNeeded`函数进行布局，然后所约束的控件才会按照约束条件，生成当前布局相应的frame和bounds。这样就可以利用这两个属性来进行图片圆角剪裁。而调用layoutIfNeeded的目的是让系统调用layoutSubviews方法，我们也可以直接在这个方法里获取frame，因为这时候开始layout subviews，Masonry已经计算出了真实的frame。**
所以，上面的代码，如果使用Masonry,则要改成：
```
UIView *view2 = [[UIView alloc]init];
view2.backgroundColor = [UIColor redColor];
[self.view addSubview:view2];
[view2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(100, 40));
    make.left.equalTo(self.view).offset(100);
    make.top.equalTo(self.view).offset(100);
}];

//调用此方法，后面代码才会起作用
[view2 layoutIfNeeded];

UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];

CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
maskLayer.frame = view2.bounds;
maskLayer.path = maskPath.CGPath;
view2.layer.mask = maskLayer;
```

其实，实际中的我的代码是这样的：
```
    self.plusBtn = [WDTools createButtonWithTitle:@"+" frame:CGRectZero target:self selector:@selector(plusAction)];
    [self addSubview:self.plusBtn];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.35);
    }];
    [self.plusBtn layoutIfNeeded];
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.plusBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.plusBtn.bounds;
    maskLayer2.path = maskPath2.CGPath;
    
    self.plusBtn.layer.mask = maskLayer2;
    self.plusBtn.layer.borderColor = DDColorRandom.CGColor;
    self.plusBtn.layer.borderWidth = 2;
```
但是效果呢？
![这里写图片描述](http://img.blog.csdn.net/20170720233014945?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd3d3d3d3d3d3d3d3ZGk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
可以看出，我是想要给这个按钮添加一个Border的，但是用了上述的方法，***并不能达到我要的效果！！！*** 

*如果有知道的大神们，也请给个指点！谢谢！*

#### 结果
我就怒从心头起，恶向胆边生，于是我就自己写了一个Button的子类.
看效果吧！
![这里写图片描述](http://img.blog.csdn.net/20170720233446917?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd3d3d3d3d3d3d3d3ZGk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
    RoundedCornerButton *test = [[RoundedCornerButton alloc]init];
    [test setTitle:@"-" forState:UIControlStateNormal];
    test.direction = kCornerDirectionTopLeft | kCornerDirectionBottomLeft;
    test.roundedCornerRadius = 5.f;
    test.strokeWidth = 1.f;
    test.strokeColor = DDColorRandom;
    test.backgroundColor = DDColorRandom;
    [test addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:test];
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(40);
    }];
```
显然，我这里同时设置了边框的颜色，和背景色，但是这两个是不会产生影响的。

```
typedef NS_ENUM(NSInteger,CornerDirection) {
    kCornerDirectionTopLeft     = 1 << 0,
    kCornerDirectionTopRight    = 1 << 1,
    kCornerDirectionBottomLeft  = 1 << 2,
    kCornerDirectionBottomRight = 1 << 3,
};

@interface RoundedCornerButton : UIButton
//圆角方向
@property (assign, nonatomic) CornerDirection direction;
//圆角半径
@property (assign, nonatomic) CGFloat roundedCornerRadius;
//边线宽度
@property (assign, nonatomic) CGFloat strokeWidth;
//边线颜色
@property (strong, nonatomic) UIColor *strokeColor;

@end
```
接口方面，不能再简单，就不多说了，
这里传到[Github](https://github.com/WooNoah/RoundedCornerButton)上,感觉有帮助的请给个star! 谢谢！

#### PS
这里还有一个以前写的类似的[设置按钮背景色为渐变色](https://github.com/WooNoah/GradientCategory)的，还有一个[给View添加指定数量的border](https://github.com/WooNoah/SpecificBorderToView)的，有需要的可以看一下。
