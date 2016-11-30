//
//  SearchCityViewController.m
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "SearchCityViewController.h"
#import "AreaMode.h"
@interface SearchCityViewController ()<PYSearchViewControllerDelegate>

@end

@implementation SearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype) searchCity:(PYDidSearchBlock) block
{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"北京", @"天津", @"上海", @"广州", @"太原"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索城市" didSearchBlock:block];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleNormalTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    
//    searchViewController.delegate = self;

    return (SearchCityViewController *)searchViewController;
}


@end
