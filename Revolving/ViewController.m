//
//  ViewController.m
//  Revolving
//
//  Created by Naibin on 15/12/3.
//  Copyright © 2015年 Naibin. All rights reserved.
//

#import "ViewController.h"

#define MY_COLOR(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define RADIUS 0.33 * SCREEN_SIZE.width

//旋转速度，越大旋转越快
#define SPEED 0.5

@interface ViewController ()

@property (strong, nonatomic) NSTimer * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    NSArray * arr = @[@"喜羊羊", @"灰太狼", @"美羊羊", @"红太狼", @"沸羊羊", @"懒羊羊"];
    NSArray * colorArr = @[
                           MY_COLOR(130, 202, 118, 1),
                           MY_COLOR(255, 182, 60, 1),
                           MY_COLOR(135, 66, 255, 1),
                           MY_COLOR(255, 89, 142, 1),
                           MY_COLOR(125, 202, 209, 1),
                           MY_COLOR(100, 178, 255, 1)
                           ];
    
    for (int i = 0; i < arr.count; i++) {
        
        CGFloat angle = 30 + 60 * i;
        double sinAngle = sin(angle * M_PI / 180);
        double cosAngle = cos(angle * M_PI / 180);
        
        NSInteger centerX = SCREEN_SIZE.width / 2 + cosAngle * RADIUS;
        NSInteger centerY = SCREEN_SIZE.height / 2 + sinAngle * RADIUS;
        
        UIButton * button = [[UIButton alloc] init];
        button.tag = 100 + i;
        button.bounds = CGRectMake(0, 0, 80, 80);
        button.center = CGPointMake(centerX, centerY);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.backgroundColor = colorArr[i];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 40.0;
        
        [self.view addSubview:button];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerGo:) userInfo:nil repeats:YES];
}

- (void)timerGo:(NSTimer *)timer {
    static int count = 0;
    ++count;
    for (int i = 0; i < 6; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:100 + i];
        CGFloat angle = 30 + 60 * i + count * SPEED;
        double sinAngle = sin(angle * M_PI / 180);
        double cosAngle = cos(angle * M_PI / 180);
        CGFloat centerX = SCREEN_SIZE.width / 2 + cosAngle * RADIUS;
        CGFloat centerY = SCREEN_SIZE.height / 2 + sinAngle * RADIUS;
        button.center = CGPointMake(centerX, centerY);
    }
    if (count == 1000 * 360) {
        count = 0;
    }
}

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end










