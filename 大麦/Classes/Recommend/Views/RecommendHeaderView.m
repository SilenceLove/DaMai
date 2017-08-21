//
//  RecommendHeaderView.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendHeaderView.h"
#import "SDCycleScrollView.h"
#import "RecommendShufflingModel.h"
#import "VerticalButton.h"
#import "UIButton+WebCache.h"
#import "HeadlinesScrollView.h"
#import "RecommendTypeBtnModel.h"
#import "RecommendHeadlinesModel.h"
#import "RecommendListModel.h"
#import "RecommendMiddleView.h"
#import "RecommendNewView.h"
#import "RecommendCouponsView.h"
#import "RecommendTypeTenView.h"
#import "RecommendTitleView.h"
#import "RecommendTypeTwoView.h"
#import "RecommendTypeThreeView.h"
#import "RecommendTypeTwelveView.h"
#import "IntroductionViewController.h"
#import "WebViewController.h"
@interface RecommendHeaderView ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) SDCycleScrollView *cycleView;
@property (weak, nonatomic) UIView *typeView;
@property (weak, nonatomic) HeadlinesScrollView *headScrollView;
@property (weak, nonatomic) RecommendNewView *rNewView;
@property (weak, nonatomic) UIView *headlinesView;
@property (strong, nonatomic) NSMutableArray *typeTitleAy;
@property (strong, nonatomic) NSMutableArray *typeOneAy;
@property (strong, nonatomic) NSMutableArray *typeTwoAy;
@property (strong, nonatomic) NSMutableArray *typeThreeAy;
@property (strong, nonatomic) NSMutableArray *typeFourAy;
@property (strong, nonatomic) NSMutableArray *typeTenAy;
@property (strong, nonatomic) NSMutableArray *typeTwelveAy;
@end

@implementation RecommendHeaderView

- (NSMutableArray *)typeTitleAy
{
    if (!_typeTitleAy) {
        _typeTitleAy = [NSMutableArray array];
    }
    return _typeTitleAy;
}

- (NSMutableArray *)typeOneAy
{
    if (!_typeOneAy) {
        _typeOneAy = [NSMutableArray array];
    }
    return _typeOneAy;
}

- (NSMutableArray *)typeTwoAy
{
    if (!_typeTwoAy) {
        _typeTwoAy = [NSMutableArray array];
    }
    return _typeTwoAy;
}

- (NSMutableArray *)typeThreeAy
{
    if (!_typeThreeAy) {
        _typeThreeAy = [NSMutableArray array];
    }
    return _typeThreeAy;
}

- (NSMutableArray *)typeFourAy
{
    if (!_typeFourAy) {
        _typeFourAy = [NSMutableArray array];
    }
    return _typeFourAy;
}

- (NSMutableArray *)typeTenAy
{
    if (!_typeTenAy) {
        _typeTenAy = [NSMutableArray array];
    }
    return _typeTenAy;
}

- (NSMutableArray *)typeTwelveAy
{
    if (!_typeTwelveAy) {
        _typeTwelveAy = [NSMutableArray array];
    }
    return _typeTwelveAy;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self setup];
    }
    return self;
}

- (void)setup
{
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 16 * 9) delegate:self placeholderImage:[UIImage imageNamed:@"bg_banner_placeholder"]];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleView.autoScrollTimeInterval = 4.0f;
    [self addSubview:cycleView];
    self.cycleView = cycleView;
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, cycleView.height, ScreenWidth, 210)];
    typeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:typeView];
    self.typeView = typeView;
    
    CGFloat headlinesY = CGRectGetMaxY(typeView.frame) + 0.5;
    UIView *headlinesView = [[UIView alloc] initWithFrame:CGRectMake(0, headlinesY, ScreenWidth, 45)];
    headlinesView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headlinesView];
    self.headlinesView = headlinesView;
    
    UIImageView *headlinesIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_damaiheadlines"]];
    headlinesIcon.centerY = headlinesView.height / 2;
    headlinesIcon.x = 15;
    [headlinesView addSubview:headlinesIcon];
    
    CGFloat lineViewX = CGRectGetMaxX(headlinesIcon.frame) + 10;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, 0, 0.5, 15)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    lineView.centerY = headlinesIcon.centerY;
    [headlinesView addSubview:lineView];
    
    CGFloat headScrollViewX = CGRectGetMaxX(lineView.frame) + 10;
    HeadlinesScrollView *headScrollView = [[HeadlinesScrollView alloc] initWithFrame:CGRectMake(headScrollViewX, 0, ScreenWidth - headScrollViewX - 10, 15)];
    headScrollView.centerY = lineView.centerY;
    [headlinesView addSubview:headScrollView];
    self.headScrollView = headScrollView;
    
    RecommendNewView *rNewView = [[RecommendNewView alloc] init];
    [self addSubview:rNewView];
    self.rNewView = rNewView;
}

- (void)setRNewList:(NSArray *)rNewList
{
    _rNewList = rNewList;
    self.rNewView.list = rNewList;
}

