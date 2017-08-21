//
//  UITextView+Extension.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (CGFloat)getTextHeight
{
    CGSize newSize = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    return newSize.height;
}
@end
