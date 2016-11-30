//
//  ANProgressHUD.m
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "ANProgressHUD.h"

@implementation ANProgressHUD

// 重写成功的方法
+ (void)showSuccessWithStatus:(NSString *)status
{
    // 成功的提示信息的显示时间
    [self setMinimumDismissTimeInterval:0.25];
    [super showSuccessWithStatus:status];
}
@end
