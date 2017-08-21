//
//  SelectCityViewModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectCityViewModel : NSObject

+ (void)getCityList:(void(^)(NSArray *hotList,NSArray *sectionList,NSArray *cityList))cityList;

@end
