//
//  IntroductionScrollView.m
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionScrollView.h"
#import "IntroductionHeaderView.h"
#import "IntroductionOneView.h"
#import "IntroductionTwoView.h"
#import "IntroductionThreeView.h"
#import "IntroductionTypeView.h"
#import "IntroductionBottomView.h"
@interface IntroductionScrollView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IntroductionHeaderView *headerView;
@property (weak, nonatomic) IntroductionOneView *oneView;
@property (weak, nonatomic) IntroductionTwoView *twoView;
@property (weak, nonatomic) IntroductionThreeView *threeView;
@property (weak, nonatomic) IntroductionTypeView *commentView;
@property (weak, nonatomic) IntroductionTypeView *answerView;
@property (weak, nonatomic) IntroductionBottomView *bottomView;
@end

@implementation IntroductionScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    IntroductionOneView *oneView = [[IntroductionOneView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    oneView.hidden = YES;
    [self addSubview:oneView];
    self.oneView = oneView;
    
    IntroductionTwoView *twoView = [[IntroductionTwoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    twoView.hidden = YES;
    [self addSubview:twoView];
    self.twoView = twoView;
    
    IntroductionThreeView *threeView =[[IntroductionThreeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    threeView.hidden = YES;
    [self addSubview:threeView];
    self.threeView = threeView;
    
    IntroductionTypeView *commentView = [[IntroductionTypeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55) Type:IntroductionComment];
    commentView.hidden = YES;
    [self addSubview:commentView];
    self.commentView = commentView;
    
    IntroductionTypeView *answerView = [[IntroductionTypeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55) Type:IntroductionAnswer];
    answerView.hidden = YES;
    [self addSubview:answerView];
    self.answerView = answerView;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    self.oneView.model = model;
    self.twoView.model = model;
    self.threeView.model = model;
    [self.oneView layoutSubviews];
    self.twoView.y = self.oneView.height;
    [self.twoView layoutSubviews];
    self.threeView.y = CGRectGetMaxY(self.twoView.frame);
    [self.threeView layoutSubviews];
    self.commentView.y = CGRectGetMaxY(self.threeView.frame);
    self.answerView.y = CGRectGetMaxY(self.commentView.frame);
    self.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.answerView.frame));
}

- (void)setSubModel:(IntroductionSubModel *)subModel
{
    _subModel = subModel;
    self.oneView.subModel = subModel;
    self.twoView.subModel = subModel;
    self.threeView.subModel = subModel;
    self.commentView.count = subModel.ReviewCount.integerValue;
    self.answerView.count = subModel.ProjQACount.integerValue;
    [self.oneView layoutSubviews];
    self.twoView.y = self.oneView.height;
    [self.twoView layoutSubviews];
    self.threeView.y = CGRectGetMaxY(self.twoView.frame);
    [self.threeView layoutSubviews];
    self.commentView.y = CGRectGetMaxY(self.threeView.frame);
    self.answerView.y = CGRectGetMaxY(self.commentView.frame);
    self.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.answerView.frame));

}

- (void)showAllView
{
    self.oneView.hidden = NO;
    self.twoView.hidden = NO;
    self.threeView.hidden = NO;
    self.commentView.hidden = NO;
    self.answerView.hidden = NO;
    self.bottomView.hidden = NO;
}

@end
