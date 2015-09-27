//
//  UITableView+EXT.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPBaseView.h"
#import "GPFooterView.h"
#import "GPHeadView.h"

@protocol UITableViewRefresh <NSObject>

- (void)headerViewStatus:(GPBaseView *)headerView status:( GPBaseViewStatus)status;

- (void)footerViewStatus:(GPFooterView *)footerView status:(GPBaseViewStatus)status;

@end

@interface UITableView (EXT)
@property (retain, nonatomic) GPFooterView *footerView;
@property (retain, nonatomic) GPHeadView *headerView;
@property (nonatomic, weak)id<UITableViewRefresh> refresh;


- (GPFooterView *)tableViewAddFooterView;

- (GPHeadView *)tableViewAddHeaderView;

- (void)tableViewStopFooterView;

- (void)tableViewStopHeaderView;
@end
