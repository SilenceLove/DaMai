//
//  IntroductionHeaderView.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionModel.h"
@interface IntroductionHeaderView : UIView
@property (strong, nonatomic) IntroductionModel *model;
- (void)updateSubViewsWithScrollOffsetY:(CGFloat)y;
@end
