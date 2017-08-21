//
//  IntroductionBottomView.m
//  大麦
//
//  Created by 洪欣 on 16/12/19.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionBottomView.h"
#import "VerticalButton.h"

@interface IntroductionBottomView ()
@property (weak, nonatomic) UIButton *nowPayBtn;
@property (weak, nonatomic) UIButton *chooseBtn;
@end

@implementation IntroductionBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.95;
        [self setup];
    }
    return self;
}

- (void)setup
{
    VerticalButton *serviceBtn = [VerticalButton buttonWithType:UIButtonTypeCustom];
    serviceBtn.isCustom = YES;
    [serviceBtn setTitle:@"客服" forState:UIControlStateNormal];
    [serviceBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [serviceBtn setImage:[UIImage imageNamed:@"zaixiankefu"] forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    serviceBtn.frame = CGRectMake(0, 0, ScreenWidth * (1.f / 6), self.height);
    [self addSubview:serviceBtn];
    
    UIButton *nowPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nowPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"#F4153D"]];
    nowPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:nowPayBtn];
    self.nowPayBtn = nowPayBtn;
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chooseBtn setBackgroundColor:[UIColor colorWithHexString:@"#FD7F12"]];
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:chooseBtn];
    self.chooseBtn = chooseBtn;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    CGFloat chooseBtnX = ScreenWidth * (1.f / 6);
    if (model.p.IsXuanZuo && model.p.IsBuyRightNow) {
        NSString *title = @"";
        if (model.p.StatusDescn.length != 0) {
            title = @"立即预定";
        }else {
            title = @"立即购买";
        }
        [self.nowPayBtn setTitle:title forState:UIControlStateNormal];
        [self.chooseBtn setTitle:@"选座购买" forState:UIControlStateNormal];
        CGFloat width = (ScreenWidth - ScreenWidth * (1.f / 6)) / 2;
        self.chooseBtn.frame = CGRectMake(chooseBtnX, 0, width, self.height);
        self.nowPayBtn.frame = CGRectMake(chooseBtnX + width, 0, width, self.height);
    }else {
        if (model.p.IsXuanZuo) {
            [self.chooseBtn setTitle:@"选座购买" forState:UIControlStateNormal];
            self.chooseBtn.frame = CGRectMake(chooseBtnX, 0, ScreenWidth - chooseBtnX, self.height);
        }else if (model.p.IsBuyRightNow) {
            NSString *title = @"";
            if (model.p.StatusDescn.length != 0) {
                title = @"立即预定";
            }else {
                title = @"立即购买";
            }
            [self.nowPayBtn setTitle:title forState:UIControlStateNormal];
            self.nowPayBtn.frame = CGRectMake(chooseBtnX, 0, ScreenWidth - chooseBtnX, self.height);
        }else if (model.p.showResrvButton) {
            [self.nowPayBtn setTitle:@"开售提醒" forState:UIControlStateNormal];
            self.nowPayBtn.frame = CGRectMake(chooseBtnX, 0, ScreenWidth - chooseBtnX, self.height);
        }
    }
}

@end
