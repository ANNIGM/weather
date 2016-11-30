//
//  FocusCityViewController.m
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "FocusCityViewController.h"
#import "FocusCityViewCell.h"
#import "WeatherController.h"

@interface FocusCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) UITableView * focusCityTableview;//!< 城市表格
@property (strong, nonatomic) NSMutableArray * focusCitysArray;

@property (weak, nonatomic)  ANHTTPSessionManager * manager;//!< manager
@end

@implementation FocusCityViewController
static NSString * const FocusCityViewCellID = @"FocusCityViewCellID";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configData];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UI
- (void)configUI
{
    // 设置尺寸
    self.view.frame = [UIScreen mainScreen].bounds;
    CGRect rect = CGRectMake(0, 0, ANScreenW, ANScreenH);
    
    // 添加focusCityTableview
    UITableView * focusCityTableview = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    [self.view addSubview:focusCityTableview];
    self.focusCityTableview = focusCityTableview;
    self.focusCityTableview.backgroundColor = ANCommonBgColor;
    self.focusCityTableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.focusCityTableview.dataSource = self;
    self.focusCityTableview.delegate = self;
    
    // 注册cell
    [self.focusCityTableview registerNib:[UINib nibWithNibName:NSStringFromClass([FocusCityViewCell class]) bundle:nil] forCellReuseIdentifier:FocusCityViewCellID];
    
}

#pragma mark - data
- (void)configData
{
    // 提醒正在加载
    [ANProgressHUD show];
    // 弱引用
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    //    dict[@"citypinyin"] = @"beijing";
    //    dict[@"apikey"] = ANApikey;
    
    // 发送网络请求
    [self.manager GET:ANRequestURLCityweathers parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        ANLog(@"----------------%@",responseObject);
        //        ANWriteToPlist(responseObject,@"123")
        
        // 刷新表格
        [weakSelf.focusCityTableview reloadData];
        
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
    return self.focusCitysArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FocusCityViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FocusCityViewCellID];
    cell.cityMode = self.focusCitysArray[indexPath.row];

    return cell;
}

#pragma mark - 代理 UITableViewdelegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * view = [[UIView alloc]init];
//    //    view.backgroundColor  = ANRandomColor;
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.focusCityTableview.backgroundColor = ANRandomColor;
    FocusCityViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"cityname"] = cell.cityMode.city;
    params[@"cityid"] = cell.cityMode.citycode;
    WeatherController * weatherVc = [[WeatherController alloc]init];
    weatherVc.params = params;
    [self presentViewController:weatherVc animated:YES completion:nil];
}

#pragma mark - 监听

#pragma mark - 懒加载
- (ANHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [ANHTTPSessionManager manager];
    }
    return  _manager;
}
- (NSMutableArray *)focusCitysArray
{
    if (!_focusCitysArray) {
        _focusCitysArray = [NSMutableArray array];
        CityMode * cityMode = [[CityMode alloc]init];
        cityMode.city = @"北京";
        cityMode.citycode = @"101010100";
        cityMode.temp = @"8°C";
        CityMode * cityMode1 = [[CityMode alloc]init];
        cityMode1.city = @"上海";
        cityMode1.citycode = @"101020100";
        cityMode1.temp = @"10°C";
        [_focusCitysArray addObject:cityMode];
        [_focusCitysArray addObject:cityMode1];
    }
    return _focusCitysArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
