//
//  IntroductionModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionModel.h"

@implementation IntroductionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"f" : @"IntroductionTwoModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"IntroductionOneModel" : @"p"};
}

@end
