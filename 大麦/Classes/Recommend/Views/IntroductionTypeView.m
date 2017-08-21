//
//  IntroductionTypeView.m
//  大麦
//
//  Created by 洪欣 on 16/12/19.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionTypeView.h"

@interface IntroductionTypeView ()
@property (assign, nonatomic) IntroductionViewType type;
@property (weak, nonatomic) UILabel *numLb;
@end

@implementation IntroductionTypeView

- (instancetype)initWithFrame:(CGRect)frame Type:(IntroductionViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel *typeLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 15)];
    if (self.type == IntroductionComment) {
        typeLb.text = @"网友点评";
    }else {
        typeLb.text = @"客服答疑";
    }
    typeLb.textColor = [UIColor colorWithHexString:@"#000000"];
    typeLb.font = [UIFont boldSystemFontOfSize:16];
    typeLb.width = [typeLb getTextWidth];
    typeLb.centerY = (self.height - 5) / 2;
    [self addSubview:typeLb];
    
    CGFloat numLbX = CGRectGetMaxX(typeLb.frame) + 5;
    UILabel *numLb = [[UILabel alloc] initWithFrame:CGRectMake(numLbX, 0, ScreenWidth - numLbX - 50, 15)];
    numLb.textColor = [UIColor colorWithHexString:@"#838383"];
    numLb.font = [UIFont systemFontOfSize:15];
    numLb.centerY = typeLb.centerY;
    [self addSubview:numLb];
    self.numLb = numLb;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_film_more"]];
    icon.x = ScreenWidth - 15 - icon.image.size.width;
    icon.centerY = (self.height - 5) / 2;
    [self addSubview:icon];
    
    UIView *faultView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 5, ScreenWidth, 5)];
    faultView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:faultView];
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    self.numLb.text = [NSString stringWithFormat:@"(%ld)",count];
}

@end
