//
//  SearchCityViewController.m
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "SearchCityViewController.h"

@interface SearchCityViewController ()
@property (strong, nonatomic) UISearchController * searchVc;
@end

@implementation SearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}
-(void) configUI
{
    UISearchController
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
