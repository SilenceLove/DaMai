//
//  IntroductionSubModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionSubModel.h"

@implementation IntroductionSubModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"ProjectQA" : @"IntroductionSubTwoModel",
             @"projPromotions" : @"IntroductionSubFourModel",
             @"ReviewList" : @"IntroductionSubFiveModel",
             @"ArtistList" : @"IntroductionSubSixModel"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"IntroductionSubOneModel" :@"Venue" ,
             @"IntroductionSubThreeModel" : @"basicInfo"};
}
@end
