//
//  ZYDrawPath.m
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ZYDrawPath.h"

@implementation ZYDrawPath

+ (instancetype)pathWithColor:(UIColor *)color width:(CGFloat)width
{
    ZYDrawPath *path = [[ZYDrawPath alloc]init];
    path.color = color;
    path.lineWidth = width;
    
    return path;
}
@end
