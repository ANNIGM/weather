//
//  WeatherController.m
//  weather
//
//  Created by IndusGoo on 2016/11/25.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "WeatherController.h"
#import "TodayMode.h"
#import "ForecastDayMode.h"
#import "HistoryDayMode.h"
#import "IndexMode.h"
#import "WeatherViewCell.h"
#import "IndexCollectionViewCell.h"
#import "IndexDetailViewController.h"

#import "PYSearch.h"
#import "AreaMode.h"

#import "SearchCityViewController.h"

@interface WeatherController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;//!< 北京View
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;//!< 当前城市标签
@property (weak, nonatomic) IBOutlet UILabel *cityTempLabel;//!< 当前温度标签

@property (weak, nonatomic) UITableView * tempTableView;//!< 温度表格
@property (weak, nonatomic) UICollectionView * footCollectionView;//!< 生活指数View

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConsTop;// 顶部约束

@property (weak, nonatomic)  ANHTTPSessionManager * manager;//!< manager

@property (strong, nonatomic) TodayMode * todayMode;//!< 今日天气模型
@property (strong, nonatomic) NSMutableArray * weathersArray;//!< 温度表格的数据




@end

@implementation WeatherController
static NSString * const WeatherCellID = @"WeatherCellID";
static NSString * const IndexCollectionViewCellID = @"IndexCollectionViewCellID";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
   
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UI
- (void)configUI
{
    // 设置背景
    [self.backgroundImageView  sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"bg"] ];
    // 设置尺寸
    self.view.frame = [UIScreen mainScreen].bounds;
        CGRect rect = CGRectMake(0, 0, ANScreenW, ANScreenH);
    
    // 添加tempTableView
    UITableView * tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    [self.view insertSubview:tableView atIndex:1];
    self.tempTableView = tableView;
    self.tempTableView.backgroundColor = ANColorA(255, 255, 255, 0.7);
    self.tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tempTableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    self.tempTableView.scrollIndicatorInsets = self.tempTableView.contentInset;
    self.tempTableView.dataSource = self;
    self.tempTableView.delegate = self;
    
    // 添加监听器 监听向上滑动
    [self.tempTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    // 注册cell
    [self.tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeatherViewCell class]) bundle:nil] forCellReuseIdentifier:WeatherCellID];

}

#pragma mark - data
- (void)loadData
{
    // 提醒正在加载
    NSString * str = [NSString stringWithFormat:@"正在加载\n%@的天气",self.params[@"cityname"]];
    [ANProgressHUD showWithStatus:str];
    // 弱引用
    __weak typeof(self) weakSelf = self;

//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    //    dict[@"citypinyin"] = @"beijing";
    //    dict[@"apikey"] = ANApikey;
//    errMsg = "Service provider response status error";
//    errNum = 300209;

    // 发送网络请求
    [self.manager GET:ANRequestURLCityweathers parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ANLog(@"----------------%@",responseObject);
        //        ANWriteToPlist(responseObject,@"123")
        if (![responseObject[@"errMsg"] isEqualToString:@"success"])
        {
           [ANProgressHUD  showErrorWithStatus:ANRequestServiesError];
            return ;
        }
        // 数据转模型
        weakSelf.todayMode = [TodayMode mj_objectWithKeyValues:responseObject[@"retData"][@"today"]];
        //        ANLog(@"----------------%@",weakSelf.todayMode);
        // 设置城市名
        weakSelf.cityNameLabel.text = responseObject[@"retData"][@"city"];
        // 设置当前温度
        weakSelf.cityTempLabel.text = [self.todayMode.curTemp tempInTempString];
        
        // 设置温度表格的数据
        weakSelf.weathersArray = [ForecastDayMode mj_objectArrayWithKeyValuesArray:responseObject[@"retData"][@"history"]];
        NSArray * forecastArray = [ForecastDayMode mj_objectArrayWithKeyValuesArray:responseObject[@"retData"][@"forecast"]];
        [self.weathersArray addObjectsFromArray:forecastArray];
        
        //        ANLog(@"----------------%@",weakSelf.forecastArray);
        // 刷新表格
        [weakSelf.tempTableView reloadData];
        
        // 提示加载成功
        [ANProgressHUD showSuccessWithStatus:ANRequestSuccess];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ANLog(@"----------------%@",error);
        
        // 提示加载失败
        [ANProgressHUD  showErrorWithStatus:ANRequestError];

        
    }];
}

#pragma mark - 数据源 UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weathersArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeatherViewCell * cell = [tableView dequeueReusableCellWithIdentifier:WeatherCellID];
    cell.weather = self.weathersArray[indexPath.row];
    //    cell.backgroundColor = ANRandomColor;
    return cell;
}

#pragma mark - 代理 UITableViewdelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        //        UIView  * headView = [[UIView alloc]init];
        
        // 创建footerView
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((ANScreenW - 3) / 3  , 70);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;

        
        UICollectionView * footCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ANScreenW,200) collectionViewLayout:layout];
        self.footCollectionView = footCollectionView;
        
        [self.footCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([IndexCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:IndexCollectionViewCellID];

        footCollectionView.backgroundColor = [UIColor clearColor];
        footCollectionView.dataSource = self;
        footCollectionView.delegate = self;
        
        return self.footCollectionView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

#pragma mark - 数据源 UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.todayMode.index.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IndexCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:IndexCollectionViewCellID forIndexPath:indexPath];
    cell.indexMode = self.todayMode.index[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IndexCollectionViewCell * cell = (IndexCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    IndexDetailViewController * indexDetailVc  = [[IndexDetailViewController alloc]init];
    indexDetailVc.indexMode = cell.indexMode;
    [self presentViewController:indexDetailVc animated:YES completion:nil];
    
}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // tableView向上拖动时的动画
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        //        NSLog(@"----------x: %f   y: %f",offset.x,offset.y);
        
        if (offset.y <= -250) return;
        if (offset.y < -120) {
            self.cityNameLabel.hidden = NO;
            CGFloat alpha = (250 + offset.y) / 90;
            self.cityTempLabel.textColor = ANColorA(255, 255, 255, (1- alpha * 2) * 255);
            //        if (self.topViewConsTop.constant > 20) {
            self.topViewConsTop.constant = 20 * (1-alpha) + 60;
        }
        else if(offset.y > -85)
        {
            self.cityNameLabel.hidden = YES;
        }
       
    }
}

#pragma mark - 懒加载
- (ANHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [ANHTTPSessionManager manager];
    }
    return  _manager;
}
- (NSMutableArray *)weathersArray
{
    if (!_weathersArray) {
        _weathersArray = [NSMutableArray array];
    }
    return _weathersArray;
}
- (void)setParams:(NSMutableDictionary *)params
{
    _params = params;
}

#pragma mark - +按钮点击
- (IBAction)searchCityButtonClick:(id)sender {
    SearchCityViewController * searchCityVc = [[SearchCityViewController alloc]init];
    searchCityVc = [searchCityVc searchCity:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        self.params = @{@"cityname":searchText};
        [self dismissViewControllerAnimated:NO completion:nil];
        [self loadData];
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

#pragma mark - dealloc
- (void)dealloc
{
    // 移除监听
     [self.tempTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
