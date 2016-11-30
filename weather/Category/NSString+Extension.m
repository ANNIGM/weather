//
//  NSString+Extension.m
//  weather
//
//  Created by IndusGoo on 2016/11/28.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (instancetype)dayInDateString
{
    if (![self containsString:@"日"]) {
//        NSDateFormatter * format = [[NSDateFormatter alloc]init];
//        [format setDateFormat:@"YYYY-MM-dd"];
//        NSDate * date = [format dateFromString:self];
        NSString * str = [self substringFromIndex:8];
        str = [NSString stringWithFormat:@"%@日",str];
        
        return str;
        
        
    }
    return self;
}
- (instancetype)dayInWeekString
{
    NSString * str = [self substringFromIndex:2];
    if ([str isEqualToString:@"天"]) {
        str = @"日";
    }
    str = [NSString stringWithFormat:@"周%@",str];
    return str;
    
}
- (instancetype) tempInTempString
{
    NSString * str = [self substringToIndex:1];
    str = [NSString stringWithFormat:@"%@°",str];

    return str;

}
@end
