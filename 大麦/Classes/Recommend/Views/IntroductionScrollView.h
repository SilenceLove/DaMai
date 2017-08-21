//
//  IntroductionScrollView.h
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionModel.h"
#import "IntroductionSubModel.h"
@interface IntroductionScrollView : UIScrollView
@property (strong, nonatomic) IntroductionModel *model;
@property (strong, nonatomic) IntroductionSubModel *subModel;
- (void)showAllView;
@end
