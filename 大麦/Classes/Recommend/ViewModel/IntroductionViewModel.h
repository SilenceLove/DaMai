//
//  IntroductionViewModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroductionModel.h"
#import "IntroductionSubModel.h"
@interface IntroductionViewModel : NSObject

+ (void)getIntroductionDataId:(NSString *)dataId Succeed:(void(^)(IntroductionModel *model))succeed Failure:(void(^)(NSError *error))failure;

+ (void)getIntroductionSubDataId:(NSString *)dataId Succeed:(void(^)(IntroductionSubModel *model))succeed Failure:(void(^)(NSError *error))failure;

@end
