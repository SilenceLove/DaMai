//
//  RecommendTypeTwelveView.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendTypeTwelveView.h"
#import "RecommendListSubModel.h"
#import "IntroductionViewController.h"
@interface RecommendTypeTwelveView ()

@end

@implementation RecommendTypeTwelveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModelList:(NSArray *)modelList
{
    _modelList = modelList;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat imageViewW = (ScreenWidth - 15) / 4;
    for (int i = 0; i < modelList.count ; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        RecommendListSubModel *model = modelList[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)]];
        imageView.frame = CGRectMake(i * (imageViewW + 5), 0, imageViewW, imageViewW);
        [self addSubview:imageView];
    }
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