- (void)setHeaderList:(NSArray *)headerList
{
    _headerList = headerList;
    
    for (UIView *view in self.typeTitleAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeOneAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeTwoAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeThreeAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeFourAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeTenAy) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.typeTwelveAy) {
        [view removeFromSuperview];
    }
    
    CGFloat y = CGRectGetMaxY(self.headlinesView.frame);
    for (int i = 0; i < headerList.count; i++) {
        RecommendListModel *model = headerList[i];
        if (model.title.length > 0) {
            CGFloat titleViewH = 50;
            CGFloat titleViewY = y + 10;
            if (model.subTitle.length > 0) {
                titleViewH += 22;
            }
            RecommendTitleView *titleView = [[RecommendTitleView alloc] initWithFrame:CGRectMake(0, titleViewY, ScreenWidth, titleViewH)];
            titleView.model = model;
            [self addSubview:titleView];
            y = CGRectGetMaxY(titleView.frame);
            [self.typeTitleAy addObject:titleView];
        }
        if (model.list.count > 0) {
            if (model.type.integerValue == 1) {
                CGFloat couponsH = model.height;
                CGFloat couponsY = y;
                RecommendCouponsView *couponsView = [[RecommendCouponsView alloc] init];
                [self addSubview:couponsView];
                couponsView.frame = CGRectMake(0, couponsY, ScreenWidth, couponsH);
                y = CGRectGetMaxY(couponsView.frame);
                couponsView.listModel = model;
                [self.typeOneAy addObject:couponsView];
            }else if (model.type.integerValue == 2) {
                CGFloat twoViewH = model.height;
                CGFloat twoViewY = y;
                RecommendTypeTwoView *twoView = [[RecommendTypeTwoView alloc] init];
                [self addSubview:twoView];
                twoView.frame = CGRectMake(0, twoViewY, ScreenWidth, twoViewH);
                twoView.modelList = model.list;
                [self.typeTwoAy addObject:twoView];
                y = CGRectGetMaxY(twoView.frame);
            }else if (model.type.integerValue == 3) {
                CGFloat threeViewH = model.height;
                CGFloat threeViewY = y;
                RecommendTypeThreeView *threeView = [[RecommendTypeThreeView alloc] init];
                [self addSubview:threeView];
                threeView.frame = CGRectMake(0, threeViewY, ScreenWidth, threeViewH);
                threeView.modelList = model.list;
                [self.typeThreeAy addObject:threeView];
                y = CGRectGetMaxY(threeView.frame);
            }else if (model.type.integerValue == 4) {
                CGFloat middleViewY = y;
                CGFloat middleViewH = model.height;
                RecommendMiddleView *middleView = [[RecommendMiddleView alloc] init];
                [self addSubview:middleView];
                middleView.frame = CGRectMake(0, middleViewY, ScreenWidth, middleViewH);
                y = CGRectGetMaxY(middleView.frame);
                middleView.model = model;
                [self.typeFourAy addObject:middleView];
            }else if (model.type.integerValue == 10) {
                CGFloat typeTenViewH = model.height;
                CGFloat typeTenViewY = y;
                RecommendTypeTenView *typeTenView = [[RecommendTypeTenView alloc] init];
                [self addSubview:typeTenView];
                typeTenView.frame = CGRectMake(0, typeTenViewY, ScreenWidth, typeTenViewH);
                y = CGRectGetMaxY(typeTenView.frame);
                typeTenView.listModel = model;
                [self.typeTenAy addObject:typeTenView];
            }else if (model.type.integerValue == 12) {
                CGFloat twelveViewH = model.height;
                CGFloat twelveViewY = y;
                RecommendTypeTwelveView *twelveView = [[RecommendTypeTwelveView alloc] init];
                [self addSubview:twelveView];
                twelveView.frame = CGRectMake(0, twelveViewY, ScreenWidth, twelveViewH);
                twelveView.modelList = model.list;
                [self.typeTwelveAy addObject:twelveView];
                y = CGRectGetMaxY(twelveView.frame);
            }
        }
        if (model.type.integerValue == 6) {
            CGFloat rNewViewH = 250;
            CGFloat rNewViewY = y;
            self.rNewView.frame = CGRectMake(0, rNewViewY, ScreenWidth, rNewViewH);
            self.rNewView.model = model;
            y = CGRectGetMaxY(self.rNewView.frame);
        }
    }
}

- (void)setHeadlines:(NSArray *)headlines
{
    _headlines = headlines;
    
    self.headScrollView.models = headlines;
}

- (void)setTypeAy:(NSArray *)typeAy
{
    _typeAy = typeAy;
    for (UIView *view in self.typeView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat btnW = 65;
    CGFloat btnH = 80;
    CGFloat x = 20;
    CGFloat marginX = (ScreenWidth - 65 * 4 - 30 * 2) / 3;
    CGFloat y = 15;
    CGFloat marginY = 20;
    for (int i = 0; i < typeAy.count ; i++) {
        RecommendTypeBtnModel *model = typeAy[i];
        VerticalButton *button = [VerticalButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.frame = CGRectMake(x + i % 4 * (btnW + marginX), y + i / 4 *(btnH + marginY), btnW, btnH);
        button.tag = i;
        [button addTarget:self action:@selector(didTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.typeView addSubview:button];
    }
}

- (void)didTypeBtnClick:(UIButton *)button
{
    RecommendTypeBtnModel *model = self.typeAy[button.tag];
    if (model.type.integerValue == 2) {
        WebViewController *vc = [[WebViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.url = model.value;
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}

- (void)setShufflingAy:(NSArray *)shufflingAy
{
    _shufflingAy = shufflingAy;
    NSMutableArray *array = [NSMutableArray array];
    for (RecommendShufflingModel *model in shufflingAy) {
        [array addObject:model.Pic];
    }
    self.cycleView.imageURLStringsGroup = array;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    RecommendShufflingModel *model = self.shufflingAy[index];
    if (model.ProjType.integerValue == 0) {
        IntroductionViewController *vc = [[IntroductionViewController alloc] init];
        vc.dataId = model.ProjectID;
        vc.hidesBottomBarWhenPushed = YES;
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}

// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollViewDidScrollViewToIndexforUrl:)]) {
        [self.delegate cycleScrollViewDidScrollViewToIndexforUrl:self.cycleView.imageURLStringsGroup[index]];
    }
}

@end
