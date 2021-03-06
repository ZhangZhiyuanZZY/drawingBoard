//
//  ZYDrawBoard.h
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDrawBoard : UIView
//颜色
@property(nonatomic, strong)UIColor *colorPath;
//lineWidth
@property(assign, nonatomic)CGFloat width;
///图片保存
@property(nonatomic, strong)UIImage *imageSave;

///撤销
- (void)revokeButton;
///清屏
- (void)cleanScreen;
@end
