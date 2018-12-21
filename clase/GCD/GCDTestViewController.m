//
//  GCDTestViewController.m
//  twTest
//
//  Created by HuXiaoyu on 2018/10/25.
//  Copyright © 2018 com.ifcar99. All rights reserved.
//

#import "GCDTestViewController.h"
#import <Masonry/Masonry.h>


@interface GCDTestViewController ()

@end

@implementation GCDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GCD测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *oldBtn = nil;
    NSArray *ary = @[@"图片裁剪", @"图片下载测试", @"GCD测试", @"transform测试"];
    for (int i = 0; i < ary.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = 1001+i;
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toucheBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.insets(UIEdgeInsetsMake(0, 10, 0, 10));
            make.height.mas_equalTo(40);
            if (!oldBtn) {
                make.top.mas_equalTo(20);
            } else {
                make.top.mas_equalTo(oldBtn.mas_bottom).offset(20);
            }
        }];
        oldBtn = btn;
    }
    
    
}


- (void)toucheBtn:(UIButton*)btn {
    if (btn.tag == 1001) {
        
    }
    else if (btn.tag == 1002) {

    }
    else if (btn.tag == 1003) {
        
    }
    
}



@end
