//
//  RoundedCornerButton.h
//  RoundedCornerButtonDemo
//
//  Created by Noah on 17/7/20.
//  Copyright © 2017年 No. All rights reserved.
//

#import <UIKit/UIKit.h>

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
