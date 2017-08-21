//
//  RecommendNewViewCell.m
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendNewViewCell.h"
#import "RecommendNewModel.h"
@interface RecommendNewViewCell ()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *timeLb;
@end

@implementation RecommendNewViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.numberOfLines = 2;
    titleLb.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLb.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLb];
    self.timeLb = timeLb;
}

- (void)setModel:(RecommendNewModel *)model
{
    _model = model;
    
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.ProjectID substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.ProjectID];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.titleLb.text = model.Name;
    self.timeLb.text = model.ShowTime;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width, 160);
    
    CGFloat titleLbY = CGRectGetMaxY(self.imageView.frame) + 20;
    self.titleLb.frame = CGRectMake(0, titleLbY, self.width, 40);
    
    CGFloat timeLbY = self.height - 23;
    self.timeLb.frame = CGRectMake(0, timeLbY, self.width, 15);
}

@end
