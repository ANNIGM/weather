//
//  FocusCityViewCell.m
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "FocusCityViewCell.h"
@interface FocusCityViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@end
@implementation FocusCityViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCityMode:(CityMode *)cityMode
{
    _cityMode = cityMode;
    self.cityLabel.text = cityMode.city;
    self.tempLabel.text = cityMode.temp;
}
@end
