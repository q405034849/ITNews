//
//  ITNewsListViewController.m
//  IT头条
//
//  Created by 张玺科 on 16/6/3.
//  Copyright © 2016年 张玺科. All rights reserved.
//

#import "ITNewsListViewController.h"
#import "ITNews.h"
#import "PullupView.h"
#import "ITNewsCell.h"

static NSString *cellId = @"cellId";
@interface ITNewsListViewController ()

/**
* 新闻数组
*/
@property (nonatomic, strong) NSMutableArray <ITNews *> *newsList;

@property (nonatomic, weak) PullupView *pullupView;

@end


@implementation ITNewsListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置表格行高
    self.tableView.rowHeight = 110;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册原型 cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ITNewsCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    PullupView *pullup = [PullupView pullupView];
    
    self.tableView.tableFooterView = pullup;
    _pullupView = pullup;

    
    [self loadData];
}

- (IBAction)loadData {
    NSLog(@"开始刷新数据");
    

    // 生成时间字符串
    NSString *timeStr;
    // 是否上拉刷新
    BOOL isPullup = _pullupView.indicator.isAnimating;
    
    if (isPullup) {
        // 取数组最后一条记录的 addTime 做上拉刷新的时间
        timeStr = _newsList.lastObject.addtime;
    } else {
        
        // 下拉刷新 - 获取当前系统时间字符串
        timeStr = [self timeString];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/%@/type/%d?channel=appstore&uuid=86FE9108-47B0-4052-BD4C-8DB4FB719B5C&net=5&model=iPhone&ver=1.0.5", timeStr, isPullup];

    NSURL *url = [NSURL URLWithString:urlString];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"请求错误 %@", error);
            
            return;
        }
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            // 1> 创建模型
            ITNews *model = [ITNews new];
            
            // 2> 字典转模型
            [model setValuesForKeysWithDictionary:dict];
            
            // 3> 添加到数组
            [arrayM addObject:model];
        }
        
        // 判断是否上拉刷新
        if (isPullup) {
            // 将数组追加到当前数组的末尾
            [self.newsList addObjectsFromArray:arrayM];
        } else {
            // 记录新闻数组
            self.newsList = arrayM;
        }
        
        // 主线程更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"结束刷新");
            [self.refreshControl endRefreshing];
            
            [self.pullupView.indicator stopAnimating];
            
            [self.tableView reloadData];
        });
    }] resume];
}

- (NSString *)timeString {
    
    // 1. 建立当前系统日期
    NSDate *date = [NSDate date];
    
    // 2. 获取距离 1970-01-01 的秒数
    NSInteger delta = [date timeIntervalSince1970];
    
    return @(delta).description;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ITNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
//    cell.textLabel.text = _newsList[indexPath.row].title;
    cell.model = _newsList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 判断 indexPath.row 和 tableView 数据源的 row
    // 同时，如果正在上拉刷新，就不需要再次刷新！
    if ((indexPath.row == [tableView numberOfRowsInSection:0] - 1) && !_pullupView.indicator.isAnimating) {
        NSLog(@"最后一行，需要上拉刷新");
        
        // 让上拉刷新的菊花转动
        [_pullupView.indicator startAnimating];
    }
}

@end
