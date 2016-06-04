//
//  ITNews.m
//  IT头条
//
//  Created by 张玺科 on 16/6/4.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import "ITNews.h"

@implementation ITNews

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
