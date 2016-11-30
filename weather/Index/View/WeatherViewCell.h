//
//  WeatherViewCell.h
//  weather
//
//  Created by IndusGoo on 2016/11/27.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastDayMode.h"

@interface WeatherViewCell : UITableViewCell

@property (strong, nonatomic) ForecastDayMode * weather;//!< 天气模型

@end
