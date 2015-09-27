//
//  GPBaseView.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GPBaseView;

typedef enum GPBaseViewStatus
{
    GPBaseViewStatusBeginDrag, //拖拽读取更多
    GPBaseViewStatusDragging,  //松开读取更多
    GPBaseViewStatusLoading,   //正在读取
    
}GPBaseViewStatus;




@interface GPBaseView : UIView
{
    NSString * _beginDragText;
    NSString * _draggingText;
    NSString * _loadingText;
    __weak UIScrollView *_scrollView;
    __weak UIButton * _alertButtonView;
    __weak UIView * _loadingView;
}

@property (nonatomic, assign)GPBaseViewStatus status;

@property(nonatomic, weak)UIScrollView * scrollView;

@property(nonatomic, weak)UIButton * alertButtonView;

@property(nonatomic, weak)UIView * loadingView;

@property (nonatomic, copy)NSString *beginDragText;
@property (nonatomic, copy)NSString *draggingText;
@property (nonatomic, copy)NSString *loadingText;
- (void)stopAnimation;

+ (id)baseView;

- (void)setTitle:(NSString *)title forState:(GPBaseViewStatus)status;

@end
