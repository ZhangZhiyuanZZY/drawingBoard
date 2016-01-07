//
//  ZYDrawPath.h
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDrawPath : UIBezierPath
@property(nonatomic, strong)UIColor *color;
///设置路径的宽/ 颜色
+ (instancetype)pathWithColor:(UIColor *)color width:(CGFloat)width;
@end
