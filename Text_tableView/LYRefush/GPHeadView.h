//
//  GPHeadView.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPBaseView.h"

@class GPBaseView;

@protocol GPHeaderViewDelegate <NSObject>

- (void)headerViewStatus:(GPBaseView *)headerView status:( GPBaseViewStatus)status;
@end

@interface GPHeadView : GPBaseView


@property(nonatomic,weak)id<GPHeaderViewDelegate> delegate;

+ (id)headView;


@end
