//
//  ZYDrawBoard.m
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ZYDrawBoard.h"
@interface ZYDrawBoard()
//路径
@property(nonatomic, strong)ZYDrawPath *path;
//路径数组
@property(nonatomic, strong)NSMutableArray *arrayPath;
@end
@implementation ZYDrawBoard

///下面这两个方法中都可以设置本view的初始值
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = 1;
        self.colorPath = [UIColor redColor];
    }
    return self;
}

- (void)awakeFromNib
{
    
}


- (void)cleanScreen
{
    [self.arrayPath removeAllObjects];
    [self setNeedsDisplay];
}

- (void)revokeButton
{
    [self.arrayPath removeLastObject];
    [self setNeedsDisplay];
}

//每次绘图就是把路径上的内容绘制到上下文中, 再渲染到layer上, 如果只有一条路径, 那么当第二次画的时候, 第一次画的路径会被第二次画的路径覆盖, 在渲染的时候, 只渲染了第二条路径,  要解决这个办法,最好就是搞个数组, 保存所有路径
- (void)drawRect:(CGRect)rect {//默认是在这个范围内进行绘图的
    if (self.arrayPath.count == 0) return;
    //遍历路径数组
    for (ZYDrawPath *Path in self.arrayPath) {
        if ([Path isKindOfClass:[ZYDrawPath class]]) {
            [Path.color set];
            [Path stroke];   //当进行渲染的时候, 上下文中的内容渲染到layer,同时上下文被清空
        }else if ([Path isKindOfClass:[UIImage class]]){
            UIImage *image = (UIImage *)Path;
            [image drawInRect:rect];
        }
    }
}
///得到颜色
- (void)setColorPath:(UIColor *)colorPath
{
    _colorPath = colorPath;
}

///得到宽度
- (void)setWidth:(CGFloat)width
{
    _width = width;
}

///得到图片
- (void)setImageSave:(UIImage *)imageSave
{
    _imageSave = imageSave;
    [self.arrayPath addObject:imageSave];
    [self setNeedsDisplay];
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
    ZYDrawPath *bzrPath = [ZYDrawPath pathWithColor:self.colorPath width:self.width];
    [bzrPath moveToPoint:beginPoint];
    //记录路径
    self.path = bzrPath;
    [self.arrayPath addObject:bzrPath];
}

///画的动作路径 每移动一小下, 都会调用这个方法 point改变一次
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint = [self pointWithTouches:touches];
    [self.path addLineToPoint:movePoint];
    //开始绘图
    [self setNeedsDisplay];
}

#pragma mark - 懒加载
- (NSMutableArray *)arrayPath
{
    if (!_arrayPath) {
        _arrayPath = [NSMutableArray array];
    }
    return _arrayPath;
}

@end
