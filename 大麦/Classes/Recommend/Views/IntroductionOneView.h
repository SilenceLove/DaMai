//
//  IntroductionOneView.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionSubFourModel.h"
#import "IntroductionSubModel.h"
#import "IntroductionModel.h"
@interface IntroductionOneView : UIView
@property (strong, nonatomic) IntroductionSubModel *subModel;
@property (strong, nonatomic) IntroductionModel *model;
@end

@interface IntroductionOneSubView : UIView
@property (strong, nonatomic) IntroductionSubFourModel *model;
@end
