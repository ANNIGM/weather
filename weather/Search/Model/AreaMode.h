//
//  AreaMode.h
//  weather
//
//  Created by IndusGoo on 2016/11/29.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaMode : NSObject
//province_cn: "北京",  //省
//district_cn: "北京",  //市
//name_cn: "朝阳",    //区、县
//name_en: "chaoyang",  //城市拼音
//area_id: "101010300"  //城市代码
@property (nonatomic, copy) NSString * province_cn;//!< 省
@property (nonatomic, copy) NSString * district_cn;//!< 市
@property (nonatomic, copy) NSString * name_cn;//!< 区.县
@property (nonatomic, copy) NSString * name_en;//!< 城市拼音
@property (nonatomic, copy) NSString * area_id;//!< 城市代码
@end
