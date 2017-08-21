//
//  IntroductionTypeView.h
//  大麦
//
//  Created by 洪欣 on 16/12/19.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    IntroductionComment,
    IntroductionAnswer,
}IntroductionViewType;
@interface IntroductionTypeView : UIView
@property (assign, nonatomic) NSInteger count;
- (instancetype)initWithFrame:(CGRect)frame Type:(IntroductionViewType)type;
@end
