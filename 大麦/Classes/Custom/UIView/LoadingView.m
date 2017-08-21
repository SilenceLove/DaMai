//
//  LoadingView.m
//  大麦
//
//  Created by 洪欣 on 16/12/16.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLb;
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIView *centerView = [[UIView alloc] init];
    centerView.layer.masksToBounds = YES;
    centerView.layer.cornerRadius = 5;
    centerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
    centerView.width = 110;
    centerView.height = 110;
    [self addSubview:centerView];
    self.centerView = centerView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *images = @[@"loading_image1",@"loading_image2",@"loading_image3",@"loading_image4"];
    for (int i = 0; i < images.count; i++) {
        [array addObject:[UIImage imageNamed:images[i]]];
    }
    imageView.animationImages = array;
    imageView.animationDuration = 0.1;
    imageView.width = 60;
    imageView.height = 60;
    [centerView addSubview:imageView];
    [imageView startAnimating];
    self.imageView = imageView;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = @"努力加载中";
    titleLb.textColor = [UIColor whiteColor];
    titleLb.font = [UIFont systemFontOfSize:12];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.x = 0;
    titleLb.width = centerView.width;
    titleLb.height = 15;
    [centerView addSubview:titleLb];
    self.titleLb = titleLb;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.centerView.centerX = self.width / 2;
    self.centerView.centerY = self.height / 2;
    self.imageView.centerX = self.centerView.width / 2;
    self.imageView.centerY = self.centerView.height / 2 - 10;
    self.titleLb.y = CGRectGetMaxY(self.imageView.frame) + 5;
}

@end
