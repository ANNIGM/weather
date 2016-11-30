//
//  HistoryDayMode.h
//  weather
//
//  Created by IndusGoo on 2016/11/27.
//  Copyright © 2016年 Annie. All rights reserved.
//
// 历史天气模型
#import <Foundation/Foundation.h>

@interface HistoryDayMode : NSObject

@property (nonatomic, copy) NSString * date;//!< 日期
@property (nonatomic, copy) NSString * week;//!< 星期

@property (nonatomic, copy) NSString * aqi;//!< pm值

@property (nonatomic, copy) NSString * fengxiang;//!< 风向
@property (nonatomic, copy) NSString * fengli;//!< 风力

@property (nonatomic, copy) NSString * hightemp;//!< 最高温
@property (nonatomic, copy) NSString * lowtemp;//!< 最低温

@property (nonatomic, copy) NSString * type; //!< 天气状态
@end
