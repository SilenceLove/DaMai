//
//  DiscoverBottomView.m
//  大麦
//
//  Created by 洪欣 on 16/12/23.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverBottomView.h"
#import "DiscoverBottomSubView.h"

@interface DiscoverBottomView ()
@property (weak, nonatomic) DiscoverBottomSubView *subView;
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation DiscoverBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, 150)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setModel:(DiscoverHeaderSubOneModel *)model
{
    _model = model;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * model.seckillItems.count, 150);
    for (int i = 0 ; i < model.seckillItems.count ; i++) {
        DiscoverBottomSubView *subView = [[DiscoverBottomSubView alloc] init];
        subView.title = model.title;
        subView.model = model.seckillItems[i];
        subView.x = ScreenWidth * i;
        subView.y = 0;
        subView.width = ScreenWidth;
        [self.scrollView addSubview:subView];
    }
}


@end
