//
//  IntroductionTwoView.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionTwoView.h"
#import "IntroductionDetailsViewController.h"
@interface IntroductionTwoView ()
@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIImageView *icon;
@property (weak, nonatomic) UILabel *textView;
@property (weak, nonatomic) UIView *faultView;
@end

@implementation IntroductionTwoView

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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    topView.userInteractionEnabled = YES;
    [topView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTopViewClick)]];
    [self addSubview:topView];
    self.topView = topView;
    
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 15)];
    timeLb.text = @"项目详情";
    timeLb.textColor = [UIColor colorWithHexString:@"#000000"];
    timeLb.font = [UIFont boldSystemFontOfSize:16];
    timeLb.width = [timeLb getTextWidth];
    timeLb.centerY = topView.height / 2;
    [topView addSubview:timeLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 49.5, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    [topView addSubview:lineView];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_film_more"]];
    icon.x = ScreenWidth - 15 - icon.image.size.width;
    icon.centerY = topView.height / 2;
    [topView addSubview:icon];
    self.icon = icon;
    
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth - 40, 0)];
    textView.numberOfLines = 0;
    textView.textColor = [UIColor colorWithHexString:@"#838383"];
    textView.font = [UIFont systemFontOfSize:15];
    [self addSubview:textView];
    self.textView = textView;
    
    UIView *faultView = [[UIView alloc] init];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    
}

- (void)didTopViewClick
{
    IntroductionDetailsViewController *vc = [[IntroductionDetailsViewController alloc] init];
    vc.dataId = self.model.p.i;
    [self.getCurrentViewController.navigationController pushViewController:vc animated:YES];
}

- (void)setSubModel:(IntroductionSubModel *)subModel
{
    _subModel = subModel;
    
    NSMutableAttributedString * atbStr = [[NSMutableAttributedString alloc] initWithString:subModel.ProjDesc];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [atbStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [atbStr length])];
    
    self.textView.attributedText = atbStr;
    self.textView.height = [Tools getAttributedTextHeight:subModel.ProjDesc MaxWidth:ScreenWidth - 40 Attributes:@{NSParagraphStyleAttributeName : paragraphStyle ,NSFontAttributeName : self.textView.font}];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.y = 70;
    self.faultView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame) + 30, ScreenWidth, 5);
    self.height = CGRectGetMaxY(self.faultView.frame);
}

@end
