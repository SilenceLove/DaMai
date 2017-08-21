//
//  RecommendTitleView.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendTitleView.h"

@interface RecommendTitleView ()
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *subTitleLb;
@end

@implementation RecommendTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth, 20)];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.font = [UIFont boldSystemFontOfSize:17];
    titleLb.textColor = [UIColor blackColor];
    [self addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *subTitleLb = [[UILabel alloc] init];
    subTitleLb.textColor = [UIColor colorWithHexString:@"#999999"];
    subTitleLb.textAlignment = NSTextAlignmentCenter;
    subTitleLb.font = [UIFont systemFontOfSize:13];
    [self addSubview:subTitleLb];
    self.subTitleLb = subTitleLb;
}

- (void)setModel:(RecommendListModel *)model
{
    _model = model;
    self.titleLb.text = model.title;
    if (model.subTitle.length > 0) {
        self.subTitleLb.text = model.subTitle;
        CGFloat subTitleLbY = CGRectGetMaxY(self.titleLb.frame) + 10;
        self.subTitleLb.frame = CGRectMake(0, subTitleLbY, ScreenWidth, 12);
    }
}

@end
