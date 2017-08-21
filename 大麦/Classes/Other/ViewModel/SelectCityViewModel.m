//
//  SelectCityViewModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "SelectCityViewModel.h"
#import "SelectCityModel.h"
@implementation SelectCityViewModel

+ (void)getCityList:(void (^)(NSArray *, NSArray *, NSArray *))cityList
{
    NSDictionary *dic = @{@"source" : @"10099" ,
                          @"version" : @"50403"};
    
    [HttpTool getUrlWithString:@"https://mapi.damai.cn/NCityList.aspx" parameters:dic success:^(id responseObject) {
        NSArray *ay = [SelectCityModel mj_objectArrayWithKeyValuesArray:responseObject];
        ay = [ay subarrayWithRange:NSMakeRange(1, ay.count - 1)];
        NSArray *hotAy = [ay subarrayWithRange:NSMakeRange(0, 6)];
        NSMutableArray *cityAy = [NSMutableArray array];
        for (int i = 0 ; i < 26 ; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [cityAy addObject:array];
        }
        for (SelectCityModel *model in ay) {
            for (int i = 97; i <= 122 ; i++) {
                NSString *str = [model.PinYin substringWithRange:NSMakeRange(0, 1)];
                if ([str isEqualToString:[NSString stringWithFormat:@"%c",(char)i]]) {
                    NSMutableArray *array = cityAy[i - 97];
                    [array addObject:model];
                    break;
                }
            }
        }
        NSMutableArray *sectionAy = [NSMutableArray array];
        for (int i = 0; i < cityAy.count; i++) {
            NSArray *array = cityAy[i];
            if (array.count == 0) {
                [cityAy removeObject:array];
            }
        }
        for (NSArray *array in cityAy) {
            SelectCityModel *model = array.firstObject;
            NSString *str = [model.PinYin substringToIndex:1];
            [sectionAy addObject:str];
        }
        
        if (cityList) {
            cityList(hotAy,sectionAy,cityAy);
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
