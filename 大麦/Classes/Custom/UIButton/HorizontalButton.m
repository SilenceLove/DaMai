//
//  HorizontalButton.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "HorizontalButton.h"

@implementation HorizontalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.height = 15;
    self.titleLabel.width = [self.titleLabel getTextWidth];
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.centerY = self.titleLabel.centerY;
    self.width = [self.titleLabel getTextWidth] + self.imageView.width + 5;
}

@end
