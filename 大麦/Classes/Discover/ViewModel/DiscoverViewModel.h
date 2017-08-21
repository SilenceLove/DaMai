//
//  DiscoverViewModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverHeaderModel.h"
#import "DiscoverModel.h"
@interface DiscoverViewModel : NSObject
+ (void)getHeaderDataModel:(void(^)(DiscoverHeaderModel *model))md Failure:(void(^)(NSError *error))failure;
+ (void)getCellDataPage:(NSString *)page ModelList:(void(^)(NSArray *array, NSInteger tatol))mdList Failure:(void(^)(NSError *error))failure;
@end
