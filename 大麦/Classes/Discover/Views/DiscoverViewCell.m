//
//  DiscoverViewCell.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverViewCell.h"

@interface DiscoverViewCell ()
@property (weak, nonatomic) UIImageView *imgView;
@property (weak, nonatomic) UIImageView *maskImg;
@property (weak, nonatomic) UIImageView *lookIcon;
@property (weak, nonatomic) UIImageView *likeIcon;
@property (weak, nonatomic) UILabel *likeLb;
@property (weak, nonatomic) UILabel *lookLb;
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *subTitleLb;
@end

@implementation DiscoverViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UIImageView *maskImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mengceng"]];
    [self.contentView addSubview:maskImg];
    self.maskImg = maskImg;
    
    UIImageView *lookIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"discovery_read"]];
    [self.contentView addSubview:lookIcon];
    self.lookIcon = lookIcon;
    
    UIImageView *likeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"discovery_like"]];
    [self.contentView addSubview:likeIcon];
    self.likeIcon = likeIcon;
    
    UILabel *likeLb = [[UILabel alloc] init];
    likeLb.textColor = [UIColor whiteColor];
    likeLb.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:likeLb];
    self.likeLb = likeLb;
    
    UILabel *lookLb = [[UILabel alloc] init];
    lookLb.textColor = [UIColor whiteColor];
    lookLb.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:lookLb];
    self.lookLb = lookLb;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *subTitleLb = [[UILabel alloc] init];
    subTitleLb.textColor = [UIColor colorWithHexString:@"#888888"];
    subTitleLb.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:subTitleLb];
    self.subTitleLb = subTitleLb;
}

- (void)setModel:(DiscoverCellModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.listViewPic]];
    self.likeLb.text = model.favourCount;
    self.lookLb.text = model.readingNum;
    self.titleLb.text = model.title;
    self.subTitleLb.text = model.summary;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(5, 5, self.width - 10, 170);
    self.maskImg.frame = CGRectMake(5, 105, self.width - 10, 70);
    self.lookLb.height = 15;
    self.lookLb.y = CGRectGetMaxY(self.imgView.frame) - 10 - 15;
    self.lookLb.width = [self.lookLb getTextWidth];
    self.lookLb.x = self.width - 15 - self.lookLb.width;
    
    self.lookIcon.centerY = self.lookLb.centerY;
    self.lookIcon.x = self.lookLb.x - 5 - self.lookIcon.size.width;
    
    self.likeLb.height = 15;
    self.likeLb.centerY = self.lookIcon.centerY;
    self.likeLb.width = [self.likeLb getTextWidth];
    self.likeLb.x = self.lookIcon.x - 8 - self.likeLb.width;
    
    self.likeIcon.centerY = self.likeLb.centerY;
    self.likeIcon.x = self.likeLb.x - 5 - self.likeIcon.width;
    
    self.titleLb.x = 15;
    self.titleLb.y = 185;
    self.titleLb.height = 18;
    self.titleLb.width = self.width - 30;
    
    self.subTitleLb.x = 15;
    self.subTitleLb.y = 210;
    self.subTitleLb.height = 15;
    self.subTitleLb.width = self.width - 30;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
