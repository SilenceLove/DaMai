//
//  SelectCityHeaderView.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "SelectCityHeaderView.h"

@interface SelectCityHeaderView ()
@property (weak, nonatomic) UILabel *titleLb;
@end

@implementation SelectCityHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth - 12, self.height)];
    titleLb.textColor = [UIColor colorWithHexString:@"#444444"];
    titleLb.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titleLb];
    self.titleLb = titleLb;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLb.text = title;
    if (title.length == 1) {
        self.titleLb.x = 25;
        self.titleLb.width = ScreenWidth - 25;
    }else {
        self.titleLb.x = 12;
        self.titleLb.width = ScreenWidth - 12;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLb.height = self.height;
}

@end
