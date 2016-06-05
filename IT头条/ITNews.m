//
//  ITNews.m
//  IT头条
//
//  Created by 张玺科 on 16/6/4.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import "ITNews.h"

@implementation ITNews

- (NSString *)newsTime {
    
    // 0. 获取日历对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    // 1. 新闻创建的日期
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_addtime.integerValue];
    
    // 2. 判断是否是今天
    // 刚刚(1分钟内)
    // 几分钟前(1小时内)
    // 几小时前(1天内)
    if ([cal isDateInToday:date]) {
        
        NSInteger delta = -[date timeIntervalSinceNow];
        
        if (delta < 60) {
            return @"刚刚";
        }
        
        if (delta < 60 * 60) {
            return [NSString stringWithFormat:@"%zd 分钟前", delta / 60];
        }
        
        return [NSString stringWithFormat:@"%zd 小时前", delta / 3600];
    }
    
    // 之前的时间，显示 `yyyy(年)-MM(月)-dd(日) HH(24小时):mm(分钟):ss(秒)`
    // NSDateFormatter - 日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 1> 指定日期格式
    formatter.dateFormat = @"MM-dd HH:mm";
    
    // 2> 返回格式器的日期
    return [formatter stringFromDate:date];
}

- (NSString *)docDate {
    // _addtime 是时间距离 1970-01-01 的秒数
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_addtime.integerValue];
    
    return date.description;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    return [NSString stringWithFormat:@"{id = %@, title = %@, summary = %@, addtime = %@, sitename = %@, src_img = %@, docDate = %@}", _id, _title, _summary, _addtime, _sitename, _src_img, self.docDate];
}
@end
