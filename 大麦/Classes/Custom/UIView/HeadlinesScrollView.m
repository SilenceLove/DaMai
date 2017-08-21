//
//  HeadlinesScrollView.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "HeadlinesScrollView.h"
#import "RecommendHeadlinesModel.h"
#import "WebViewController.h"
@interface HeadlinesScrollView ()
@property (weak, nonatomic) UIButton *oneBtn;
@property (weak, nonatomic) UIButton *twoBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger index;
@end

@implementation HeadlinesScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setModels:(NSArray *)models
{
    _models = models;
    if (models.count == 0) {
        return;
    }
    self.index = 0;
    [self.timer invalidate];
    [self.oneBtn removeFromSuperview];
    [self.twoBtn removeFromSuperview];
    [self setup];
}

- (void)setup
{
    RecommendHeadlinesModel *model = self.models.firstObject;
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setTitle:model.text forState:UIControlStateNormal];
    [oneBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    oneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    oneBtn.frame = CGRectMake(0, 0, self.width, self.height);
    oneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [oneBtn addTarget:self action:@selector(didHeadlineClick) forControlEvents:UIControlEventTouchUpInside];
    [oneBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self addSubview:oneBtn];
    self.oneBtn = oneBtn;
    
    NSString *title;
    if (self.models.count > 1) {
        RecommendHeadlinesModel *model = self.models[1];
        title = model.text;
    }
    
    UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [twoBtn setTitle:title forState:UIControlStateNormal];
    [twoBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    twoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    twoBtn.frame = CGRectMake(0, self.height + 5, self.width, self.height);
    twoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [twoBtn addTarget:self action:@selector(didHeadlineClick) forControlEvents:UIControlEventTouchUpInside];
    [twoBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self addSubview:twoBtn];
    self.twoBtn = twoBtn;
    
    if (self.models.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(starScroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)didHeadlineClick
{
    RecommendHeadlinesModel *model = self.models[self.index];
    if (model.type.integerValue == 2) {
        WebViewController *vc = [[WebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.url = model.value;
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}

- (void)starScroll
{
    self.index++;
    if (self.index == self.models.count) {
        self.index = 0;
    }
    [UIView animateWithDuration:0.5f animations:^{
        self.oneBtn.y -= self.height;
        self.twoBtn.y -= self.height + 5;
    } completion:^(BOOL finished) {
        self.oneBtn.y = self.height + 5;
        
        UIButton *button = self.oneBtn;
        self.oneBtn = self.twoBtn;
        self.twoBtn = button;
        
        if (self.index < self.models.count - 1) {
            RecommendHeadlinesModel *model = self.models[self.index + 1];
            [self.twoBtn setTitle:model.text forState:UIControlStateNormal];
        }else if (self.index + 1 == self.models.count - 1) {
            RecommendHeadlinesModel *model = self.models.lastObject;
            [self.twoBtn setTitle:model.text forState:UIControlStateNormal];
        }else if (self.index == self.models.count - 1) {
            RecommendHeadlinesModel *model = self.models.firstObject;
            [self.twoBtn setTitle:model.text forState:UIControlStateNormal];
        }
    }];
}

- (void)stopScroll
{
//    [self.timer ];
}

@end
