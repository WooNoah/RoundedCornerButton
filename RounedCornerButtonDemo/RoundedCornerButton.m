//
//  RoundedCornerButton.m
//  RoundedCornerButtonDemo
//
//  Created by Noah on 17/7/20.
//  Copyright © 2017年 No. All rights reserved.
//

#import "RoundedCornerButton.h"

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@implementation RoundedCornerButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 0);
    
    if (self.direction == kCornerDirectionTopLeft) {
        //左上
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
        
    }else if (self.direction == kCornerDirectionTopRight) {
        //右上
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
        
    }else if (self.direction == kCornerDirectionBottomLeft) {
        //左下
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
    }else if (self.direction == kCornerDirectionBottomRight) {
        //右下
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionBottomLeft)) {
        //左边两个
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
        
    }else if (self.direction == (kCornerDirectionBottomRight | kCornerDirectionTopRight)) {
        //右边两个
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionTopRight)) {
        //上面2个
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionBottomLeft | kCornerDirectionBottomRight)) {
        //下面2个
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionBottomRight)) {
        //左上and右下
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionBottomLeft | kCornerDirectionTopRight)) {
        //左下and右上
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
        
    }else if (self.direction == (kCornerDirectionBottomRight | kCornerDirectionTopRight | kCornerDirectionBottomLeft)) {
        //左上 不是
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionBottomLeft | kCornerDirectionBottomRight)) {
        //右上 不是
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, 0);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionTopRight | kCornerDirectionBottomRight)) {
        //左下 不是
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI_2, 0, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
    }else if (self.direction == (kCornerDirectionTopLeft | kCornerDirectionTopRight | kCornerDirectionBottomLeft)) {
        //右下 不是
        CGContextMoveToPoint(ctx, 0, self.roundedCornerRadius);
        CGContextAddLineToPoint(ctx, 0, rect.size.height - self.roundedCornerRadius);
        CGContextAddArc(ctx, self.roundedCornerRadius, rect.size.height - self.roundedCornerRadius, self.roundedCornerRadius, M_PI, M_PI_2, 1);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, self.roundedCornerRadius);
        CGContextAddArc(ctx, rect.size.width - self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 0, -M_PI_2, 1);
        CGContextAddLineToPoint(ctx, self.roundedCornerRadius, 0);
        CGContextAddArc(ctx, self.roundedCornerRadius, self.roundedCornerRadius, self.roundedCornerRadius, 3 * M_PI_2, M_PI, 1);
        CGContextClosePath(ctx);
    }else {
        ViewBorderRadius(self, self.roundedCornerRadius, self.strokeWidth, self.strokeColor);
    }
    
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    CGContextStrokePath(ctx);
    
}


@end
