//
//  ViewController.m
//  weather
//
//  Created by IndusGoo on 2016/11/25.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "ViewController.h"
#import "WeatherController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WeatherController * weatherVc = [[WeatherController alloc]init];
    [self presentViewController:weatherVc animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
