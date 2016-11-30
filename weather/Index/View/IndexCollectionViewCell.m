//
//  IndexCollectionViewCell.m
//  weather
//
//  Created by IndusGoo on 2016/11/27.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "IndexCollectionViewCell.h"
@interface IndexCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//!< 图片View
@property (weak, nonatomic) IBOutlet UILabel *indexNameLabel;//!< 文字标签

@end
@implementation IndexCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 给cell设置背景色-透明湖水蓝
    self.backgroundColor = ANColorA(154, 186, 189, 0.5 * 255);
}

#pragma mark - Set 给cell传值
- (void)setIndexMode:(IndexMode *)indexMode
{
    _indexMode = indexMode;
    
    // 拼接字符串
    NSString * indexNameString = [NSString stringWithFormat:@"%@%@",_indexMode.index,[_indexMode.name substringToIndex:2]];
    // 设置标签文字
    self.indexNameLabel.text = indexNameString;
    
    // 设置图片
    [self.imageView setImage:[UIImage imageNamed:indexMode.code]];
}
@end
