//
//  UILabel+Extension.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (CGFloat)getTextWidth
{
    CGSize newSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    return newSize.width;
}

- (CGFloat)getTextHeight
{
    CGSize newSize = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
  
    return newSize.height;
}

@end
