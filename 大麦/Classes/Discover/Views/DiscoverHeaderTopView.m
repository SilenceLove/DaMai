//
//  DiscoverHeaderTopView.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverHeaderTopView.h"
#import "DiscoverHeaderSubOneSModel.h"
@implementation DiscoverHeaderTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)setList:(NSArray *)list
{
    _list = list;
    
    for (int i = 0 ; i < list.count ; i++) {
        DiscoverHeaderSubOneSModel *model = list[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didImageClick:)]];
        imageView.frame = CGRectMake(10 * (i + 1) + 160 * i, 10, 160, 100);
        [self addSubview:imageView];
        if (i == list.count - 1) {
            self.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame) + 10, self.height);
        }
    }
}

- (void)didImageClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
}

@end
