//
//  GPBaseView.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPBaseView.h"

@implementation GPBaseView

- (void)setTitle:(NSString *)title forState:(GPBaseViewStatus)status
{
    switch (status) {
            
        case GPBaseViewStatusBeginDrag:
            _beginDragText = title;
            break;
        case GPBaseViewStatusDragging:
            _draggingText = title;
            break;
        case GPBaseViewStatusLoading:
            _loadingText = title;
            break;
            
        default:
            break;
    }
}

- (NSString *)titleWithStatus:(GPBaseViewStatus)status
{
    NSString * title = nil;
    
    switch (status) {
            
        case GPBaseViewStatusBeginDrag:
            title = _beginDragText?_beginDragText:@"拖拽";
            break;
        case GPBaseViewStatusDragging:
            title = _draggingText?_draggingText:@"松开";
            break;
        case GPBaseViewStatusLoading:
            title = _loadingText?_loadingText:@"加载";
            break;
        default:
            break;
    }
    return title;
}

- (void)stopAnimation
{
    //1.
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0,0);
    
    //2.移除当前显示的这个FooterView
    //    [self removeFromSuperview];
    [self clear];
}

- (void)clear
{
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status = GPBaseViewStatusBeginDrag;
}

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    
    //1.移除旧的
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //2.保存成员变量
    _scrollView = scrollView;
    //3.添加新的监听
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    //    [_scrollView addSubview:self];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

- (UIView *)loadingView
{
    if (_loadingView == nil)
    {
        //1.
        UIView * loadingView = [UIView new];//[[UIView alloc] init];
        //2.
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = [self titleWithStatus:GPBaseViewStatusLoading];//_loadingText;//@"正在读取";
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview:activity];
        activity.frame = CGRectMake(100, 10, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}

- (UIButton *)alertButtonView
{
    if (_alertButtonView == nil)
    {
        //1.创建对象
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //2.建立父子关系
        [self addSubview:btn];
        //3.Frame
        btn.frame = self.bounds;
        //4.保存成员变量值
        _alertButtonView = btn;
        //5.其他属性设置
        
        //        [btn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
        
    }
    return _alertButtonView;
}
+ (id)baseView
{
    return [[self alloc] init];
}


- (void)setStatus:(GPBaseViewStatus)status
{
    _status = status;
    
    switch (status) {
        case GPBaseViewStatusBeginDrag:
            
            [self.alertButtonView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case GPBaseViewStatusDragging:
            //            NSLog(@"松开读取更多");
            [self.alertButtonView setTitle:[self titleWithStatus:status]  forState:UIControlStateNormal];
            break;
        case GPBaseViewStatusLoading:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    
}

- (void)didMoveToSuperview
{
    self.scrollView = self.superview;
}
@end
