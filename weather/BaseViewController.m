//
//  BaseViewController.m
//  weather
//
//  Created by IndusGoo on 2016/12/1.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "BaseViewController.h"
#import "WeatherController.h"
@interface BaseViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSMutableArray * focusCitysArray;
@property (strong, nonatomic) NSMutableArray<WeatherController  *> * weatherVcArray;

@property (weak, nonatomic) UIPageControl * pageControl;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = ANRandomColor;
//    WeatherController * weatherVc = [[WeatherController alloc]init];
//    weatherVc.params = (NSMutableDictionary *)@{@"cityname":@"北京"};
    // Do any additional setup after loading the view.
    [self configUI];
}
- (void) configUI
{
    UIImageView * bgView = [[UIImageView alloc]init];
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    // 设置背景
    [bgView  sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"bg"] ];
    
    UIPageControl * pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((ANScreenW - 100) / 2 , 20, 100, 20)];
    self.pageControl = pageControl;
    [self.view insertSubview:pageControl atIndex:1];
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
//    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.focusCitysArray.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    self.pageControl.numberOfPages = self.focusCitysArray.count;
    self.pageControl.currentPage = 0;
    [self addChildVcView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    ANLogFuc
    [self addChildVcView];
    
}// called when scroll view grinds to a halt
- (void)addChildVcView
{
    UIScrollView *scrollView = self.scrollView;
    
    // 计算按钮索引
    int index = scrollView.contentOffset.x / scrollView.width;
    
    // 添加对应的子控制器view
//    WeatherController *weatherVc = [[WeatherController alloc]init];
//    [self.weatherVcArray addObject:weatherVc];
//    [self addChildViewController:weatherVc];
//    weatherVc.params = self.focusCitysArray[index];
    self.weatherVcArray[index].view.frame = CGRectMake(index * ANScreenW, 0,ANScreenW, ANScreenH);
    [scrollView addSubview:self.weatherVcArray[index].view];
    self.pageControl.currentPage = index;
    
}
- (NSMutableArray<WeatherController *> *)weatherVcArray
{
    if (!_weatherVcArray) {
        _weatherVcArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            WeatherController * vc = [[WeatherController alloc]init];
            vc.params = self.focusCitysArray[i];
            [_weatherVcArray addObject:vc];
        }
    }
    return _weatherVcArray;
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


- (NSMutableArray *)focusCitysArray
{
    return @[@{@"cityname":@"北京"},@{@"cityname":@"天津"},@{@"cityname":@"上海"}];
}
@end
