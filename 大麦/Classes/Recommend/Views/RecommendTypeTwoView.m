//
//  RecommendTypeTwoView.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendTypeTwoView.h"
#import "RecommendListSubModel.h"
#import "IntroductionViewController.h"
@interface RecommendTypeTwoView ()
@property (weak, nonatomic) UIImageView *oneImg;
@property (weak, nonatomic) UIImageView *twoImg;
@end

@implementation RecommendTypeTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGFloat oneImgW = ScreenWidth / 2 - 2.5;
    CGFloat oneImgH = 80;
    UIImageView *oneImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, oneImgW, oneImgH)];
    oneImg.tag = 0;
    oneImg.userInteractionEnabled = YES;
    [oneImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)]];
    [self addSubview:oneImg];
    self.oneImg = oneImg;
    
    UIImageView *twoImg = [[UIImageView alloc] initWithFrame:CGRectMake(oneImgW + 5, 0, oneImgW, oneImgH)];
    twoImg.tag = 1;
    twoImg.userInteractionEnabled = YES;
    [twoImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)]];
    [self addSubview:twoImg];
    self.twoImg = twoImg;
}

- (void)setModelList:(NSArray *)modelList
{
    _modelList = modelList;
    
    RecommendListSubModel *oneModel = modelList.firstObject;
    [self.oneImg sd_setImageWithURL:[NSURL URLWithString:oneModel.picUrl]];
    RecommendListSubModel *twoModel = modelList.lastObject;
    [self.twoImg sd_setImageWithURL:[NSURL URLWithString:twoModel.picUrl]];
}

- (void)didClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    RecommendListSubModel *model = self.modelList[imageView.tag];
    if (model.type.integerValue == 0) {
        IntroductionViewController *vc = [[IntroductionViewController alloc] init];
        vc.dataId = model.context;
        vc.hidesBottomBarWhenPushed = YES;
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}

@end
