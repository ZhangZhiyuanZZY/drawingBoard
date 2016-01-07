//
//  ZYDrawBoard.m
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ZYDrawBoard.h"
@interface ZYDrawBoard()
@property(nonatomic, strong)UIBezierPath *path;
@end
@implementation ZYDrawBoard


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {//默认是在这个范围内进行绘图的
    [self.path stroke];
    
}

///根据集合获得触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}

//记录点击点生成路径
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint beginPoint = [self pointWithTouches:touches];
    UIBezierPath *bzrPath = [UIBezierPath bezierPath];
    [bzrPath moveToPoint:beginPoint];
    //记录路径
    self.path = bzrPath;
}

///画的动作路径 每移动一小下, 都会调用这个方法 point改变一次
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint = [self pointWithTouches:touches];
    [self.path addLineToPoint:movePoint];
    
    //开始绘图
    [self setNeedsDisplay];
}

@end
