//
//  BaseViewController.m
//  weather
//
//  Created by IndusGoo on 2016/12/1.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "BaseViewController.h"
#import "WeatherController.h"
#import "SearchCityViewController.h"
#import "AreaMode.h"
@interface BaseViewController ()<UIScrollViewDelegate,PYSearchViewControllerDelegate>

@property (weak, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSMutableArray * focusCitysArray;
@property (strong, nonatomic) NSMutableArray<WeatherController  *> * weatherVcArray;

@property (weak, nonatomic) UIPageControl * pageControl;
@property (weak, nonatomic) UIButton * searchCityButton;
@property (weak, nonatomic) UIButton * deleteCityButton;

@property (strong, nonatomic) NSDictionary * params;
@end

@implementation BaseViewController
{
    NSMutableArray<WeatherController  *> * _weatherVcArray;
}
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
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
//    [btn setTitle:@"+" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 80, 80);
    btn.bottom = self.view.bottom - 10;
    btn.right = self.view.right - 10;
//    btn.titleLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(searchCityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.searchCityButton = btn;
    
    UIButton * deleteBtn = [[UIButton alloc]init];
    [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//    [deleteBtn setTitle:@"-" forState:UIControlStateNormal];
//    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.bounds = CGRectMake(0, 0, 50, 50);
    deleteBtn.bottom = self.view.bottom - 10;
    deleteBtn.right = self.view.right - 20;
//    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteCityButton = deleteBtn;
    self.deleteCityButton.hidden = YES;
    
//    self.pageControl.currentPage =
    UILongPressGestureRecognizer * longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressGesture)];
    longpress.minimumPressDuration = 2.0;
    [self.view addGestureRecognizer:longpress];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / ANScreenW;
    self.pageControl.currentPage = index;
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
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = index;
    self.pageControl.numberOfPages = self.focusCitysArray.count;
    
   

    if (self.scrollView.contentSize.width / ANScreenW < self.focusCitysArray.count) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.focusCitysArray.count, 0);
        WeatherController * vc = [[WeatherController alloc]init];
        vc.params = self.focusCitysArray.lastObject;
        [_weatherVcArray addObject:vc];
        index = self.focusCitysArray.count - 1;
        CGPoint point = CGPointMake(index * ANScreenW, 0);
        self.scrollView.contentOffset = point;
    }
     self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.focusCitysArray.count, 0);
    // 添加对应的子控制器view
//    WeatherController *weatherVc = [[WeatherController alloc]init];
//    [self.weatherVcArray addObject:weatherVc];
//    [self addChildViewController:weatherVc];
//    weatherVc.params = self.focusCitysArray[index];
    self.weatherVcArray[index].view.frame = CGRectMake(index * ANScreenW, 0,ANScreenW, ANScreenH);
    [scrollView addSubview:self.weatherVcArray[index].view];
    ANLog(@"-------------------%zd",index);
    
}
- (NSMutableArray<WeatherController *> *)weatherVcArray
{
    if (!_weatherVcArray) {
        _weatherVcArray = [NSMutableArray array];
        for (int i = 0; i < self.focusCitysArray.count; i++) {
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
- (void) searchCityButtonClick
{
    SearchCityViewController * searchCityVc = [[SearchCityViewController alloc]init];
    searchCityVc = [searchCityVc searchCity:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        if ([self.focusCitysArray containsObject:@{@"cityname":searchText}]) {
            NSInteger index = [self.focusCitysArray indexOfObject:@{@"cityname":searchText}];
            CGPoint point = CGPointMake(index * ANScreenW, 0);
            self.scrollView.contentOffset = point;
            
            self.pageControl.currentPage = index;
            [self dismissViewControllerAnimated:NO completion:nil];
            return ;
        }
        [self.focusCitysArray addObject: @{@"cityname":searchText}];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self addChildVcView];
    }];
    searchCityVc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchCityVc];
    [self presentViewController:nav  animated:NO completion:nil];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            //            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            NSDictionary * dict = @{@"cityname":searchText};
            [SVProgressHUD showWithStatus:@"正在搜索中..."];
            [[ANHTTPSessionManager manager] GET:ANRequestURLCitylist parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ANLog(@"------------%@",responseObject);
                //                ANWriteToPlist(responseObject, @"搜索出来数据");
                NSMutableArray * arr = [NSMutableArray array];
                arr = [AreaMode mj_objectArrayWithKeyValuesArray:responseObject[@"retData"]];
                NSMutableArray *dictArr = [NSMutableArray array];
                for (int i = 0; i < arr.count; i++) {
                    AreaMode *dict = arr[i];
                    [dictArr addObject:dict.name_cn];
                }
                searchViewController.searchSuggestions = dictArr;
                [ANProgressHUD showSuccessWithStatus:ANRequestSuccess];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [ANProgressHUD showErrorWithStatus:ANRequestError];
            }];
            
            
        });
    }
}
- (void) longpressGesture
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.searchCityButton.bottom = self.view.bottom - 80;
        
        self.deleteCityButton.hidden = NO;
    }];
    
}
- (void) deleteButtonClick:(UIButton *) deleteButton
{
//    [UIView animateWithDuration:0.25 animations:^{
  
//    }];
    NSInteger index = self.scrollView.contentOffset.x / ANScreenW;
    [self.focusCitysArray removeObjectAtIndex:index];
    WeatherController * vc = [self.weatherVcArray objectAtIndex:index];
    [vc.view removeFromSuperview];
    [self.weatherVcArray removeObjectAtIndex:index];
    [self deleteChildVcView];
//    deleteButton.hidden = YES;
    
    [UIView animateWithDuration:0.25 animations:^{

    deleteButton.hidden = YES;
    self.searchCityButton.bottom = self.view.bottom - 10;
    
     }];

}
- (void)deleteChildVcView
{
    UIScrollView *scrollView = self.scrollView;
    
    // 计算按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = index;
    self.pageControl.numberOfPages = self.focusCitysArray.count;
    
    
    if (self.scrollView.contentSize.width / ANScreenW < self.focusCitysArray.count) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.focusCitysArray.count, 0);
//        WeatherController * vc = [[WeatherController alloc]init];
//        vc.params = self.focusCitysArray.lastObject;
//        [_weatherVcArray addObject:vc];
        index = self.focusCitysArray.count - 1;
        CGPoint point = CGPointMake(index * ANScreenW, 0);
        self.scrollView.contentOffset = point;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.focusCitysArray.count, 0);
    [self addChildVcView];

}
- (NSMutableArray *)focusCitysArray
{
    if (!_focusCitysArray) {
        _focusCitysArray = [NSMutableArray arrayWithObjects:@{@"cityname":@"北京"}, nil];
        
    }
    return _focusCitysArray;
//    return @[@{@"cityname":@"北京"},@{@"cityname":@"天津"},@{@"cityname":@"上海"}];
}
//- (void)setFocusCitysArray:(NSMutableArray *)focusCitysArray
//{
//    _focusCitysArray = focusCitysArray;
//}
@end
