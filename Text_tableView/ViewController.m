//
//  ViewController.m
//  Text_tableView
//
//  Created by qianfeng on 15/9/27.
//  Copyright (c) 2015年 雷  雨. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+EXT.h"

@interface ViewController ()<UITableViewRefresh>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.refresh = self;
    
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cell"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"hhhhhhh";
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark GPFooterViewDelegate
- (void)footerViewStatus:(GPFooterView *)footerView status:(GPBaseViewStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRequstOne) withObject:nil afterDelay:5];
    
}

- (void)sendRequstOne
{
    NSLog(@"网络请求结束");
    //    [self.footerView stopAnimation];
    [self.tableView tableViewStopFooterView];
}

- (void)sendRequstTwo
{
    NSLog(@"网络请求结束");
    //    [self.headerView stopAnimation];
    [self.tableView tableViewStopHeaderView];
}

#pragma mark GPHeaderViewDelegate

- (void)headerViewStatus:(GPHeadView *)headerView status:( GPBaseViewStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRequstTwo) withObject:nil afterDelay:5];
}


@end
