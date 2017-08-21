//
//  IntroductionThreeView.h
//  大麦
//
//  Created by 洪欣 on 16/12/19.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionSubModel.h"
#import "IntroductionModel.h"
@interface IntroductionThreeView : UIView
@property (strong, nonatomic) IntroductionSubModel *subModel;
@property (strong, nonatomic) IntroductionModel *model;
@end

@interface IntroductionThreeSubView : UIView
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *text;
@end
