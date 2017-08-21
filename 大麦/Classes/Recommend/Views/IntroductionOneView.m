//
//  IntroductionOneView.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionOneView.h"

@interface IntroductionOneView ()
{
    CGFloat maxH;
}
@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *bottomView;
@property (weak, nonatomic) UILabel *addressText;
@property (weak, nonatomic) UILabel *addressTitle;
@property (weak, nonatomic) UIImageView *icon;
@property (weak, nonatomic) UILabel *addressLb;
@property (weak, nonatomic) UILabel *timeText;
@property (weak, nonatomic) UIView *faultView;
@end

@implementation IntroductionOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        maxH = 0;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [self addSubview:topView];
    self.topView = topView;
    
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 15)];
    timeLb.text = @"演出时间：";
    timeLb.textColor = [UIColor colorWithHexString:@"#838383"];
    timeLb.font = [UIFont systemFontOfSize:14];
    timeLb.width = [timeLb getTextWidth];
    timeLb.centerY = topView.height / 2;
    [topView addSubview:timeLb];
    
    UILabel *timeText = [[UILabel alloc] init];
    timeText.textColor = [UIColor colorWithHexString:@"#333333"];
    timeText.font = [UIFont systemFontOfSize:14];
    timeText.frame = CGRectMake(timeLb.width + 15, 0, ScreenWidth - timeLb.width + 5 + 15, 15);
    timeText.centerY = timeLb.centerY;
    [topView addSubview:timeText];
    self.timeText = timeText;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 49.5, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [topView addSubview:lineView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.height, ScreenWidth, 0)];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 15)];
    addressLb.text = @"演出场馆：";
    addressLb.textColor = [UIColor colorWithHexString:@"#838383"];
    addressLb.font = [UIFont systemFontOfSize:14];
    addressLb.width = [addressLb getTextWidth];
    [bottomView addSubview:addressLb];
    self.addressLb = addressLb;
    
    CGFloat addressMaxX = CGRectGetMaxX(addressLb.frame);
    UILabel *addressText = [[UILabel alloc] init];
    addressText.textColor = [UIColor colorWithHexString:@"#333333"];
    addressText.font = [UIFont systemFontOfSize:14];
    addressText.frame = CGRectMake(addressLb.width + 15, addressLb.y -1, ScreenWidth - addressMaxX - 15 - 30, 0);
    addressText.numberOfLines = 0;
    [bottomView addSubview:addressText];
    self.addressText = addressText;
    
    UILabel *addressTitle = [[UILabel alloc] init];
    addressTitle.textColor = [UIColor colorWithHexString:@"#838383"];
    addressTitle.font = [UIFont systemFontOfSize:14];
    addressTitle.frame = CGRectMake(addressText.x, 0, ScreenWidth - addressMaxX - 15 - 30, 15);
    addressTitle.numberOfLines = 0;
    [bottomView addSubview:addressTitle];
    self.addressTitle = addressTitle;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_film_more"]];
    icon.x = ScreenWidth - 15 - icon.image.size.width;
    icon.centerY = bottomView.height / 2;
    [bottomView addSubview:icon];
    self.icon = icon;
    
    UIView *faultView = [[UIView alloc] init];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    self.timeText.text = model.p.t;
}

- (void)setSubModel:(IntroductionSubModel *)subModel
{
    _subModel = subModel;
    self.addressText.text = subModel.Venue.Name;
    self.addressTitle.text = subModel.Venue.AddRess;
    CGFloat y = 0;
    for (int i = 0; i < subModel.projPromotions.count; i++) {
        IntroductionOneSubView *subView = [[IntroductionOneSubView alloc] init];
        subView.model = subModel.projPromotions[i];
        subView.x = 0;
        subView.y = y;
        subView.width = ScreenWidth;
        [self addSubview:subView];
        [subView layoutSubviews];
        y += subView.height;
        if (i == subModel.projPromotions.count - 1) {
            maxH = y;
        }
    }
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addressText.height = [self.addressText getTextHeight];
    self.addressTitle.height = [self.addressTitle getTextHeight];
    self.addressTitle.y = CGRectGetMaxY(self.addressText.frame) + 5;
    self.bottomView.height = CGRectGetMaxY(self.addressTitle.frame) + 20;
    self.icon.centerY = self.bottomView.height / 2;
    self.topView.y = maxH;
    self.bottomView.y = CGRectGetMaxY(self.topView.frame);
    self.faultView.frame = CGRectMake(0, CGRectGetMaxY(self.bottomView.frame), ScreenWidth, 5);
    self.height = CGRectGetMaxY(self.faultView.frame);
}

@end


@interface IntroductionOneSubView ()
@property (weak, nonatomic) UILabel *typeLb;
@property (weak, nonatomic) UILabel *titleLb;
@end

@implementation IntroductionOneSubView

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
    UILabel *typeLb = [[UILabel alloc] init];
    typeLb.textColor = [UIColor whiteColor];
    typeLb.backgroundColor = [UIColor colorWithHexString:@"#FD7F12"];
    typeLb.textAlignment = NSTextAlignmentCenter;
    typeLb.font = [UIFont systemFontOfSize:11];
    [self addSubview:typeLb];
    self.typeLb = typeLb;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font = [UIFont systemFontOfSize:14];
    titleLb.numberOfLines = 0;
    [self addSubview:titleLb];
    self.titleLb = titleLb;
}

- (void)setModel:(IntroductionSubFourModel *)model
{
    _model = model;
    self.typeLb.text = model.policyName;
    self.titleLb.text = model.policyDesc;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.typeLb.x = 15;
    self.typeLb.height = 15;
    self.typeLb.width = [self.typeLb getTextWidth] + 4;
    self.typeLb.y = 10;
    
    self.titleLb.x = CGRectGetMaxX(self.typeLb.frame) + 10;
    self.titleLb.y = 10;
    self.titleLb.width = ScreenWidth - self.titleLb.x - 30;
    self.titleLb.height = [self.titleLb getTextHeight];
    
    self.height = 10 + self.titleLb.height + 10;
}

@end
