//
//  RecommendViewModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendTypeModel;
@interface RecommendViewModel : NSObject

- (void)getCityId:(NSString *)cityId ShufflingFigureArray:(void(^)(NSArray *array))shuffling Failure:(void(^)(NSError *error))failure;

- (void)getCityId:(NSString *)cityId TypeList:(void(^)(RecommendTypeModel *model,CGFloat headerViewHeight))typeMd Failure:(void(^)(NSError *error))failure;

- (void)getCityId:(NSString *)cityId NewListModels:(void(^)(NSArray *array))models Failure:(void(^)(NSError *error))failure;

- (void)getModel:(SelectCityModel *)model LikeListModels:(void(^)(NSArray *array))models Failure:(void(^)(NSError *error))failure;
@end
