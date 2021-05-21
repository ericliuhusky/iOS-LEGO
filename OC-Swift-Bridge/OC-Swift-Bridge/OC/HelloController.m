//
//  HelloController.m
//  OC-Swift-Bridge
//
//  Created by lzh on 2021/5/21.
//

#import "HelloController.h"

@interface HelloController()

@end


@implementation HelloController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lable.text = @"hello world";
    [self.view addSubview:lable];
}

@end
