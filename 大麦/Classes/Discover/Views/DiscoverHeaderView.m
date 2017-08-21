//
//  DiscoverHeaderView.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverHeaderView.h"
#import "DiscoverHeaderTopView.h"
#import "DiscoverHeaderSubOneModel.h"
#import "DiscoverBottomView.h"
@interface DiscoverHeaderView ()
@property (weak, nonatomic) DiscoverHeaderTopView *topView;
@property (weak, nonatomic) DiscoverBottomView *bottomView;
@end

@implementation DiscoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        [self setup];
    }
    return self;
}

- (void)setup
{
    DiscoverHeaderTopView *topView = [[DiscoverHeaderTopView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 120)];
    [self addSubview:topView];
    self.topView = topView;
    
    DiscoverBottomView *bottomView = [[DiscoverBottomView alloc] initWithFrame:CGRectMake(0, 140, ScreenWidth, 200)];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)setModel:(DiscoverHeaderModel *)model
{
    _model = model;
    DiscoverHeaderSubOneModel *subModel = model.data.firstObject;
    self.topView.list = subModel.scrollItems;
    self.bottomView.model = model.data.lastObject;
}

@end
