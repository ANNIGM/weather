//
//  ANHTTPSessionManager.m
//  weather
//
//  Created by IndusGoo on 2016/11/25.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "ANHTTPSessionManager.h"

@implementation ANHTTPSessionManager

// 重写manager方法
+ (instancetype)manager
{
    // text/json
    // text/xml
    // text/plain
    // text/html
    
    // 创建manager实例
    ANHTTPSessionManager *manager = [super manager];
    
    // mgr.responseSerializer = ;
    // mgr.requestSerializer = ;
    // 设置请求头中的内容
    [manager.requestSerializer setValue:ANApikey forHTTPHeaderField:@"apikey"];
    
    // 注意: AFN 不支持text/html格式
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    return manager;
}

// 重写GET方法
- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    // 拼接传进来的参数
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //    dict[@"cityname"] = @"北京";
    //    dict[@"cityid"] = @"101010100";//101020100
    
    // 添加 每次发请求都要传的参数

    
    // 发送请求
    NSURLSessionDataTask *  task = [super GET:URLString parameters:dict progress:downloadProgress success:success failure:failure];
    return task;
}
@end
