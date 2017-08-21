//
//  IntroductionViewModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/17.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionViewModel.h"

@implementation IntroductionViewModel

+ (void)getIntroductionDataId:(NSString *)dataId Succeed:(void (^)(IntroductionModel *))succeed Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"id" : dataId ,
                          @"source" : @"10099" ,
                          @"version" : @"50402" ,
                          @"visitorId" : @"WDlko02HVRUDAFVsiJfmDUk6"};
    
    [HttpTool getUrlWithString:@"http://mapi.damai.cn/nproj.aspx" parameters:dic success:^(id responseObject) {
        IntroductionModel *model = [IntroductionModel mj_objectWithKeyValues:responseObject];
        
        if (succeed) {
            succeed(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getIntroductionSubDataId:(NSString *)dataId Succeed:(void (^)(IntroductionSubModel *))succeed Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"id" : dataId ,
                          @"source" : @"10099" ,
                          @"version" : @"50402"};
    
    [HttpTool getUrlWithString:@"http://mapi.damai.cn/proj/ProjExpInfo.aspx" parameters:dic success:^(id responseObject) {
        IntroductionSubModel *model = [IntroductionSubModel mj_objectWithKeyValues:responseObject];
        if (succeed) {
            succeed(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
