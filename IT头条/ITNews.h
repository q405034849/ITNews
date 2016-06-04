//
//  ITNews.h
//  IT头条
//
//  Created by 张玺科 on 16/6/4.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITNews : NSObject
/**
 * 新闻代号
 */
@property (nonatomic, copy) NSString *id;

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 简介
 */
@property (nonatomic, copy) NSString *summary;
/**
 * 添加的时间
 */
@property (nonatomic, copy) NSString *addtime;
/**
 * 文档日期 - know how 1464940683 标示时间通常 距离 1970-01-01 的秒数！
 */
@property (nonatomic, copy, readonly) NSString *docDate;

/**
 * 来自于哪个网站
 */
@property (nonatomic, copy) NSString *sitename;

/**
 * 配图地址
 */
@property (nonatomic, copy) NSString *src_img;

@end
