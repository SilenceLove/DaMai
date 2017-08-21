//
//  IntroductionThreeView.m
//  大麦
//
//  Created by 洪欣 on 16/12/19.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionThreeView.h"

@interface IntroductionThreeView ()
{
    CGFloat _maxH;
}
@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UIView *faultView;
@property (weak, nonatomic) UIView *limitView;
@property (weak, nonatomic) UIView *promptView;
@property (weak, nonatomic) UIView *reservationView;
@end

@implementation IntroductionThreeView

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
    [self addSubview:topView];
    self.topView = topView;
    
    UILabel *timeLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 15)];
    timeLb.text = @"购买须知";
    timeLb.textColor = [UIColor colorWithHexString:@"#000000"];
    timeLb.font = [UIFont boldSystemFontOfSize:16];
    timeLb.width = [timeLb getTextWidth];
    timeLb.centerY = topView.height / 2;
    [topView addSubview:timeLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 49.5, ScreenWidth - 30, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    [topView addSubview:lineView];

    UIView *faultView = [[UIView alloc] init];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
    self.faultView = faultView;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    if (model.p.StatusDescn.length != 0) {
        IntroductionThreeSubView *reservationView = [[IntroductionThreeSubView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, 0)];
        reservationView.title = nil;
        reservationView.text = model.p.StatusDescn;
        [self addSubview:reservationView];
        [reservationView layoutSubviews];
        self.reservationView = reservationView;
    }
    [self layoutSubviews];
}

- (void)setSubModel:(IntroductionSubModel *)subModel
{
    _subModel = subModel;
    
    if (subModel.basicInfo.C9.length != 0) {
        IntroductionThreeSubView *limitView = [[IntroductionThreeSubView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        limitView.title = @"限购:";
        limitView.text = subModel.basicInfo.C9;
        [self addSubview:limitView];
        [limitView layoutSubviews];
        self.limitView = limitView;
    }
    if (subModel.basicInfo.C11.length != 0) {
        IntroductionThreeSubView *promptView = [[IntroductionThreeSubView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        promptView.title = @"儿童入场提示:";
        promptView.text = subModel.basicInfo.C11;
        [self addSubview:promptView];
        [promptView layoutSubviews];
        self.promptView = promptView;
    }
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.reservationView) {
        [self layoutMyView:CGRectGetMaxY(self.reservationView.frame)];
    }else {
        [self layoutMyView:50];
    }
    
    self.faultView.frame = CGRectMake(0, _maxH + 5, ScreenWidth, 5);
    self.height = _maxH + 10;
}

- (void)layoutMyView:(CGFloat)y
{
    if (self.limitView) {
        self.limitView.y = y;
        if (self.promptView) {
            self.promptView.y = CGRectGetMaxY(self.limitView.frame);
            _maxH = CGRectGetMaxY(self.promptView.frame);
        }else {
            _maxH = CGRectGetMaxY(self.limitView.frame);
        }
    }else {
        if (self.promptView) {
            self.promptView.y = y;
            _maxH = CGRectGetMaxY(self.promptView.frame);
        }else {
            _maxH = CGRectGetMaxY(self.reservationView.frame);
        }
    }
}

@end

@interface IntroductionThreeSubView ()
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *textLb;
@end

@implementation IntroductionThreeSubView

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
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.x = 18;
    titleLb.y = 20;
    titleLb.width = ScreenWidth - 36;
    titleLb.textColor = [UIColor colorWithHexString:@"#222222"];
    titleLb.font = [UIFont boldSystemFontOfSize:14];
    titleLb.numberOfLines = 0;
    [self addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *textLb = [[UILabel alloc] init];
    textLb.textColor = [UIColor colorWithHexString:@"#838383"];
    textLb.font = [UIFont systemFontOfSize:14];
    textLb.x = 18;
    textLb.width = ScreenWidth - 36;
    textLb.numberOfLines = 0;
    [self addSubview:textLb];
    self.textLb = textLb;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLb.text = title;
}

- (void)setText:(NSString *)text
{
    _text = text;
    NSMutableAttributedString * atbStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [atbStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [atbStr length])];
    self.textLb.attributedText = atbStr;
    self.textLb.height = [Tools getAttributedTextHeight:text MaxWidth:ScreenWidth - 36 Attributes:@{NSParagraphStyleAttributeName : paragraphStyle ,NSFontAttributeName : self.textLb.font}];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLb.height = [self.titleLb getTextHeight];
    self.textLb.y = CGRectGetMaxY(self.titleLb.frame) + 6;
    self.height = CGRectGetMaxY(self.textLb.frame) + 5;
}

@end
