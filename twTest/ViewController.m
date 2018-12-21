//
//  ViewController.m
//  twTest
//
//  Created by HuXiaoyu on 2018/10/12.
//  Copyright © 2018年 com.ifcar99. All rights reserved.
//

#import "ViewController.h"
#import <twTool/testTool.h>
#import "testTool.h"
#import <Masonry/Masonry.h>

#import "PhotoCropEditorViewController.h"
#import "GCDTestViewController.h"
#import "TransFormViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [TWTestUI testToolLog];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.navigationBar.translucent = NO;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = nav;
    
//    UIButton *btn = [UIButton new];
//    [btn setTitle:@"图片裁剪" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(toucheBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.insets(UIEdgeInsetsMake(20, 10, 0, 10));
//        make.height.mas_equalTo(40);
//    }];
    
    UIButton *oldBtn = nil;
    NSArray *ary = @[@"图片裁剪", @"图片下载测试", @"GCD测试", @"transForm测试"];
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
        PhotoCropEditorViewController *vc = [PhotoCropEditorViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag == 1002) {
        [self downloadImageTest];
    }
    else if (btn.tag == 1003) {
        [self GCDTest];
        GCDTestViewController *vc = [GCDTestViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1004) {
        TransFormViewController *vc = [TransFormViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


- (void)downloadImageTest {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSLog(@"documentPath:%@", docPath);
    
    NSArray *imagePathAry = @[@"http://b.hiphotos.baidu.com/zhidao/pic/item/aa64034f78f0f7362e4c0f9a0a55b319eac413fe.jpg"
                              ,@"http://pic2.16pic.com/00/04/39/16pic_439069_b.jpg"
                              ,@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1206/11/c0/11958819_1339405691583.jpg"
                              ,@"http://wx4.sinaimg.cn/large/d2e27164gy1fdfzzwivlhj21hc10i4oz.jpg"
                              ,@"http://e.hiphotos.baidu.com/zhidao/pic/item/d009b3de9c82d158b0d946d0820a19d8bc3e4273.jpg"
                              ,@"http://f.3dxy.com/sub/Manual/pic/2016/0129/10/1601291042_53668_2000x_1.jpg"
                              ,@"http://img4.duitang.com/uploads/item/201512/27/20151227225618_3wFxU.jpeg"
                              ,@"http://b-ssl.duitang.com/uploads/item/201504/11/20150411H0832_LmUBK.jpeg"
                              ,@"http://d.hiphotos.baidu.com/zhidao/pic/item/71cf3bc79f3df8dc9a65cb8acb11728b47102854.jpg"
                              ,@"http://pic1.16pic.com/00/07/65/16pic_765243_b.jpg"];
    
    NSDate *startDate = [NSDate new];
    
    for (int i = 0; i < imagePathAry.count; i++) {
//        NSDate *date = [NSDate new];
//        NSURL *url = [NSURL URLWithString:imagePathAry[i]];
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        NSString *imagePathStr = [NSString stringWithFormat:@"%@/%i.jpg", docPath, i+1];
//        BOOL bl = [imageData writeToFile:imagePathStr atomically:YES];
//        if (bl) {
//            NSTimeInterval interval = [[NSDate new] timeIntervalSinceDate:date];
//            NSLog(@" %i 图片下载成功，耗时：%.2fs", i+1, interval);
//        } else {
//            NSLog(@" %i 图片下载失败", i+1);
//        }
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSDate *date = [NSDate new];
            NSURL *url = [NSURL URLWithString:imagePathAry[i]];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            NSString *imagePathStr = [NSString stringWithFormat:@"%@/%i.jpg", docPath, i+1];
            BOOL bl = [imageData writeToFile:imagePathStr atomically:YES];
            if (bl) {
                NSTimeInterval interval = [[NSDate new] timeIntervalSinceDate:date];
                NSLog(@" %i 图片下载成功，耗时：%.2fs", i+1, interval);
            } else {
                NSLog(@" %i 图片下载失败", i+1);
            }
        });
        
    }
    
    NSTimeInterval endInterval = [[NSDate new] timeIntervalSinceDate:startDate];
    NSLog(@"总计耗时：%.2fs", endInterval);
    
}


- (void)GCDTest {
    
}


@end
