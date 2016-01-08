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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MBProgressHUDDelegate>
//顶部功能条
@property(nonatomic, strong)UIToolbar *topView;
//画板
@property(nonatomic, strong)ZYDrawBoard *drawBoardView;
//底部功能条
@property(nonatomic, strong)UIView *bottomView;
//lineWidth
@property(nonatomic, strong)UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
}

#pragma mark - 顶部条功能
///清屏
- (void)cleanScreen
{
    [self.drawBoardView cleanScreen];
}

///撤销
- (void)revokeButton
{
    [self.drawBoardView revokeButton];
}

///橡皮差
- (void)eraserButton
{
    self.drawBoardView.colorPath = [UIColor whiteColor];
}

///保存
- (void)saveButton
{
    UIGraphicsBeginImageContext(self.drawBoardView.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawBoardView.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //    NSLog(@"%@", ctx);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.delegate = self;
        hud.labelText = @"保存失败!";
        [hud hide:YES afterDelay:1.0];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.delegate = self;
        hud.labelText = @"保存成功!";
        [hud hide:YES afterDelay:1.0];
    }
}

///照片功能
- (void)setupPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.drawBoardView.imageSave = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - bottom功能
//颜色
- (void)blueColor
{
    self.drawBoardView.colorPath = [UIColor blueColor];
}

- (void)greenColor
{
    self.drawBoardView.colorPath = [UIColor greenColor];
}

- (void)yellowColor
{
    self.drawBoardView.colorPath = [UIColor yellowColor];
}

//width
- (void)widthLine
{
    self.drawBoardView.width = self.slider.value;
}

#pragma mark - 设置UI
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
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc]initWithTitle:@"照片" style:UIBarButtonItemStylePlain target:self action:@selector(setupPhotos)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    NSArray *arrayItem = @[cleanButton, revokeButton, eraserButton, photoButton, flexibleSpace, saveButton];
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
    self.slider = sliderH;
    self.slider.tintColor = [UIColor blackColor];
    sliderH.minimumValue = 1;
    sliderH.maximumValue = 10;
    [sliderH addTarget:self action:@selector(widthLine) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - 懒加载
- (ZYDrawBoard *)drawBoardView
{
    if (!_drawBoardView) {
        _drawBoardView = [[ZYDrawBoard alloc]init];
    }
    return _drawBoardView;
}

@end
