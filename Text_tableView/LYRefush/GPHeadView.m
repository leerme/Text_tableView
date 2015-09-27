//
//  GPHeadView.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPHeadView.h"

@implementation GPHeadView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(self.status == GPBaseViewStatusLoading) return;
    
    [self willMoveToSuperview:self.scrollView];
    
    if (self.scrollView.isDragging){
        if (_scrollView.contentOffset.y <-60 && _scrollView.contentOffset.y > 0)
        {
            [self setStatus:GPBaseViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y < -60)
        {
            [self setStatus: GPBaseViewStatusDragging];
        }
    }//end  if (self.scrollView.isDragging)
    else
    {
        if (self.status == GPBaseViewStatusDragging)
        {
            [self setStatus:GPBaseViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height,0, 0, 0);
            [_delegate headerViewStatus:self status: GPBaseViewStatusLoading];
        }
        
    }//end else
    
}//end method

+ (id)headView
{
    return [[self alloc] init];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //1.添加到那里?
    UITableView * tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfY = -60;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
}


@end
