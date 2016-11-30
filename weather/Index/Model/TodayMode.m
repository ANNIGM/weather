//
//  TodayMode.m
//  weather
//
//  Created by IndusGoo on 2016/11/25.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "TodayMode.h"

@implementation TodayMode

+ (NSDictionary *)mj_objectClassInArray
{
    // 模型里头套模型数组时使用
    return @{@"index": @"IndexMode"};
}
@end
