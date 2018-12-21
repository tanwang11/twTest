//
//  TransFormViewController.m
//  twTest
//
//  Created by HuXiaoyu on 2018/10/31.
//  Copyright © 2018 com.ifcar99. All rights reserved.
//

#import "TransFormViewController.h"
#import <Masonry/Masonry.h>


@interface TransFormViewController ()

@property (nonatomic, strong) UIImageView *displayIV;

@end

@implementation TransFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TransForm测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.displayIV = ({
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"timg.jpeg"];
        [self.view addSubview:iv];
        iv;
    });
    [self.displayIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(self.displayIV.mas_width).multipliedBy(0.75);
    }];

    UIButton *oldBtn = nil;
    NSArray *ary = @[@"平移", @"旋转", @"缩放", @"transForm测试"];
    for (int i = 0; i < ary.count; i++) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        btn.tag = 1001+i;
        [btn addTarget:self action:@selector(toucheBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.insets(UIEdgeInsetsMake(0, 10, 0, 10));
            make.height.mas_equalTo(40);
            if (!oldBtn) {
                make.bottom.mas_equalTo(-34);
            } else {
                make.bottom.mas_equalTo(oldBtn.mas_top).offset(-20);
            }
        }];
        oldBtn = btn;
    }
    
    
}

- (void)toucheBtnEvent:(UIButton*)btn {
    
    NSLog(@"%@", NSStringFromCGRect(self.displayIV.frame));
    
    if (btn.tag == 1001) {
        // 平移
        [UIView animateWithDuration:0.5 animations:^{
            self.displayIV.transform = CGAffineTransformTranslate(self.displayIV.transform, 0, -10);
        }];
    }
    else if (btn.tag == 1002) {
        // 旋转
        [UIView animateWithDuration:0.5 animations:^{
            self.displayIV.transform = CGAffineTransformRotate(self.displayIV.transform, M_PI_4);
        }];
    }
    else if (btn.tag == 1003) {
        // 缩放
        [UIView animateWithDuration:1.5 animations:^{
//            self.displayIV.transform = CGAffineTransformScale(self.displayIV.transform, 0.9, 0.9);
//            CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
            
//            t' = [ 1 0 0 1 tx ty ] * t   平移
//            t' =  [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] * t   旋转
//            t' = [ sx 0 0 sy 0 0 ] * t   缩放
//            self.displayIV.transform = CGAffineTransformMake(0.9, 0, 0, 0.9, -90, 0);
            
            CGFloat a = cosf(M_PI_4);
            CGFloat b = sinf(M_PI_4);
            CGFloat c = -sinf(M_PI_4);
            CGFloat d = cosf(M_PI_4);
            
            a = cosf(0);
            b = sinf(M_PI_4);
            c = 0;
            
            self.displayIV.transform = CGAffineTransformMake(a, b, c, d, 0, 0);
            
            
            
        }];
    }
}



@end
