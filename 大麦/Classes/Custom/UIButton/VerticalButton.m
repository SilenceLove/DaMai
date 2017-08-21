//
//  VerticalButton.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isCustom) {
        self.imageView.width = self.currentImage.size.width;
        self.imageView.height = self.currentImage.size.height;
        self.imageView.centerX = self.width / 2;
        self.imageView.centerY = self.height / 2 - 5;
        
        self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
        self.titleLabel.width = self.width;
        self.titleLabel.height = [self.titleLabel getTextHeight];
        self.titleLabel.centerX = self.imageView.centerX;
    }else {
        self.imageView.centerX = self.width / 2;
        self.imageView.y = 0;
        self.imageView.width = self.width;
        self.imageView.height = self.width;
        
        self.titleLabel.y = self.width;
        self.titleLabel.height = 15;
        self.titleLabel.width = self.width;
        self.titleLabel.centerX = self.imageView.centerX;
        self.height = CGRectGetMaxY(self.titleLabel.frame);
    }
}

@end
