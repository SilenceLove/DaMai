//
//  DiscoverViewModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverViewModel.h"

@implementation DiscoverViewModel

+ (void)getHeaderDataModel:(void (^)(DiscoverHeaderModel *))md Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"source" : @"10099" ,
                          @"version" : @"50402"};
    
    [HttpTool getUrlWithString:@"http://api.m.damai.cn/channel/discovery/1/list.json" parameters:dic success:^(id responseObject) {
        DiscoverHeaderModel *model = [DiscoverHeaderModel mj_objectWithKeyValues:responseObject];
        if (md) {
            md(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getCellDataPage:(NSString *)page ModelList:(void (^)(NSArray *, NSInteger))mdList Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"contentType" : @"2" ,
                          @"pageIndex" : page ,
                          @"pageSize" : @"20" ,
                          @"source" : @"10099" ,
                          @"version" : @"50402"};
    
    [HttpTool getUrlWithString:@"http://api.m.damai.cn/channel/specialcolumn/1/listByContentType.json" parameters:dic success:^(id responseObject) {
        DiscoverModel *model = [DiscoverModel mj_objectWithKeyValues:responseObject];
        if (mdList) {
            mdList(model.data.verticalItems,model.data.total);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
