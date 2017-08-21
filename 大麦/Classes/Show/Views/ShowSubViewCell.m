//
//  ShowSubViewCell.m
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ShowSubViewCell.h"

@interface ShowSubViewCell ()
@property (weak, nonatomic) UIImageView *imgView;
@property (weak, nonatomic) UILabel *textLb;
@property (weak, nonatomic) UILabel *addressLb;
@property (weak, nonatomic) UILabel *timeLb;
@property (weak, nonatomic) UILabel *reservationLb;
@property (weak, nonatomic) UILabel *ticketLb;
@property (weak, nonatomic) UILabel *seatLb;
@property (weak, nonatomic) UILabel *moneyLb;
@property (weak, nonatomic) UILabel *bookingLb;
@end

@implementation ShowSubViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
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
    addressLb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:addressLb];
    self.addressLb = addressLb;
    
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLb.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeLb];
    self.timeLb = timeLb;
    
    UILabel *moneyLb = [[UILabel alloc] init];
    moneyLb.textColor = [UIColor colorWithHexString:@"#F4153D"];
    moneyLb.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:moneyLb];
    self.moneyLb = moneyLb;
    
    self.reservationLb = [self createLabel:@"预售中" colorHEX:@"B3E825"];

    self.ticketLb = [self createLabel:@"售票中" colorHEX:@"F4153D"];
    
    self.seatLb = [self createLabel:@"座" colorHEX:@"24BCB9"];
    
    self.bookingLb = [self createLabel:@"预定中" colorHEX:@"FF9900"];
}

- (UILabel *)createLabel:(NSString *)str colorHEX:(NSString *)hex
{
    UILabel *label= [[UILabel alloc] init];
    label.text = str;
    label.textColor = [UIColor colorWithHexString:hex];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.layer.cornerRadius = 2;
    label.layer.borderColor = [UIColor colorWithHexString:hex].CGColor;
    label.layer.borderWidth = 0.5;
    label.height = 18;
    label.width = [label getTextWidth] + 8;
    label.hidden = YES;
    [self.contentView addSubview:label];
    return label;
}

- (void)setModel:(ShowViewCellModel *)model
{
    _model = model;
    
    NSString *urlTop = @"http://pimg.damai.cn/perform/project";
    NSString *str1 = [model.i substringToIndex:4];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@_n.jpg",urlTop,str1,model.i];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.textLb.text = model.n;
    self.timeLb.text = model.t;
    self.addressLb.text = model.VenName;
    self.moneyLb.text = model.priceName;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(15, 10, 100, 140);
    
    CGFloat textLbX = CGRectGetMaxX(self.imgView.frame) + 15;
    CGFloat textLbY = self.imgView.y + 5;
    CGFloat textW = ScreenWidth - textLbX - 15;
    self.textLb.frame = CGRectMake(textLbX, textLbY, textW, 0);
    self.textLb.height = [self.textLb getTextHeight];
    
    CGFloat moneyX = textLbX;
    CGFloat moneyY = CGRectGetMaxY(self.imgView.frame) - 15;
    self.moneyLb.frame = CGRectMake(moneyX, moneyY, 0, 15);
    self.moneyLb.width = [self.moneyLb getTextWidth];
    
    CGFloat marginX = textLbX;
    if (self.model.IsXuanZuo) {
        self.seatLb.hidden = NO;
        self.seatLb.x = marginX;
        self.seatLb.centerY = self.moneyLb.centerY;
        marginX = CGRectGetMaxX(self.seatLb.frame) + 5;
    }else {
        self.seatLb.hidden = YES;
    }
    
    if (self.model.s.integerValue == 3) {
        self.reservationLb.hidden = YES;
        self.bookingLb.hidden = YES;
        self.ticketLb.hidden = NO;
        self.ticketLb.x = marginX;
        self.ticketLb.centerY = self.moneyLb.centerY;
        marginX = CGRectGetMaxX(self.ticketLb.frame) + 5;
    }else if (self.model.s.integerValue == 7){
        self.ticketLb.hidden = YES;
        self.reservationLb.hidden = YES;
        self.bookingLb.hidden = NO;
        self.bookingLb.x = marginX;
        self.bookingLb.centerY = self.moneyLb.centerY;
        marginX = CGRectGetMaxX(self.bookingLb.frame) + 5;
    }else if (self.model.s.integerValue == 8){
        self.ticketLb.hidden = YES;
        self.bookingLb.hidden = YES;
        self.reservationLb.hidden = NO;
        self.reservationLb.x = marginX;
        self.reservationLb.centerY = self.moneyLb.centerY;
        marginX = CGRectGetMaxX(self.reservationLb.frame) + 5;
    }
    self.moneyLb.x = marginX;
    
    CGFloat addressLbX = textLbX;
    CGFloat addressLbY = moneyY - 10 - 15;
    self.addressLb.frame = CGRectMake(addressLbX, addressLbY, textW, 15);
    
    CGFloat timeLbX = textLbX;
    CGFloat timeLbY = addressLbY - 5 - 15;
    self.timeLb.frame = CGRectMake(timeLbX, timeLbY, textW, 15);
}

@end
