//
//  IntroductionHeaderView.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionHeaderView.h"
#import "IntroductionOneModel.h"
@interface IntroductionHeaderView ()
@property (weak, nonatomic) UIView *bgView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UIImageView *bgImg;
@property (weak, nonatomic) UIImageView *icon;
@property (weak, nonatomic) UILabel *textLb;
@property (weak, nonatomic) UILabel *moneyLb;
@property (weak, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic) UIView *maskView;
@end

@implementation IntroductionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.transform = CGAffineTransformMakeScale(1.8, 1.8);
    [self addSubview:bgImg];
    self.bgImg = bgImg;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bgImg.bounds;
    [bgImg addSubview:effectView];
    self.effectView = effectView;
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    maskView.frame = self.bounds;
    [self addSubview:maskView];
    self.maskView = maskView;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, 265 - 70)];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 125, bgView.height - 25)];
    [bgView addSubview:imageView];
    self.imageView = imageView;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ticket_zongdai"]];
    icon.x = 0;
    icon.y = 0;
    icon.hidden = YES;
    [imageView addSubview:icon];
    self.icon =  icon;

    CGFloat textLbX = CGRectGetMaxX(imageView.frame) + 15;
    CGFloat textLbY = imageView.y;
    UILabel *textLb = [[UILabel alloc] initWithFrame:CGRectMake(textLbX, textLbY + 5, ScreenWidth - textLbX - 15, 0)];
    textLb.numberOfLines = 3;
    textLb.textColor = [UIColor whiteColor];
    textLb.font = [UIFont boldSystemFontOfSize:18];
    [bgView addSubview:textLb];
    self.textLb = textLb;
    
    CGFloat moneyLbY = CGRectGetMaxY(imageView.frame) - 5 - 18;
    UILabel *moneyLb = [[UILabel alloc] initWithFrame:CGRectMake(textLbX, moneyLbY, textLb.width, 18)];
    moneyLb.textColor = [UIColor whiteColor];
    moneyLb.font = [UIFont systemFontOfSize:18];
    [bgView addSubview:moneyLb];
    self.moneyLb = moneyLb;
}

- (void)setModel:(IntroductionModel *)model
{
    _model = model;
    if (model.p.IsGeneralAgent.integerValue == 1) {
        self.icon.hidden = NO;
    }
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.p.i substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.p.i];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.textLb.text = model.p.n;
    self.textLb.height = [self.textLb getTextHeight];
    self.moneyLb.text = model.p.p;
    
    NSMutableArray *titles = [NSMutableArray array];
    if (model.p.StatusDescn.length == 0) {
        [titles addObject:@"售票中"];
        
        if (model.p.IsXuanZuo) {
            [titles addObject:@"座"];
        }
        if (model.p.SupportedDeductionIntegral) {
            [titles addObject:@"积分"];
        }
        
    }else {
        if (model.p.s.integerValue == 7) {
            [titles addObject:@"预订中"];
        }else if (model.p.s.integerValue == 8) {
            [titles addObject:@"预售中"];
        }
    }
    CGFloat titleX = self.textLb.x;
    CGFloat titleY = self.moneyLb.y - 37;
    CGFloat titleW = 0;
    for (int i = 0; i < titles.count; i++) {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.text = titles[i];
        titleLb.textColor = [UIColor whiteColor];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.font = [UIFont systemFontOfSize:12];
        titleLb.layer.cornerRadius = 2;
        titleLb.layer.borderColor = [UIColor whiteColor].CGColor;
        titleLb.layer.borderWidth = 0.5;
        titleLb.frame = CGRectMake(titleX + i * 5 + titleW, titleY, 0, 18);
        titleLb.width = [titleLb getTextWidth] + 8;
        titleW += titleLb.width;
        [self.bgView addSubview:titleLb];
    }
}

-(void)updateSubViewsWithScrollOffsetY:(CGFloat)y
{
    CGFloat offsetY = y;
    if (offsetY < -265) {
        self.height = -offsetY;
        CGFloat offset = -offsetY - 265;
        self.bgView.y = offset + 70;
        
        CGFloat scale = offset / 200 + 1.8;
        if (scale > 2.2) {
            scale = 2.2;
        }
        self.bgImg.transform = CGAffineTransformMakeScale(scale, scale);
    }else {
        CGFloat height = offsetY + 265;
        CGFloat scale = 1.8 - height / (265 * 1.5);
        if (scale < 1.4) {
            scale = 1.4;
        }
        self.bgImg.transform = CGAffineTransformMakeScale(scale, scale);
        self.bgView.y = 70 - height / 4;
        CGFloat minH = 265 - 64;
        if (height > minH) {
            self.height = 64;
        }else {
            self.height = 265 -  height;
        }
        self.bgView.alpha = 1 - height / minH;
    }
    self.maskView.frame = self.bounds;
}
@end
