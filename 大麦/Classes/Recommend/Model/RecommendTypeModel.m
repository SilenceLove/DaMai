//
//  RecommendTypeModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendTypeModel.h"

@implementation RecommendTypeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"btnCtx" : @"RecommendTypeBtnModel",
             @"headline" : @"RecommendHeadlinesModel",
             @"list" : @"RecommendListModel"};
}

@end
