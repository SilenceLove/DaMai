//
//  DiscoverModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverSubModel.h"
@interface DiscoverModel : NSObject
@property (copy, nonatomic) NSString *us;
@property (copy, nonatomic) NSString *usercode;
@property (copy, nonatomic) NSString *os;
@property (copy, nonatomic) NSString *error;
@property (copy, nonatomic) NSString *isIdentifyingCode;
@property (strong, nonatomic) DiscoverSubModel *data;
@end
