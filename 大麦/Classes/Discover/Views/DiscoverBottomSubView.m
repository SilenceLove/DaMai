//
//  DiscoverBottomSubView.m
//  大麦
//
//  Created by 洪欣 on 16/12/23.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverBottomSubView.h"
#import "CountdownView.h"

@interface DiscoverBottomSubView ()<CountdownViewDelegate>
@property (weak, nonatomic) CountdownView *countdownView;
@property (weak, nonatomic) UIImageView *icon;
@property (weak, nonatomic) UILabel *iconLb;
@property (weak, nonatomic) UILabel *ongoingLb;
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *textLb;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UIButton *button;
@end

@implementation DiscoverBottomSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_camera_capture_pressed"]];
    icon.width = 20;
    icon.height = 20;
    [self addSubview:icon];
    self.icon = icon;
    
    UIImageView *subIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_camera_flash_on"]];
    [icon addSubview:subIcon];
    subIcon.width = 18;
    subIcon.height = 18;
    subIcon.centerX = icon.width / 2;
    subIcon.centerY = icon.height / 2;
    
    UILabel *iconLb = [[UILabel alloc] init];
    iconLb.textColor = [UIColor blackColor];
    iconLb.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:iconLb];
    self.iconLb = iconLb;
    
    UILabel *ongoingLb = [[UILabel alloc] init];
    ongoingLb.text = @"活动火爆进行中...";
    ongoingLb.textColor = [UIColor colorWithHexString:@"#555555"];
    ongoingLb.font = [UIFont systemFontOfSize:13];
    ongoingLb.height = 15;
    ongoingLb.width = [ongoingLb getTextWidth];
    [self addSubview:ongoingLb];
    self.ongoingLb = ongoingLb;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor colorWithHexString:@"#F4153D"];
    titleLb.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *textLb = [[UILabel alloc] init];
    textLb.textColor = [UIColor colorWithHexString:@"#222222"];
    textLb.font = [UIFont systemFontOfSize:14];
    [self addSubview:textLb];
    self.textLb = textLb;
    
    CountdownView *countdownView = [[CountdownView alloc] init];
    countdownView.delegate = self;
    [self addSubview:countdownView];
    self.countdownView = countdownView;
    [self.countdownView layoutSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    self.button = button;
}

- (void)countdownComplete
{
    [self.countdownView removeFromSuperview];
    self.ongoingLb.hidden = NO;
}

- (void)setModel:(DiscoverHeaderSubOneSModel *)model
{
    _model = model;
    
    if ([NSDate isCurrentDate:model.startTime]) {
        self.countdownView.hidden = YES;
        self.ongoingLb.hidden = NO;
    }else {
        self.ongoingLb.hidden = YES;
        self.countdownView.hidden = NO;
    }
    self.countdownView.timeStr = model.startTime;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.titleLb.text = model.priceStr;
    self.textLb.text = model.title;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.iconLb.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.x = 25;
    self.icon.y = 15;
    
    self.iconLb.height = 15;
    self.iconLb.width = [self.iconLb getTextWidth];
    self.iconLb.centerY = self.icon.centerY;
    self.iconLb.x = CGRectGetMaxX(self.icon.frame) + 5;
    
    self.countdownView.x = self.icon.x;
    self.countdownView.y = CGRectGetMaxY(self.icon.frame) + 5;
    self.countdownView.width = ScreenWidth / 2;
    
    self.ongoingLb.x = self.icon.x;
    self.ongoingLb.centerY = self.countdownView.centerY;
    
    self.titleLb.x = self.icon.x;
    self.titleLb.y = CGRectGetMaxY(self.countdownView.frame) + 10;
    self.titleLb.height = 15;
    self.titleLb.width = [self.titleLb getTextWidth];
    
    self.textLb.x = self.icon.x;
    self.textLb.y = CGRectGetMaxY(self.titleLb.frame) + 10;
    self.textLb.height = 15;
    self.textLb.width = [self.textLb getTextWidth];
    
    self.imageView.width = 100;
    self.imageView.height = 100;
    self.imageView.x = ScreenWidth - 10 - self.imageView.width;
    self.imageView.y = self.icon.y;
    
    self.button.x = self.imageView.x;
    self.button.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.button.width = self.imageView.width;
    self.button.height = 30;
}

@end
