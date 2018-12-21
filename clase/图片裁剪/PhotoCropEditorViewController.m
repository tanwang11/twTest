//
//  PhotoCropEditorViewController.m
//  twTest
//
//  Created by HuXiaoyu on 2018/10/19.
//  Copyright © 2018 com.ifcar99. All rights reserved.
//

#import "PhotoCropEditorViewController.h"
#import <PEPhotoCropEditor/PECropView.h>

#import <Masonry/Masonry.h>


@interface PhotoCropEditorViewController ()

@property (nonatomic, strong) PECropView *cropView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation PhotoCropEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图片裁剪";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.imageView                 = [UIImageView new];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode     = UIViewContentModeScaleAspectFit;
    self.imageView.image           = [UIImage imageNamed:@"testImage.jpeg"];
    self.imageView.hidden          = YES;
    [self.view addSubview:self.imageView];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toucheImage:)];
    [self.view addGestureRecognizer:tap];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.imageView.mas_width);
        make.centerY.mas_equalTo(self.view);
    }];
    
    
    self.cropView                     = [PECropView new];
    self.cropView.image               = self.imageView.image;
    self.cropView.layer.masksToBounds = YES;
    [self.view addSubview:self.cropView];

    [self.cropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.insets(UIEdgeInsetsMake(0, 0, 60, 0));
    }];
    
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cropView.mas_bottom);
        make.left.bottom.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"还原" forState:UIControlStateNormal];
    btn1.tag = 1001;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(toucheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:btn1];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"裁剪" forState:UIControlStateNormal];
    btn2.tag = 1002;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(toucheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:btn2];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(70);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(70);
    }];
}


- (void)toucheImage:(UITapGestureRecognizer*)tap {
    self.cropView.hidden = NO;
    self.bottomView.hidden = NO;
    self.imageView.hidden = YES;
    [self.cropView resetCropRect];
}


- (void)toucheBtn:(UIButton*)btn {
    NSInteger tag = btn.tag;
    if (tag == 1001) {
        [self.cropView resetCropRectAnimated:YES];
    }
    else if (tag == 1002) {
        UIImage *image = self.cropView.croppedImage;
        self.imageView.image = image;
        
        self.cropView.hidden = YES;
        self.bottomView.hidden = YES;
        self.imageView.hidden = NO;
    }
}


@end
