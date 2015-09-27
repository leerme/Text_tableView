//
//  GPFooterView.m
//  美食
//
//  Created by qianfeng on 15-9-23.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

/*
 
 重构代码原则:
 1.要确定,那一部分逻辑是不会发生变化的,对其进行封装
 2.重构代码,要小步进行操作,尽可能的一步一测,不要因为代码的迁移,引入新的bug
 3.找出代码中,不合理的地方进行逐步的修正,也要保证一个功能一个功能的测试修改
 4.作为组件封装的视图,要站在使用者的角度进行思考,不要把复杂的实现逻辑抛给使用者
 
 */

#import "GPFooterView.h"

@interface GPFooterView()

@end

@implementation GPFooterView


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status == GPBaseViewStatusLoading) return;
    
    [self willMoveToSuperview:self.scrollView];
    
    if (self.scrollView.isDragging){
        
        CGFloat maxY  = _scrollView.contentSize.height - _scrollView.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (_scrollView.contentOffset.y >= maxY && _scrollView.contentOffset.y < maxY + footerViewHeight)
        {
            [self setStatus:GPBaseViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y > maxY + footerViewHeight)
        {
            [self setStatus:GPBaseViewStatusDragging];
        }
        

    }//end  if (self.scrollView.isDragging)
    else
    {
        if (self.status == GPBaseViewStatusDragging)
        {
            [self setStatus:GPBaseViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
    
            [_delegate footerViewStatus:self status:GPBaseViewStatusLoading];
        }
        
    }//end else
    
}

+ (id)footerView
{
    return [[self alloc] init];
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //1.添加到那里?
    UITableView * tableView = (UITableView *)newSuperview;
    //2.添加到什么位置?
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
}

@end
