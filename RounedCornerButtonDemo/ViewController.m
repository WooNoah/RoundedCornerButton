//
//  ViewController.m
//  RoundedCornerButtonDemo
//
//  Created by Noah on 17/7/20.
//  Copyright © 2017年 No. All rights reserved.
//

#import "ViewController.h"
#import "RoundedCornerButton.h"
#import <Masonry.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DDColorRandom RGB(arc4random()%256,arc4random()%256,arc4random()%256)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    RoundedCornerButton *test = [[RoundedCornerButton alloc]init];
    [test setTitle:@"-" forState:UIControlStateNormal];
    test.direction = kCornerDirectionTopLeft | kCornerDirectionBottomLeft;
    test.roundedCornerRadius = 10.f;
    test.strokeWidth = 1.f;
    test.strokeColor = [UIColor redColor];
    test.backgroundColor = [UIColor yellowColor];
    [test addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

- (void)minusAction {
    NSLog(@"minusAction");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
