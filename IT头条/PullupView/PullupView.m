//
//  PullupView.m
//  IT头条
//
//  Created by 张玺科 on 16/6/4.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import "PullupView.h"

@implementation PullupView

+ (instancetype)pullupView {
    
    UINib *nib = [UINib nibWithNibName:@"PullupView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}



@end
