//
//  ViewController.m
//  画板
//
//  Created by 章芝源 on 16/1/7.
//  Copyright © 2016年 ZZY. All rights reserved.
//

#import "ViewController.h"
// 自动装箱,把基本类型的数据转换成对象
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

//预编译可以不写前缀msa_
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

#import <Masonry.h>

@interface ViewController ()
//顶部功能条
@property(nonatomic, strong)UIToolbar *topView;
//画板
@property(nonatomic, strong)ZYDrawBoard *drawBoardView;
//底部功能条
@property(nonatomic, strong)UIView *bottomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
}

- (void)setupUI
{
    //1.设置功能条
    UIToolbar *topView = [[UIToolbar alloc]init];
    [self.view addSubview:topView];
    self.topView = topView;
    self.topView.tintColor = [UIColor redColor];
    topView.backgroundColor = [UIColor lightGrayColor];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view.top).offset(20);
        make.height.equalTo(50);
    }];
    
    //添加功能按钮
    UIBarButtonItem *cleanButton = [[UIBarButtonItem alloc]initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(cleanScreen)];
    UIBarButtonItem *revokeButton = [[UIBarButtonItem alloc]initWithTitle:@"撤销" style:UIBarButtonItemStyleDone target:self action:@selector(revokeButton)];
    UIBarButtonItem *eraserButton = [[UIBarButtonItem alloc]initWithTitle:@"橡皮差" style:UIBarButtonItemStylePlain target:self action:@selector(eraserButton)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    NSArray *arrayItem = @[cleanButton, revokeButton, eraserButton, flexibleSpace, saveButton];
    [self.topView setItems:arrayItem animated:YES];
   
    //2.设置底部
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.backgroundColor = [UIColor redColor];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(100);
    }];
    
    //添加功能
    UISlider *sliderH = [[UISlider alloc]init];
    [self.view addSubview:sliderH];
    [sliderH makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.bottomView).offset(10);
        make.right.equalTo(self.bottomView).offset(-10);
        make.height.equalTo(50);
    }];
    
    UIButton *blueBtn = [[UIButton alloc]init];
    [self.bottomView addSubview:blueBtn];
    blueBtn.backgroundColor = [UIColor blueColor];
    [blueBtn addTarget:self action:@selector(blueColor) forControlEvents:UIControlEventTouchUpInside];
    [blueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderH.bottom).offset(0);
        make.left.equalTo(self.bottomView).offset(10);
        make.bottom.equalTo(self.bottomView).offset(-10);
    }];
    UIButton *greenBtn = [[UIButton alloc]init];
    [self.bottomView addSubview:greenBtn];
    greenBtn.backgroundColor = [UIColor greenColor];
    [greenBtn addTarget:self action:@selector(greenColor) forControlEvents:UIControlEventTouchUpInside];
    [greenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blueBtn.right).offset(10);
        make.top.equalTo(blueBtn);
        make.bottom.equalTo(self.bottomView).offset(-10);
        make.width.equalTo(blueBtn.width);
    }];
    UIButton *yellowBtn = [[UIButton alloc]init];
    yellowBtn.backgroundColor = [UIColor yellowColor];
    [yellowBtn addTarget:self action:@selector(yellowColor) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:yellowBtn];
    [yellowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(greenBtn.right).offset(10);
         make.top.equalTo(blueBtn);
        make.bottom.right.equalTo(self.bottomView).offset(-10);
        make.width.equalTo(blueBtn.width);

    }];
    
    //3.设置画板
    ZYDrawBoard *drawBoard = [[ZYDrawBoard alloc]init];
    [self.view addSubview:drawBoard];
    self.drawBoardView = drawBoard;
    drawBoard.backgroundColor = [UIColor whiteColor];
    [drawBoard makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.bottom);
        make.bottom.equalTo(self.bottomView.top);
        make.left.right.equalTo(self.view);
    }];
    
    
}

- (void)cleanScreen
{
    NSLog(@"清屏");
}

- (void)revokeButton
{
    NSLog(@"撤销");
}

- (void)eraserButton
{
    NSLog(@"橡皮差");
}

- (void)saveButton
{
    NSLog(@"保存");
}

//颜色
- (void)blueColor
{
    self.drawBoardView.colorPath = [UIColor blueColor];
    NSLog(@"%s", __FUNCTION__);
}

- (void)greenColor
{
    self.drawBoardView.colorPath = [UIColor greenColor];
    NSLog(@"%s", __FUNCTION__);
}

- (void)yellowColor
{
    self.drawBoardView.colorPath = [UIColor yellowColor];
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 懒加载
- (ZYDrawBoard *)drawBoardView
{
    if (!_drawBoardView) {
        _drawBoardView = [[ZYDrawBoard alloc]init];
    }
    return _drawBoardView;
}

@end
