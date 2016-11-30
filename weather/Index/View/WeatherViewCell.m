//
//  WeatherViewCell.m
//  weather
//
//  Created by IndusGoo on 2016/11/27.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "WeatherViewCell.h"

@interface WeatherViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//!< 日期标签
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;//!< 星期标签
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;//!< 天气图标View
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;//!< 天气标签
@property (weak, nonatomic) IBOutlet UILabel *hightempLabel;//!< 最高温标签
@property (weak, nonatomic) IBOutlet UILabel *lowtempLabel;//!< 最低温的标签

@end
@implementation WeatherViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = ANColorA(255, 255, 255, 0.2);
    // Initialization code
    self.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Set 给cell传值
- (void)setWeather:(ForecastDayMode *) weather
{
    _weather = weather;
    
    // 设置日期
    self.dateLabel.text = [weather.date dayInDateString];
    // 设置星期
    self.weekLabel.text = [weather.week dayInWeekString];
    // 设置天气图片
    [self.weatherImageView setImage:[UIImage imageNamed:weather.type]];
    // 设置天气
    self.typeLabel.text = weather.type;
    // 设置最高温
    self.hightempLabel.text = weather.hightemp;
    // 设置最低温
    self.lowtempLabel.text = weather.lowtemp;
    
}
@end
