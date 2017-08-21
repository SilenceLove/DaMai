//
//  RecommendLikeViewCell.m
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendLikeViewCell.h"
#import "RecommendLikeModel.h"

@interface RecommendLikeViewCell ()
@property (weak, nonatomic) UIImageView *imgView;
@property (weak, nonatomic) UILabel *textLb;
@property (weak, nonatomic) UILabel *addressLb;
@property (weak, nonatomic) UILabel *timeLb;
@property (weak, nonatomic) UIView *lineView;
@end

@implementation RecommendLikeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *textLb = [[UILabel alloc] init];
    textLb.contentMode = UIViewContentModeTop;
    textLb.textColor = [UIColor blackColor];
    textLb.font = [UIFont systemFontOfSize:15];
    textLb.numberOfLines = 2;
    [self.contentView addSubview:textLb];
    self.textLb = textLb;
    
    UILabel *addressLb = [[UILabel alloc] init];
    addressLb.textColor = [UIColor colorWithHexString:@"#999999"];
    addressLb.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:addressLb];
    self.addressLb = addressLb;
    
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLb.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:timeLb];
    self.timeLb = timeLb;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

- (void)setModel:(RecommendLikeModel *)model
{
    _model = model;
    
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.id substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.id];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.textLb.text = model.name;
    self.timeLb.text = [NSString stringWithFormat:@"时间：%@",model.show_time];
    self.addressLb.text = [NSString stringWithFormat:@"场馆：%@",model.venue_name];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 5, 90, 130);
    
    CGFloat textLbX = CGRectGetMaxX(self.imgView.frame) + 15;
    CGFloat textLbY = self.imgView.y + 5;
    CGFloat textW = ScreenWidth - textLbX - 15;
    self.textLb.frame = CGRectMake(textLbX, textLbY, textW, 0);
    self.textLb.height = [self.textLb getTextHeight];
    
    CGFloat addressLbX = textLbX;
    CGFloat addressLbY = CGRectGetMaxY(self.imgView.frame) - 10 - 15;
    self.addressLb.frame = CGRectMake(addressLbX, addressLbY, textW, 15);
    
    CGFloat timeLbX = textLbX;
    CGFloat timeLbY = addressLbY - 10 - 15;
    self.timeLb.frame = CGRectMake(timeLbX, timeLbY, textW, 15);
    
    self.lineView.frame = CGRectMake(timeLbX, self.height - 0.5, ScreenWidth - timeLbX - 15, 0.5);
}


@end
