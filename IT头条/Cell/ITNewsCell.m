//
//  ITNewsCell.m
//  IT头条
//
//  Created by 张玺科 on 16/6/5.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import "ITNewsCell.h"
#import <UIImageView+WebCache.h>

@interface ITNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthCons;

@end

@implementation ITNewsCell

- (void)setModel:(ITNews *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _summaryLabel.text = model.summary;
    _siteLabel.text = model.sitename;
//    _timeLabel.text = model.docDate;
    _timeLabel.text = model.newsTime;
    
    // 1. url
//    NSURL *url = [NSURL URLWithString:model.src_img];
//    [_iconView sd_setImageWithURL:url];

    // 判断是否有图片
    if (model.src_img.length > 0) {
        
        NSURL *url = [NSURL URLWithString:model.src_img];
        [_iconView sd_setImageWithURL:url];
        
        _imageWidthCons.constant = 80;
    } else {
        _imageWidthCons.constant = 0;
    }

    // 2. 知道每一个控件的高度
    // 1> 内容变化后，如果需要更新布局
    [self layoutIfNeeded];
    
    // 2> 判断 summary 的底部是否超出了 site 的顶部
    BOOL hideSummary = CGRectGetMaxY(_summaryLabel.frame) > CGRectGetMinY(_siteLabel.frame);
    
    _summaryLabel.hidden = hideSummary;
}


@end
