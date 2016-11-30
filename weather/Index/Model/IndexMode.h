//
//  IndexMode.h
//  weather
//
//  Created by IndusGoo on 2016/11/25.
//  Copyright © 2016年 Annie. All rights reserved.
//
// 生活指数模型
#import <Foundation/Foundation.h>

@interface IndexMode : NSObject
@property (nonatomic, copy) NSString * code; //!< 指标编码
@property (nonatomic, copy) NSString * details; //!< 描述
@property (nonatomic, copy) NSString * index; //!< 等级
@property (nonatomic, copy) NSString * name; //!< 指数指标名称
@property (nonatomic, copy) NSString * otherName;   //!< 其他信息

@end
