//
//  UITableView+EXT.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "UITableView+EXT.h"
#import "GPFooterView.h"
#import "GPHeadView.h"
#import "GPBaseView.h"
#import <objc/runtime.h>

@interface UITableView ()<GPFooterViewDelegate,GPHeaderViewDelegate>

@end

@implementation UITableView (EXT)

static char FooterViewKey;
static char HeaderViewKey;
static char RefreshKey;

- (void)setRefresh:(id<UITableViewRefresh>)refresh
{
    objc_setAssociatedObject(self, &RefreshKey, refresh, OBJC_ASSOCIATION_ASSIGN);
    self.footerView.delegate = refresh;
    self.headerView.delegate = refresh;
}

- (id<UITableViewRefresh>)refresh
{
    return objc_getAssociatedObject(self, &RefreshKey);
}


-(void)setFooterView:(GPFooterView *)footerView{
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    
    objc_setAssociatedObject(self, &FooterViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(GPFooterView *)footerView{
    return objc_getAssociatedObject(self, &FooterViewKey);
}

- (void)setHeaderView:(GPHeadView *)headerView{

    objc_setAssociatedObject(self, &HeaderViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(GPHeadView *)headerView{
    return objc_getAssociatedObject(self, &HeaderViewKey);
}

- (GPFooterView *)tableViewAddFooterView
{
   GPFooterView *footerView = [GPFooterView footerView];
    [self addSubview:footerView];
//    footerView.delegate = (id)self.superview;
    self.footerView = footerView;
    return footerView;
}

- (GPHeadView *)tableViewAddHeaderView
{
    GPHeadView * headerView = [GPHeadView headView];
    [self addSubview:headerView];
//    headerView.delegate = (id)self.superview;
    self.headerView = headerView;
    return headerView;
}

- (void)tableViewStopFooterView
{
    [self.footerView stopAnimation];
}

- (void)tableViewStopHeaderView
{
    [self.headerView stopAnimation];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.footerView = [self tableViewAddFooterView];
    self.headerView = [self tableViewAddHeaderView];
}


@end
