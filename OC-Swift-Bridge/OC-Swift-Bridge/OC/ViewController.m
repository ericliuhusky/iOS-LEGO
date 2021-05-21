//
//  ViewController.m
//  OC-Swift-Bridge
//
//  Created by lzh on 2021/5/21.
//

#import "ViewController.h"
#import "HelloController.h"
// MARK: 引入头文件，可以调用模块内的swift内容
// 格式: #import <TargetName-Swift.h>
#import <OC_Swift_Bridge-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = UIColor.blackColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapButton {
//    [self presentViewController:[[HelloController alloc] init] animated:YES completion:nil];
    [self presentViewController:[[NewHelloController alloc] init] animated:YES completion:nil];
}


@end
