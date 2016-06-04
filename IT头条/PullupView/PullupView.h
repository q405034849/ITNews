//
//  PullupView.h
//  IT头条
//
//  Created by 张玺科 on 16/6/4.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullupView : UIView

+ (instancetype)pullupView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
