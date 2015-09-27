//
//  GPFooterView.h
//  美食
//
//  Created by qianfeng on 15-9-23.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

//#import <UIKit/UIKit.h>
#include "GPBaseView.h"

@class GPFooterView;

@protocol GPFooterViewDelegate <NSObject>

- (void)footerViewStatus:(GPFooterView *)footerView status:(GPBaseViewStatus)status;

@end

@interface GPFooterView : GPBaseView

@property(nonatomic,weak)id<GPFooterViewDelegate> delegate;

+ (id)footerView;

@end
