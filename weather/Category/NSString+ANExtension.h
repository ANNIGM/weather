//
//  NSString+Extension.h
//  weather
//
//  Created by IndusGoo on 2016/11/28.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ANExtension)
-(instancetype) dayInDateString;//!< 取出日期中的天
-(instancetype) dayInWeekString;//!< 取出星期中的天
-(instancetype) tempInTempString;//!< 取出温度中的数字
@end
